Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbREOGtt>; Tue, 15 May 2001 02:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbREOGtc>; Tue, 15 May 2001 02:49:32 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:19842 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262660AbREOGtT>; Tue, 15 May 2001 02:49:19 -0400
From: "Victor Wong" <victor.wong@stanford.edu>
To: <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch/i386/kernel/irq.c
Date: Mon, 14 May 2001 23:49:02 -0700
Message-ID: <NDBBLHPAGLNBKNHFNOOGMEHECKAA.victor.wong@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches to irq.c were made to deal with potential errors in
creating /proc entries for irqs on bootup. The code add checks to ensure
that the entries were created succesfully. In case of error, it attempts to
cleanup after itself. The patch was made against v2.4.4 of the kernel and
result from some errors found during checker runs against the kernel source.

Victor Wong
victor.wong@stanford.edu

--- arch/i386/kernel/irq.c.orig	Sun May  6 23:45:09 2001
+++ arch/i386/kernel/irq.c	Sun May  6 23:48:26 2001
@@ -1137,6 +1137,11 @@
 	/* create /proc/irq/1234/smp_affinity */
 	entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);

+	if (!entry) {
+	    remove_proc_entry(name, root_irq_dir);
+	    return;
+	}
+
 	entry->nlink = 1;
 	entry->data = (void *)(long)irq;
 	entry->read_proc = irq_affinity_read_proc;
@@ -1157,6 +1162,11 @@

 	/* create /proc/irq/prof_cpu_mask */
 	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
+
+	if (!entry) {
+	    remove_proc_entry("irq", 0);
+	    return;
+	}

 	entry->nlink = 1;
 	entry->data = (void *)&prof_cpu_mask;

