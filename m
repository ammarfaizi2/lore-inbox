Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWHVLz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWHVLz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHVLz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:55:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23218 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751371AbWHVLz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:55:26 -0400
Date: Tue, 22 Aug 2006 12:55:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: [PATCH] kevent_user: use struct kevent_mring for the page ring
Message-ID: <20060822115504.GB10839@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <12345678912345.GA1898@2ka.mipt.ru> <11561555871530@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11561555871530@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently struct kevent_user.print is an array of unsigned long, but it's used
as an array of pointers to struct kevent_mring everyewhere in the code.

Switch it to use the real type and cast the return value from __get_free_page /
argument to free_page.


 include/linux/kevent.h      |    2 +-
 kernel/kevent/kevent_user.c |   31 +++++++++++--------------------
  2 files changed, 12 insertions(+), 21 deletions(-)

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/linux/kevent.h
===================================================================
--- linux-2.6.orig/include/linux/kevent.h	2006-08-22 12:10:24.000000000 +0200
+++ linux-2.6/include/linux/kevent.h	2006-08-22 13:30:48.000000000 +0200
@@ -105,7 +105,7 @@
 	
 	unsigned int		pages_in_use;
 	/* Array of pages forming mapped ring buffer */
-	unsigned long		*pring;
+	struct kevent_mring	**pring;
 
 #ifdef CONFIG_KEVENT_USER_STAT
 	unsigned long		im_num;
Index: linux-2.6/kernel/kevent/kevent_user.c
===================================================================
--- linux-2.6.orig/kernel/kevent/kevent_user.c	2006-08-22 13:28:06.000000000 +0200
+++ linux-2.6/kernel/kevent/kevent_user.c	2006-08-22 13:43:46.000000000 +0200
@@ -69,30 +69,21 @@
 
 static inline void kevent_user_ring_set(struct kevent_user *u, unsigned int num)
 {
-	struct kevent_mring *ring;
-
-	ring = (struct kevent_mring *)u->pring[0];
-	ring->index = num;
+	u->pring[0]->index = num;
 }
 
 static inline void kevent_user_ring_inc(struct kevent_user *u)
 {
-	struct kevent_mring *ring;
-
-	ring = (struct kevent_mring *)u->pring[0];
-	ring->index++;
+	u->pring[0]->index++;
 }
 
 static int kevent_user_ring_grow(struct kevent_user *u)
 {
-	struct kevent_mring *ring;
 	unsigned int idx;
 
-	ring = (struct kevent_mring *)u->pring[0];
-
-	idx = (ring->index + 1) / KEVENTS_ON_PAGE;
+	idx = (u->pring[0]->index + 1) / KEVENTS_ON_PAGE;
 	if (idx >= u->pages_in_use) {
-		u->pring[idx] = __get_free_page(GFP_KERNEL);
+		u->pring[idx] = (void *)__get_free_page(GFP_KERNEL);
 		if (!u->pring[idx])
 			return -ENOMEM;
 		u->pages_in_use++;
@@ -108,12 +99,12 @@
 	unsigned int pidx, off;
 	struct kevent_mring *ring, *copy_ring;
 
-	ring = (struct kevent_mring *)k->user->pring[0];
-	
+	ring = k->user->pring[0];
+
 	pidx = ring->index/KEVENTS_ON_PAGE;
 	off = ring->index%KEVENTS_ON_PAGE;
 
-	copy_ring = (struct kevent_mring *)k->user->pring[pidx];
+	copy_ring = k->user->pring[pidx];
 
 	copy_ring->event[off].id.raw[0] = k->event.id.raw[0];
 	copy_ring->event[off].id.raw[1] = k->event.id.raw[1];
@@ -134,11 +125,11 @@
 
 	pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct mukevent) + sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
 
-	u->pring = kmalloc(pnum * sizeof(unsigned long), GFP_KERNEL);
+	u->pring = kmalloc(pnum * sizeof(struct kevent_mring *), GFP_KERNEL);
 	if (!u->pring)
 		return -ENOMEM;
 
-	u->pring[0] = __get_free_page(GFP_KERNEL);
+	u->pring[0] = (struct kevent_mring *)__get_free_page(GFP_KERNEL);
 	if (!u->pring[0])
 		goto err_out_free;
 
@@ -158,7 +149,7 @@
 	int i;
 	
 	for (i = 0; i < u->pages_in_use; ++i)
-		free_page(u->pring[i]);
+		free_page((unsigned long)u->pring[i]);
 
 	kfree(u->pring);
 }
@@ -254,7 +245,7 @@
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_file = file;
 
-	if (vm_insert_page(vma, start, virt_to_page((void *)u->pring[0])))
+	if (vm_insert_page(vma, start, virt_to_page(u->pring[0])))
 		return -EFAULT;
 
 	return 0;
