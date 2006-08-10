Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWHJUBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWHJUBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWHJT7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:4753 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932263AbWHJTgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:54 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [96/145] x86_64: Add sparse annotation to vsyscall.c
Message-Id: <20060810193653.D64DB13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:53 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Fixes

linux/arch/x86_64/kernel/vsyscall.c:276:7: warning: constant 0x0f40000000000 is so big it is long
linux/arch/x86_64/kernel/vsyscall.c:80:14: warning: incorrect type in argument 1 (different address spaces)
linux/arch/x86_64/kernel/vsyscall.c:80:14:    expected void const volatile [noderef] *addr<asn:2>
linux/arch/x86_64/kernel/vsyscall.c:80:14:    got void *<noident>
linux/arch/x86_64/kernel/vsyscall.c:200:7: warning: incorrect type in assignment (different address spaces)
linux/arch/x86_64/kernel/vsyscall.c:200:7:    expected unsigned short [usertype] *map1
linux/arch/x86_64/kernel/vsyscall.c:200:7:    got void [noderef] *<asn:2>
linux/arch/x86_64/kernel/vsyscall.c:203:7: warning: incorrect type in assignment (different address spaces)
linux/arch/x86_64/kernel/vsyscall.c:203:7:    expected unsigned short [usertype] *map2
linux/arch/x86_64/kernel/vsyscall.c:203:7:    got void [noderef] *<asn:2>
linux/arch/x86_64/kernel/vsyscall.c:215:10: warning: incorrect type in argument 1 (different address spaces)
linux/arch/x86_64/kernel/vsyscall.c:215:10:    expected void volatile [noderef] *addr<asn:2>
linux/arch/x86_64/kernel/vsyscall.c:215:10:    got unsigned short [usertype] *map2
linux/arch/x86_64/kernel/vsyscall.c:217:10: warning: incorrect type in argument 1 (different address spaces)
linux/arch/x86_64/kernel/vsyscall.c:217:10:    expected void volatile [noderef] *addr<asn:2>
linux/arch/x86_64/kernel/vsyscall.c:217:10:    got unsigned short [usertype] *map1

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/vsyscall.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -77,7 +77,8 @@ static __always_inline void do_vgettimeo
 				 __vxtime.tsc_quot) >> 32;
 			/* See comment in x86_64 do_gettimeofday. */
 		} else {
-			usec += ((readl((void *)fix_to_virt(VSYSCALL_HPET) + 0xf0) -
+			usec += ((readl((void __iomem *)
+				   fix_to_virt(VSYSCALL_HPET) + 0xf0) -
 				  __vxtime.last) * __vxtime.quot) >> 32;
 		}
 	} while (read_seqretry(&__xtime_lock, sequence));
@@ -191,7 +192,8 @@ static int vsyscall_sysctl_change(ctl_ta
                         void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	extern u16 vsysc1, vsysc2;
-	u16 *map1, *map2;
+	u16 __iomem *map1;
+	u16 __iomem *map2;
 	int ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 	if (!write)
 		return ret;
@@ -206,11 +208,11 @@ static int vsyscall_sysctl_change(ctl_ta
 		goto out;
 	}
 	if (!sysctl_vsyscall) {
-		*map1 = SYSCALL;
-		*map2 = SYSCALL;
+		writew(SYSCALL, map1);
+		writew(SYSCALL, map2);
 	} else {
-		*map1 = NOP2;
-		*map2 = NOP2;
+		writew(NOP2, map1);
+		writew(NOP2, map2);
 	}
 	iounmap(map2);
 out:
