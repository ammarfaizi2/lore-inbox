Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWBAJV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWBAJV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWBAJVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:21:54 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:2230 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S932448AbWBAJVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:21:42 -0500
Message-ID: <43E07D86.10509@cosmosbay.com>
Date: Wed, 01 Feb 2006 10:21:10 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, shai@scalex86.org, kiran@scalex86.org,
       pravins@calsoftinc.com
Subject: [PATCH] [SMP] __GENERIC_PER_CPU changes
References: <43CE4C98.76F0.0078.0@novell.com>	<20060120232500.07f0803a.akpm@osdl.org>	<43D4BE7F.76F0.0078.0@novell.com>	<20060123025702.1f116e70.akpm@osdl.org>	<43D5F44C.76F0.0078.0@novell.com> <20060124005806.7e9ab02e.akpm@osdl.org> <43D63DB5.3010601@cosmosbay.com>
In-Reply-To: <43D63DB5.3010601@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------080105080406080108020504"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 01 Feb 2006 10:21:09 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105080406080108020504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Now CONFIG_DEBUG_INITDATA is in, initial percpu data 
[__per_cpu_start,__per_cpu_end] can be declared as a redzone, and invalid 
accesses after boot can be detected, at least for i386.

We can let non possible cpus percpu data point to this 'redzone' instead of NULL .

NULL was not a good choice because part of [0..32768] memory may be readable 
and invalid accesses may happen unnoticed.

If CONFIG_DEBUG_INITDATA is not defined, each non possible cpu points to the 
initial percpu data (__per_cpu_offset[cpu] == 0), thus invalid accesses wont 
be detected/crash.

This patch also moves __per_cpu_offset[] to read_mostly area to avoid false 
sharing.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------080105080406080108020504
Content-Type: text/plain;
 name="init_main.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="init_main.patch"

--- a/init/main.c	2006-02-01 10:44:10.000000000 +0100
+++ b/init/main.c	2006-02-01 10:50:16.000000000 +0100
@@ -325,7 +325,7 @@
 #else
 
 #ifdef __GENERIC_PER_CPU
-unsigned long __per_cpu_offset[NR_CPUS];
+unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 
 EXPORT_SYMBOL(__per_cpu_offset);
 
@@ -343,11 +343,7 @@
 #endif
 	ptr = alloc_bootmem(size * nr_possible_cpus);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i)) {
-			__per_cpu_offset[i] = (char*)0 - __per_cpu_start;
-			continue;
-		}
+	for_each_cpu(i) {
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 		ptr += size;

--------------080105080406080108020504--
