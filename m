Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTLFWRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbTLFWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:17:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:35803 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265266AbTLFWR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:17:28 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 6 Dec 2003 23:17:22 +0100 (MET)
Message-Id: <UTC200312062217.hB6MHM118492.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH - RFC] number of Solaris slices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People tell me that SOLARIS_X86_NUMSLICE should be 16 instead of 8.
And it seems there is some truth in that.

On the other hand, there have certainly been times that 8 was the
right number. Instead of using a define for the number of slices
(partitions, if you prefer), is it OK for all Solaris versions to
use v->v_nparts?

Andries

--- /linux/2.6/linux-2.6.0-test11/linux/fs/partitions/msdos.c	Wed Nov 26 21:44:30 2003
+++ ./msdos.c	Sat Dec  6 22:55:58 2003
@@ -170,7 +170,7 @@
 #ifdef CONFIG_SOLARIS_X86_PARTITION
 	Sector sect;
 	struct solaris_x86_vtoc *v;
-	int i;
+	int i, numslices;
 
 	v = (struct solaris_x86_vtoc *)read_dev_sector(bdev, offset+1, &sect);
 	if (!v)
@@ -186,7 +186,12 @@
 		put_dev_sector(sect);
 		return;
 	}
-	for (i=0; i<SOLARIS_X86_NUMSLICE && state->next<state->limit; i++) {
+
+	numslices = v->v_nparts;
+	if (numslices > SOLARIS_X86_NUMSLICE)
+		numslices = SOLARIS_X86_NUMSLICE;
+
+	for (i=0; i<numslices && state->next<state->limit; i++) {
 		struct solaris_x86_slice *s = &v->v_slice[i];
 		if (s->s_size == 0)
 			continue;
--- /linux/2.6/linux-2.6.0-test11/linux/include/linux/genhd.h	Wed Nov 26 21:43:08 2003
+++ ./genhd.h	Sat Dec  6 22:53:06 2003
@@ -212,7 +212,7 @@
 
 #ifdef CONFIG_SOLARIS_X86_PARTITION
 
-#define SOLARIS_X86_NUMSLICE	8
+#define SOLARIS_X86_NUMSLICE	16
 #define SOLARIS_X86_VTOC_SANE	(0x600DDEEEUL)
 
 struct solaris_x86_slice {
