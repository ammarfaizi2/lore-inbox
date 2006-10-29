Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965332AbWJ2TUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbWJ2TUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965339AbWJ2TUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:46 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:49564 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965331AbWJ2TU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=Du8CYAgdBuZbrcRQDynCWeeTc8CDHCF/ScFmR+6H1KGH4O0YUVdTDW0TC59vJjvk1gl05SZh31iDDzYQyPhUhvh8VSjM632ZlvvsxJUYNKQ+F/mlNJUteWC3A8PV0nueBghFqe5YHyELiJ3PGYksun1zEmYaAX4vCLR9NMZQxYY=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/11] uml ubd driver: give better names to some functions.
Date: Sun, 29 Oct 2006 20:20:33 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192033.12292.72082.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To rethink locking, I needed to understand well what each function does. While
doing this I renamed some:

* ubd_close -> ubd_close_dev (since it pairs with ubd_open_dev)

* ubd_new_disk -> ubd_disk_register (it handles registration with the block
  layer - one hopes this makes clearer the difference with ubd_add())

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 50385cc..23663b7 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -552,7 +552,7 @@ static int ubd_file_size(struct ubd *ubd
 	return(os_file_size(file, size_out));
 }
 
-static void ubd_close(struct ubd *ubd_dev)
+static void ubd_close_dev(struct ubd *ubd_dev)
 {
 	os_close_file(ubd_dev->fd);
 	if(ubd_dev->cow.file == NULL)
@@ -629,7 +629,7 @@ static void dummy_device_release(struct
 {
 }
 
-static int ubd_new_disk(int major, u64 size, int unit,
+static int ubd_disk_register(int major, u64 size, int unit,
 			struct gendisk **disk_out)
 			
 {
@@ -682,12 +682,12 @@ static int ubd_add(int n)
 
 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
 
-	err = ubd_new_disk(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
+	err = ubd_disk_register(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
 	if(err)
 		goto out;
 
 	if(fake_major != MAJOR_NR)
-		ubd_new_disk(fake_major, ubd_dev->size, n,
+		ubd_disk_register(fake_major, ubd_dev->size, n,
 			     &fake_gendisk[n]);
 
 	/* perhaps this should also be under the "if (fake_major)" above */
@@ -904,7 +904,7 @@ static int ubd_open(struct inode *inode,
 	/* This should no more be needed. And it didn't work anyway to exclude
 	 * read-write remounting of filesystems.*/
 	/*if((filp->f_mode & FMODE_WRITE) && !ubd_dev->openflags.w){
-	        if(--ubd_dev->count == 0) ubd_close(ubd_dev);
+	        if(--ubd_dev->count == 0) ubd_close_dev(ubd_dev);
 	        err = -EROFS;
 	}*/
  out:
@@ -917,7 +917,7 @@ static int ubd_release(struct inode * in
 	struct ubd *ubd_dev = disk->private_data;
 
 	if(--ubd_dev->count == 0)
-		ubd_close(ubd_dev);
+		ubd_close_dev(ubd_dev);
 	return(0);
 }
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
