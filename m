Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUEJARC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUEJARC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUEJARC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:17:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:1234 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261756AbUEJAQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:16:58 -0400
Date: Sun, 9 May 2004 17:14:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: zwane@linuxpower.ca, rusty@rustcorp.com.au
Subject: [PATCH*] show last kernel-image symbol in /proc/kallsyms
Message-Id: <20040509171452.09ee1ca0.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


'cat' or 'tail' of /proc/kallsyms (2.6.6-rc2 or -rc3, & probably much
earlier) does not include the last kernel-image symbol (_einittext).

_einittext is the last symbol generated in .tmp_kallsyms2.S
and the symbol count in that file also appears to be correct,
but the iterator code for /proc/kallsyms comes up 1 short somehow.

Here are 2 patches.  Either one of them "fixes" the problem.
Neither of them is the correct fix AFAIK.
Any other suggestions for fixes?

Thanks,
--
~Randy



// linux-266-rc3
// print the last (kernel image) symbol of /proc/kallsyms
// by making the valid symbol count 1 larger than symbols found;

diffstat:=
 scripts/kallsyms.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naurp ./scripts/kallsyms.c~incr_count ./scripts/kallsyms.c
--- ./scripts/kallsyms.c~incr_count	2004-04-03 19:38:23.000000000 -0800
+++ ./scripts/kallsyms.c	2004-05-09 16:33:07.000000000 -0700
@@ -127,7 +127,7 @@ write_src(void)
 	printf(".globl kallsyms_num_syms\n");
 	printf("\tALGN\n");
 	printf("kallsyms_num_syms:\n");
-	printf("\tPTR\t%d\n", valid);
+	printf("\tPTR\t%d\n", valid + 1);
 	printf("\n");
 
 	printf(".globl kallsyms_names\n");



// linux-266-rc3
// print the last (kernel image) symbol of /proc/kallsyms
// by using '>' instead of '>=' in the limiting test
// of the iterator.

diffstat:=
 kernel/kallsyms.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naurp ./kernel/kallsyms.c~use_gtr_not_geq ./kernel/kallsyms.c
--- ./kernel/kallsyms.c~use_gtr_not_geq	2004-04-03 19:38:21.000000000 -0800
+++ ./kernel/kallsyms.c	2004-05-09 16:00:11.000000000 -0700
@@ -199,7 +199,7 @@ static void reset_iter(struct kallsym_it
 static int update_iter(struct kallsym_iter *iter, loff_t pos)
 {
 	/* Module symbols can be accessed randomly. */
-	if (pos >= kallsyms_num_syms) {
+	if (pos > kallsyms_num_syms) {
 		iter->pos = pos;
 		return get_ksymbol_mod(iter);
 	}
