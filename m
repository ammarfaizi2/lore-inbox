Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVGKHSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVGKHSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 03:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGKHSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 03:18:33 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:48037 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261174AbVGKHSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 03:18:33 -0400
Message-ID: <42D21D43.3060300@cosmosbay.com>
Date: Mon, 11 Jul 2005 09:18:27 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] eventpoll : Suppress a short lived lock from struct file
References: <4263275A.2020405@lab.ntt.co.jp>  <20050418040718.GA31163@taniwha.stupidest.org>  <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org> <1113800136.355.1.camel@localhost.localdomain> <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>
Content-Type: multipart/mixed;
 boundary="------------050108000305010700040301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108000305010700040301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Davide

I found in my tests that there is no need to have a f_ep_lock spinlock
attached to each struct file, using 8 bytes on 64bits platforms. The
lock is hold for a very short time period and can be global, with almost
no change in performance for applications using epoll, and a gain for
all others.

Thank you
Eric Dumazet

[PATCH] eventpoll : Suppress a short lived lock from struct file

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------050108000305010700040301
Content-Type: text/plain;
 name="patch_eventpoll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_eventpoll"

--- linux-2.6.12/fs/eventpoll.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-ed/fs/eventpoll.c	2005-07-11 08:56:07.000000000 +0200
@@ -179,6 +179,8 @@
 	spinlock_t lock;
 };
 
+static DEFINE_SPINLOCK(f_ep_lock);
+
 /*
  * This structure is stored inside the "private_data" member of the file
  * structure and rapresent the main data sructure for the eventpoll
@@ -426,7 +428,6 @@
 {
 
 	INIT_LIST_HEAD(&file->f_ep_links);
-	spin_lock_init(&file->f_ep_lock);
 }
 
 
@@ -967,9 +968,9 @@
 		goto eexit_2;
 
 	/* Add the current item to the list of active epoll hook for this file */
-	spin_lock(&tfile->f_ep_lock);
+	spin_lock(&f_ep_lock);
 	list_add_tail(&epi->fllink, &tfile->f_ep_links);
-	spin_unlock(&tfile->f_ep_lock);
+	spin_unlock(&f_ep_lock);
 
 	/* We have to drop the new item inside our item list to keep track of it */
 	write_lock_irqsave(&ep->lock, flags);
@@ -1160,7 +1161,6 @@
 {
 	int error;
 	unsigned long flags;
-	struct file *file = epi->ffd.file;
 
 	/*
 	 * Removes poll wait queue hooks. We _have_ to do this without holding
@@ -1173,10 +1173,10 @@
 	ep_unregister_pollwait(ep, epi);
 
 	/* Remove the current item from the list of epoll hooks */
-	spin_lock(&file->f_ep_lock);
+	spin_lock(&f_ep_lock);
 	if (EP_IS_LINKED(&epi->fllink))
 		EP_LIST_DEL(&epi->fllink);
-	spin_unlock(&file->f_ep_lock);
+	spin_unlock(&f_ep_lock);
 
 	/* We need to acquire the write IRQ lock before calling ep_unlink() */
 	write_lock_irqsave(&ep->lock, flags);
--- linux-2.6.12/include/linux/fs.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-ed/include/linux/fs.h	2005-07-11 08:58:02.000000000 +0200
@@ -597,7 +597,6 @@
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */
 	struct list_head	f_ep_links;
-	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
 };

--------------050108000305010700040301--
