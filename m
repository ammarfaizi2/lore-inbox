Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWDGOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWDGOel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWDGOc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:29 -0400
Received: from [151.97.230.9] ([151.97.230.9]:32220 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932342AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 13/17] uml: fix failure path after conversion
Date: Fri, 07 Apr 2006 16:31:20 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143119.19201.41577.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Little fix for error paths in this code.
*) Some bug come from conversion to os-Linux (open() doesn't follow
the kernel -errno return convention, while the old code called os_open_file()
which followed it). This caused the wrong return code to be printed.
*) Then be more precise about what happened and do some whitespace fixes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/umid.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 198e591..34bfc1b 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -120,7 +120,8 @@ static int not_dead_yet(char *dir)
 
 	dead = 0;
 	fd = open(file, O_RDONLY);
-	if(fd < 0){
+	if(fd < 0) {
+		fd = -errno;
 		if(fd != -ENOENT){
 			printk("not_dead_yet : couldn't open pid file '%s', "
 			       "err = %d\n", file, -fd);
@@ -130,9 +131,13 @@ static int not_dead_yet(char *dir)
 
 	err = 0;
 	n = read(fd, pid, sizeof(pid));
-	if(n <= 0){
+	if(n < 0){
+		printk("not_dead_yet : couldn't read pid file '%s', "
+		       "err = %d\n", file, errno);
+		goto out_close;
+	} else if(n == 0){
 		printk("not_dead_yet : couldn't read pid file '%s', "
-		       "err = %d\n", file, -n);
+		       "0-byte read\n", file);
 		goto out_close;
 	}
 
@@ -155,9 +160,9 @@ static int not_dead_yet(char *dir)
 
 	return err;
 
- out_close:
+out_close:
 	close(fd);
- out:
+out:
 	return 0;
 }
 
