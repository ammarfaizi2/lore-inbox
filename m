Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUIHOEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUIHOEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIHODp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:03:45 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:15457 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267841AbUIHN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:58:38 -0400
Message-ID: <413F0070.2020104@yahoo.com.au>
Date: Wed, 08 Sep 2004 22:52:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <nathanl@austin.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] cpu: add a CPU_DOWN_PREPARE notifier
References: <413EFFFB.5050902@yahoo.com.au>
In-Reply-To: <413EFFFB.5050902@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070101060603060100000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101060603060100000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/3

Rusty, can I do this?

--------------070101060603060100000003
Content-Type: text/x-patch;
 name="hotplug-cpu_down_prepare-notifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotplug-cpu_down_prepare-notifier.patch"



Add a CPU_DOWN_PREPARE hotplug CPU notifier. This is needed so we can
dettach all sched-domains before a CPU goes down, thus we can build
domains from online cpumasks, and not have to check for the possibility
of a CPU coming up or going down.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/include/linux/notifier.h |    9 +++++----
 linux-2.6-npiggin/kernel/cpu.c             |    9 +++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff -puN kernel/cpu.c~hotplug-cpu_down_prepare-notifier kernel/cpu.c
--- linux-2.6/kernel/cpu.c~hotplug-cpu_down_prepare-notifier	2004-09-08 22:39:28.000000000 +1000
+++ linux-2.6-npiggin/kernel/cpu.c	2004-09-08 22:39:28.000000000 +1000
@@ -119,6 +119,15 @@ int cpu_down(unsigned int cpu)
 		goto out;
 	}
 
+	err = notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
+						(void *)(long)cpu);
+	if (err == NOTIFY_BAD) {
+		printk("%s: attempt to take down CPU %u failed\n",
+				__FUNCTION__, cpu);
+		err = -EINVAL;
+		goto out;
+	}
+
 	/* Ensure that we are not runnable on dying cpu */
 	old_allowed = current->cpus_allowed;
 	tmp = CPU_MASK_ALL;
diff -puN include/linux/notifier.h~hotplug-cpu_down_prepare-notifier include/linux/notifier.h
--- linux-2.6/include/linux/notifier.h~hotplug-cpu_down_prepare-notifier	2004-09-08 22:39:28.000000000 +1000
+++ linux-2.6-npiggin/include/linux/notifier.h	2004-09-08 22:39:28.000000000 +1000
@@ -60,10 +60,11 @@ extern int notifier_call_chain(struct no
 
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
 
-#define CPU_ONLINE	0x0002 /* CPU (unsigned)v is up */
-#define CPU_UP_PREPARE	0x0003 /* CPU (unsigned)v coming up */
-#define CPU_UP_CANCELED	0x0004 /* CPU (unsigned)v NOT coming up */
-#define CPU_DEAD	0x0006 /* CPU (unsigned)v dead */
+#define CPU_ONLINE		0x0002 /* CPU (unsigned)v is up */
+#define CPU_UP_PREPARE		0x0003 /* CPU (unsigned)v coming up */
+#define CPU_UP_CANCELED		0x0004 /* CPU (unsigned)v NOT coming up */
+#define CPU_DOWN_PREPARE	0x0005 /* CPU (unsigned)v going down */
+#define CPU_DEAD		0x0006 /* CPU (unsigned)v dead */
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */

_

--------------070101060603060100000003--
