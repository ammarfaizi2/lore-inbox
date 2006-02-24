Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWBXBib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWBXBib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWBXBib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:38:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44500 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751812AbWBXBia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:38:30 -0500
Date: Thu, 23 Feb 2006 20:38:29 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: x86 microcode driver vs hotplug CPUs.
Message-ID: <20060224013829.GA15764@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This driver loops over 'num_online_cpus', but it doesn't account
for holes in the online map created by offlined cpus, and assumes
that the cpu numbers stay linear.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/arch/i386/kernel/microcode.c~	2006-02-18 14:41:09.000000000 -0500
+++ linux-2.6.15.noarch/arch/i386/kernel/microcode.c	2006-02-18 14:45:42.000000000 -0500
@@ -250,8 +250,8 @@ static int find_matching_ucodes (void) 
 			error = -EINVAL;
 			goto out;
 		}
-		
-		for (cpu_num = 0; cpu_num < num_online_cpus(); cpu_num++) {
+
+		for_each_online_cpu(cpu_num) {
 			struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 			if (uci->err != MC_NOTFOUND) /* already found a match or not an online cpu*/
 				continue;
@@ -293,7 +293,7 @@ static int find_matching_ucodes (void) 
 					error = -EFAULT;
 					goto out;
 				}
-				for (cpu_num = 0; cpu_num < num_online_cpus(); cpu_num++) {
+				for_each_online_cpu(cpu_num) {
 					struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 					if (uci->err != MC_NOTFOUND) /* already found a match or not an online cpu*/
 						continue;
@@ -304,7 +304,9 @@ static int find_matching_ucodes (void) 
 			}
 		}
 		/* now check if any cpu has matched */
-		for (cpu_num = 0, allocated_flag = 0, sum = 0; cpu_num < num_online_cpus(); cpu_num++) {
+		allocated_flag = 0;
+		sum = 0;
+		for_each_online_cpu(cpu_num) {
 			if (ucode_cpu_info[cpu_num].err == MC_MARKED) { 
 				struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 				if (!allocated_flag) {
@@ -415,12 +415,12 @@ static int do_microcode_update (void)
 	}
 
 out_free:
-	for (i = 0; i < num_online_cpus(); i++) {
+	for_each_online_cpu(i) {
 		if (ucode_cpu_info[i].mc) {
 			int j;
 			void *tmp = ucode_cpu_info[i].mc;
 			vfree(tmp);
-			for (j = i; j < num_online_cpus(); j++) {
+			for_each_online_cpu(j) {
 				if (ucode_cpu_info[j].mc == tmp)
 					ucode_cpu_info[j].mc = NULL;
 			}

