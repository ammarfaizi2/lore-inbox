Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUHUS0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUHUS0w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUHUSZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:25:20 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:54003 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267616AbUHUSYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:24:38 -0400
Date: Sat, 21 Aug 2004 14:28:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, John Levon <levon@movementarian.org>,
       Philippe Elie <phil.el@wanadoo.fr>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][4/4] Completely out of line spinlocks / oprofile
Message-ID: <Pine.LNX.4.58.0408211338520.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Making the spinlock text out of line results in inaccurate samples during
lock contention. Use profile_pc to provide a smarter way of figuring out
where we are.

 arch/i386/oprofile/op_model_athlon.c |    2 +-
 arch/i386/oprofile/op_model_p4.c     |    2 +-
 arch/i386/oprofile/op_model_ppro.c   |    2 +-
 drivers/oprofile/timer_int.c         |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8.1-mm3/drivers/oprofile/timer_int.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/drivers/oprofile/timer_int.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 timer_int.c
--- linux-2.6.8.1-mm3/drivers/oprofile/timer_int.c	21 Aug 2004 13:14:56 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/drivers/oprofile/timer_int.c	21 Aug 2004 17:07:52 -0000
@@ -19,7 +19,7 @@ static int timer_notify(struct notifier_
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);

 	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
 	return 0;
Index: linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_athlon.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_athlon.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_athlon.c
--- linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_athlon.c	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_athlon.c	21 Aug 2004 17:06:27 -0000
@@ -96,7 +96,7 @@ static int athlon_check_ctrs(unsigned in
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
Index: linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_p4.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_p4.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_p4.c
--- linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_p4.c	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_p4.c	21 Aug 2004 17:06:43 -0000
@@ -595,7 +595,7 @@ static int p4_check_ctrs(unsigned int co
 {
 	unsigned long ctr, low, high, stag, real;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	stag = get_stagger();
Index: linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_ppro.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_ppro.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_ppro.c
--- linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_ppro.c	21 Aug 2004 13:14:49 -0000	1.1.1.1
+++ linux-2.6.8.1-mm3/arch/i386/oprofile/op_model_ppro.c	21 Aug 2004 17:07:03 -0000
@@ -91,7 +91,7 @@ static int ppro_check_ctrs(unsigned int
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
