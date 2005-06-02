Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFBDPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFBDPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 23:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVFBDPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 23:15:17 -0400
Received: from mail.tyan.com ([66.122.195.4]:37389 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261205AbVFBDPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 23:15:09 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A403901@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor
	e dual way
Date: Wed, 1 Jun 2005 20:16:35 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

in arch/x86_64/kernel/smboot.c, function detect_siblings(),

because smp_num_siblings is always =1,  so several lines can be removed.

        for_each_online_cpu (cpu) {
                struct cpuinfo_x86 *c = cpu_data + cpu;
*R*                int siblings = 0;
                int i;
*R*                if (smp_num_siblings > 1) {
*R*                        for_each_online_cpu (i) {
*R*                                if (cpu_core_id[cpu] == cpu_core_id[i]) {
*R*                                        siblings++;
*R*                                        cpu_set(i, cpu_sibling_map[cpu]);
*R*                                }
*R*                        }
*R*                } else {
*R*                      siblings++;
                        cpu_set(cpu, cpu_sibling_map[cpu]);
*R*                }


 *R*               if (siblings != smp_num_siblings) {
 *R*                       printk(KERN_WARNING
 *R*              "WARNING: %d siblings found for CPU%d, should be %d\n",
 *R*                              siblings, cpu, smp_num_siblings);
 *R*                       smp_num_siblings = siblings;
 *R*               }

Also I found the workaround for hang on second node is
adding one line in setup.c
        /* Low order bits define the core id (index of core in socket) */
        cpu_core_id[cpu] = phys_proc_id[cpu] & ((1 << bits)-1);
        /* Convert the APIC ID into the socket ID */
        phys_proc_id[cpu] >>= bits;
+        printk(KERN_INFO "  CPU %d(%d)  phys_proc_id %d  Core %d\n", 
+               cpu, c->x86_num_cores, phys_proc_id[cpu], cpu_core_id[cpu]);

My compile environment SUSE 9.2 gcc version is 3.3.3???

YH

