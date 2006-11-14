Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965589AbWKNNBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589AbWKNNBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWKNNBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:01:24 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:8163 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965589AbWKNNBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:01:16 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       magnus.damm@gmail.com, Magnus Damm <magnus@valinux.co.jp>,
       Horms <horms@verge.net.au>, Dave Anderson <anderson@redhat.com>,
       ebiederm@xmission.com, Jakub Jelinek <jakub@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Tue, 14 Nov 2006 22:01:14 +0900
Message-Id: <20061114130114.24180.76834.sendpatchset@localhost>
In-Reply-To: <20061114130057.24180.34095.sendpatchset@localhost>
References: <20061114130057.24180.34095.sendpatchset@localhost>
Subject: [PATCH 03/03] Elf: Fix kcore note size calculation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elf: fix kcore note size calculation

- Define "CORE" string as CORE_STR in single common place.
- Include terminating zero in CORE_STR length calculation for elf_buflen.
- Use roundup(,4) to include alignment in elf_buflen calculation.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 fs/proc/kcore.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- 0002/fs/proc/kcore.c
+++ work/fs/proc/kcore.c	2006-11-14 21:17:16.000000000 +0900
@@ -22,6 +22,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#define CORE_STR "CORE"
 
 static int open_kcore(struct inode * inode, struct file * filp)
 {
@@ -82,10 +83,11 @@ static size_t get_kcore_size(int *nphdr,
 	}
 	*elf_buflen =	sizeof(struct elfhdr) + 
 			(*nphdr + 2)*sizeof(struct elf_phdr) + 
-			3 * (sizeof(struct elf_note) + 4) +
-			sizeof(struct elf_prstatus) +
-			sizeof(struct elf_prpsinfo) +
-			sizeof(struct task_struct);
+			3 * ((sizeof(struct elf_note)) +
+			     roundup(strlen(CORE_STR) + 1, 4)) +
+			roundup(sizeof(struct elf_prstatus), 4) +
+			roundup(sizeof(struct elf_prpsinfo), 4) +
+			roundup(sizeof(struct task_struct), 4);
 	*elf_buflen = PAGE_ALIGN(*elf_buflen);
 	return size + *elf_buflen;
 }
@@ -210,7 +212,7 @@ static void elf_kcore_store_hdr(char *bu
 	nhdr->p_offset	= offset;
 
 	/* set up the process status */
-	notes[0].name = "CORE";
+	notes[0].name = CORE_STR;
 	notes[0].type = NT_PRSTATUS;
 	notes[0].datasz = sizeof(struct elf_prstatus);
 	notes[0].data = &prstatus;
@@ -221,7 +223,7 @@ static void elf_kcore_store_hdr(char *bu
 	bufp = storenote(&notes[0], bufp);
 
 	/* set up the process info */
-	notes[1].name	= "CORE";
+	notes[1].name	= CORE_STR;
 	notes[1].type	= NT_PRPSINFO;
 	notes[1].datasz	= sizeof(struct elf_prpsinfo);
 	notes[1].data	= &prpsinfo;
@@ -238,7 +240,7 @@ static void elf_kcore_store_hdr(char *bu
 	bufp = storenote(&notes[1], bufp);
 
 	/* set up the task structure */
-	notes[2].name	= "CORE";
+	notes[2].name	= CORE_STR;
 	notes[2].type	= NT_TASKSTRUCT;
 	notes[2].datasz	= sizeof(struct task_struct);
 	notes[2].data	= current;
