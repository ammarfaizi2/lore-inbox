Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965343AbWJ2TUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965343AbWJ2TUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbWJ2TUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:47 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:51100 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965332AbWJ2TUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=xfLfIY4CgNaaXz4o+XwaVGftgYfKTRCd8GaIaLiEqrnd5StsTlVOc54xRLsPHVUNyhKBe2OXgkgbBJVk6QMbes1hBWOG+9uy4Gw3PxO2DmOqaFWO/CfMfi+DOf86BZAiekzas1HX7ot4wRHACCBIb1wy1YIsGxMaw8KwOTkj0KE=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/11] uml ubd driver: change ubd_lock to be a mutex
Date: Sun, 29 Oct 2006 20:20:35 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192035.12292.67673.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This lock protects ubd setup and teardown, so is only used in process context;
beyond that, during such setup memory allocations must be performed and some
generic functions which can sleep must be called (such as add_disk()). So
the only correct solution is to make it a mutex instead of a spin_lock.
No other change is done - this lock must be acquired in different places but
it's done afterwards.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 23663b7..e4fd29a 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -107,7 +107,8 @@ static inline void ubd_set_bit(__u64 bit
 #define DRIVER_NAME "uml-blkdev"
 
 static DEFINE_SPINLOCK(ubd_io_lock);
-static DEFINE_SPINLOCK(ubd_lock);
+
+static DEFINE_MUTEX(ubd_lock);
 
 static void (*do_ubd)(void);
 
@@ -314,7 +315,7 @@ static int ubd_setup_common(char *str, i
 		}
 
 		err = 1;
- 		spin_lock(&ubd_lock);
+ 		mutex_lock(&ubd_lock);
  		if(fake_major != MAJOR_NR){
  			printk(KERN_ERR "Can't assign a fake major twice\n");
  			goto out1;
@@ -326,7 +327,7 @@ static int ubd_setup_common(char *str, i
 		       major);
  		err = 0;
  	out1:
- 		spin_unlock(&ubd_lock);
+ 		mutex_unlock(&ubd_lock);
 		return(err);
 	}
 
@@ -343,7 +344,7 @@ static int ubd_setup_common(char *str, i
 	}
 
 	err = 1;
-	spin_lock(&ubd_lock);
+	mutex_lock(&ubd_lock);
 
 	ubd_dev = &ubd_devs[n];
 	if(ubd_dev->file != NULL){
@@ -405,7 +406,7 @@ break_loop:
 	ubd_dev->cow.file = backing_file;
 	ubd_dev->boot_openflags = flags;
 out:
-	spin_unlock(&ubd_lock);
+	mutex_unlock(&ubd_lock);
 	return(err);
 }
 
@@ -716,11 +717,11 @@ static int ubd_config(char *str)
 	}
 	if(n == -1) return(0);
 
- 	spin_lock(&ubd_lock);
+ 	mutex_lock(&ubd_lock);
 	err = ubd_add(n);
 	if(err)
 		ubd_devs[n].file = NULL;
- 	spin_unlock(&ubd_lock);
+ 	mutex_unlock(&ubd_lock);
 
 	return(err);
 }
@@ -737,7 +738,7 @@ static int ubd_get_config(char *name, ch
 	}
 
 	ubd_dev = &ubd_devs[n];
-	spin_lock(&ubd_lock);
+	mutex_lock(&ubd_lock);
 
 	if(ubd_dev->file == NULL){
 		CONFIG_CHUNK(str, size, len, "", 1);
@@ -753,7 +754,7 @@ static int ubd_get_config(char *name, ch
 	else CONFIG_CHUNK(str, size, len, "", 1);
 
  out:
-	spin_unlock(&ubd_lock);
+	mutex_unlock(&ubd_lock);
 	return(len);
 }
 
@@ -772,7 +773,7 @@ static int ubd_remove(int n)
 	struct ubd *ubd_dev;
 	int err = -ENODEV;
 
-	spin_lock(&ubd_lock);
+	mutex_lock(&ubd_lock);
 
 	if(ubd_gendisk[n] == NULL)
 		goto out;
@@ -801,7 +802,7 @@ static int ubd_remove(int n)
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
 out:
-	spin_unlock(&ubd_lock);
+	mutex_unlock(&ubd_lock);
 	return err;
 }
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
