Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSGEXLJ>; Fri, 5 Jul 2002 19:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSGEXLI>; Fri, 5 Jul 2002 19:11:08 -0400
Received: from e114042.upc-e.chello.nl ([213.93.114.42]:12292 "EHLO
	walton.kettenis.dyndns.org") by vger.kernel.org with ESMTP
	id <S317597AbSGEXLI>; Fri, 5 Jul 2002 19:11:08 -0400
From: Mark Kettenis <kettenis@chello.nl>
Message-Id: <200207052313.g65NDbk00667@elgar.kettenis.dyndns.org>
Date: Sat, 6 Jul 2002 01:08:46 +0200 (CEST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix note sections in ELF core dumps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edition 4.1 of the System V Application Binary Interface says that
"The first namesz bytes in name contains a null-terminated
representation of the entry's owner or originator".  This implies that
the terminating null is included in namesz, which is corroborated by
the example that follows the description.  However, this is not what
the Linux kernel does when it writes its notes into an ELF core dump.
The attached patch fixes this.

Mark

--- linux-2.5.24/fs/binfmt_elf.c.orig	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24/fs/binfmt_elf.c	Sat Jul  6 00:43:33 2002
@@ -954,7 +954,7 @@
 	int sz;
 
 	sz = sizeof(struct elf_note);
-	sz += roundup(strlen(en->name), 4);
+	sz += roundup(strlen(en->name) + 1, 4);
 	sz += roundup(en->datasz, 4);
 
 	return sz;
@@ -989,7 +989,7 @@
 {
 	struct elf_note en;
 
-	en.n_namesz = strlen(men->name);
+	en.n_namesz = strlen(men->name) + 1;
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
 
