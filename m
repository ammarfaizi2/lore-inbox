Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVAMWNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVAMWNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVAMWMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:12:51 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:40709 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261740AbVAMV61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:27 -0500
Subject: [patch 06/11] uml: allow free ubd flag ordering
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:01:00 +0100
Message-Id: <20050113210101.0A34F1FB6F@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When parsing the <flags> section in ubd<n><flags>=file[,file2], instead of
requiring that the flags are specified in a certain order, just make the code
smarter.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c |   48 +++++++++++++++-----------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-free-flag-ordering arch/um/drivers/ubd_kern.c
--- linux-2.6.11/arch/um/drivers/ubd_kern.c~uml-ubd-free-flag-ordering	2005-01-13 03:11:22.564889912 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c	2005-01-13 03:11:22.567889456 +0100
@@ -250,7 +250,7 @@ static int ubd_setup_common(char *str, i
 	struct ubd *dev;
 	struct openflags flags = global_openflags;
 	char *backing_file;
-	int n, err;
+	int n, err, i;
 
 	if(index_out) *index_out = -1;
 	n = *str;
@@ -312,29 +312,40 @@ static int ubd_setup_common(char *str, i
 	dev = &ubd_dev[n];
 	if(dev->file != NULL){
 		printk(KERN_ERR "ubd_setup : device already configured\n");
-		goto out2;
+		goto out;
 	}
 
-	if(index_out) *index_out = n;
+	if (index_out)
+		*index_out = n;
 
-	if (*str == 'r'){
-		flags.w = 0;
-		str++;
-	}
-	if (*str == 's'){
-		flags.s = 1;
-		str++;
-	}
-	if (*str == 'd'){
-		dev->no_cow = 1;
+	for (i = 0; i < 4; i++) {
+		switch (*str) {
+		case 'r':
+			flags.w = 0;
+			break;
+		case 's':
+			flags.s = 1;
+			break;
+		case 'd':
+			dev->no_cow = 1;
+			break;
+		case '=':
+			str++;
+			goto break_loop;
+		default:
+			printk(KERN_ERR "ubd_setup : Expected '=' or flag letter (r,s or d)\n");
+			goto out;
+		}
 		str++;
 	}
 
-	if(*str++ != '='){
+        if (*str == '=')
+		printk(KERN_ERR "ubd_setup : Too many flags specified\n");
+        else
 		printk(KERN_ERR "ubd_setup : Expected '='\n");
-		goto out2;
-	}
+	goto out;
 
+break_loop:
 	err = 0;
 	backing_file = strchr(str, ',');
 
@@ -354,7 +365,7 @@ static int ubd_setup_common(char *str, i
 	dev->file = str;
 	dev->cow.file = backing_file;
 	dev->boot_openflags = flags;
- out2:
+out:
 	spin_unlock(&ubd_lock);
 	return(err);
 }
@@ -385,8 +396,7 @@ __uml_help(ubd_setup,
 "    machine by running 'dd' on the device. <n> must be in the range\n"
 "    0 to 7. Appending an 'r' to the number will cause that device\n"
 "    to be mounted read-only. For example ubd1r=./ext_fs. Appending\n"
-"    an 's' (has to be _after_ 'r', if there is one) will cause data\n"
-"    to be written to disk on the host immediately.\n\n"
+"    an 's' will cause data to be written to disk on the host immediately.\n\n"
 );
 
 static int fakehd_set = 0;
_
