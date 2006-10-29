Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWJ2TVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWJ2TVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbWJ2TU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:56 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:58268 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965326AbWJ2TUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=iz2sx+cCfbDo10dDf+LtGDgyrBObGfJeydlKP19VPozWkxssuecuua7QQ8cz68lX2wC77e3hM2qNjMUXRAnjJi1KrY78kcQ3AMVGln+kJTafzqylYx3MNaqd7BnyY+NRtObPtj9UhNpZO3rBtj476ueeK+PAY8cvnpu54kOopNM=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/11] uml ubd driver: do not store error codes as ->fd
Date: Sun, 29 Oct 2006 20:20:49 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192049.12292.24192.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To simplify error handling, make sure fd is saved into ubd_dev->fd only when we
are sure it is an fd and not an error code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 66dc23d..641782e 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -578,33 +578,36 @@ static int ubd_open_dev(struct ubd *ubd_
 	struct openflags flags;
 	char **back_ptr;
 	int err, create_cow, *create_ptr;
+	int fd;
 
 	ubd_dev->openflags = ubd_dev->boot_openflags;
 	create_cow = 0;
 	create_ptr = (ubd_dev->cow.file != NULL) ? &create_cow : NULL;
 	back_ptr = ubd_dev->no_cow ? NULL : &ubd_dev->cow.file;
-	ubd_dev->fd = open_ubd_file(ubd_dev->file, &ubd_dev->openflags, ubd_dev->shared,
+
+	fd = open_ubd_file(ubd_dev->file, &ubd_dev->openflags, ubd_dev->shared,
 				back_ptr, &ubd_dev->cow.bitmap_offset,
 				&ubd_dev->cow.bitmap_len, &ubd_dev->cow.data_offset,
 				create_ptr);
 
-	if((ubd_dev->fd == -ENOENT) && create_cow){
-		ubd_dev->fd = create_cow_file(ubd_dev->file, ubd_dev->cow.file,
+	if((fd == -ENOENT) && create_cow){
+		fd = create_cow_file(ubd_dev->file, ubd_dev->cow.file,
 					  ubd_dev->openflags, 1 << 9, PAGE_SIZE,
 					  &ubd_dev->cow.bitmap_offset,
 					  &ubd_dev->cow.bitmap_len,
 					  &ubd_dev->cow.data_offset);
-		if(ubd_dev->fd >= 0){
+		if(fd >= 0){
 			printk(KERN_INFO "Creating \"%s\" as COW file for "
 			       "\"%s\"\n", ubd_dev->file, ubd_dev->cow.file);
 		}
 	}
 
-	if(ubd_dev->fd < 0){
+	if(fd < 0){
 		printk("Failed to open '%s', errno = %d\n", ubd_dev->file,
-		       -ubd_dev->fd);
-		return(ubd_dev->fd);
+		       -fd);
+		return fd;
 	}
+	ubd_dev->fd = fd;
 
 	if(ubd_dev->cow.file != NULL){
 		err = -ENOMEM;
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
