Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933301AbWKNBJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301AbWKNBJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933302AbWKNBJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:09:39 -0500
Received: from elvis.mu.org ([192.203.228.196]:24808 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S933301AbWKNBJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:09:38 -0500
Message-ID: <45591749.90501@FreeBSD.org>
Date: Mon, 13 Nov 2006 17:09:29 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Introduce a vmonotonic_clock() vsyscall.
References: <455916A5.2030402@FreeBSD.org>
In-Reply-To: <455916A5.2030402@FreeBSD.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the vsyscall equivalent of monotonic_clock(), using the per-cpu vxtime.
It returns the number of nanoseconds since boot.

It's intended to be used by processes that need a cheap and nanosecond
resolution time counter.

Signed-off-by:	Suleiman Souhlal <suleiman@google.com>

---
 arch/x86_64/kernel/vsyscall.c |   21 +++++++++++++++++++++
 include/asm-x86_64/vsyscall.h |    1 +
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index 9025699..f124cc6 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -52,6 +52,7 @@ #include <asm/unistd.h>
 
 #define	NS_SCALE 10
 #define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
+extern unsigned long long monotonic_base;
 extern unsigned long hpet_tick;
 
 extern unsigned long vxtime_hz;
@@ -108,11 +109,13 @@ void vxtime_update_pcpu(void)
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
+		vxtime.pcpu[cpu].monotonic_base = monotonic_base;
 		vxtime.pcpu[cpu].tv_sec = xtime.tv_sec;
 		vxtime.pcpu[cpu].tv_usec = xtime.tv_nsec / 1000;
 		offset = hpet_readl(HPET_COUNTER) - vxtime.last;
 	} while (read_seqretry(&xtime_lock, seq));
 
+	vxtime.pcpu[cpu].monotonic_base += offset * NSEC_PER_TICK / hpet_tick;
 	vxtime.pcpu[cpu].tv_usec += (offset * vxtime.quot) >> 32;
 	vxtime.pcpu[cpu].last_tsc = get_cycles_sync();
 
@@ -256,6 +259,24 @@ vgetcpu(unsigned *cpu, unsigned *node, s
 	return 0;
 }
 
+unsigned long __vsyscall(3) vmonotonic_clock(void)
+{
+	unsigned long nsec, seq, t;
+	int cpu;
+
+	do {
+		seq = read_seqbegin(&__vxtime.vx_seq);
+		cpu = apicid();
+		nsec = __vxtime.pcpu[cpu].monotonic_base;
+
+		rdtscll(t);
+		nsec += ((t - __vxtime.pcpu[cpu].last_tsc)
+		    * __vxtime.pcpu[cpu].tsc_nsquot) >> NS_SCALE;
+	} while (read_seqretry(&__vxtime.vx_seq, seq) || cpu != apicid());
+
+	return (nsec);
+}
+
 #ifdef CONFIG_SYSCTL
 
 #define SYSCALL 0x050f
diff --git a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
index 707353b..5a10fd0 100644
--- a/include/asm-x86_64/vsyscall.h
+++ b/include/asm-x86_64/vsyscall.h
@@ -31,6 +31,7 @@ #define VGETCPU_RDTSCP	1
 #define VGETCPU_LSL	2
 
 struct vxtime_pcpu {
+	unsigned long monotonic_base;
 	time_t tv_sec;
 	long tv_usec;
 	unsigned long tsc_nsquot;


