Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSKMDl1>; Tue, 12 Nov 2002 22:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSKMDl0>; Tue, 12 Nov 2002 22:41:26 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:17414
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266736AbSKMDlZ>; Tue, 12 Nov 2002 22:41:25 -0500
Date: Tue, 12 Nov 2002 22:42:07 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Remove BUG in cpu_up
Message-ID: <Pine.LNX.4.44.0211122236270.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think a BUG here is a bit on the extreme side, we already have a running 
processor (in boot i'd presume its the BSP) so we can afford to limp on. 
At runtime a stopped/dead processor which refuses to come back up 
shouldn't make the kernel oops.

	Zwane

Index: linux-2.5.47/kernel/cpu.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/kernel/cpu.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpu.c
--- linux-2.5.47/kernel/cpu.c	11 Nov 2002 03:59:33 -0000	1.1.1.1
+++ linux-2.5.47/kernel/cpu.c	13 Nov 2002 03:37:37 -0000
@@ -35,13 +35,11 @@
 		return ret;
 
 	if (cpu_online(cpu)) {
-		ret = -EINVAL;
+		ret = -EBUSY;
 		goto out;
 	}
 	ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
-		printk("%s: attempt to bring up CPU %u failed\n",
-				__FUNCTION__, cpu);
 		ret = -EINVAL;
 		goto out_notify;
 	}
@@ -50,16 +48,22 @@
 	ret = __cpu_up(cpu);
 	if (ret != 0)
 		goto out_notify;
-	if (!cpu_online(cpu))
-		BUG();
+
+	if (!cpu_online(cpu)) {
+		ret = -EIO;
+		goto out_notify;
+	}
 
 	/* Now call notifier in preparation. */
-	printk("CPU %u IS NOW UP!\n", cpu);
+	printk(KERN_INFO "CPU %u IS NOW UP!\n", cpu);
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
-	if (ret != 0)
+	if (ret != 0) {
+		printk(KERN_WARNING "%s: attempt to bring up CPU %u failed\n",
+			__FUNCTION__, cpu);
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
+	}
 out:
 	up(&cpucontrol);
 	return ret;
-- 
function.linuxpower.ca

