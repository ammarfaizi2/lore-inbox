Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSIAVa4>; Sun, 1 Sep 2002 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSIAVa4>; Sun, 1 Sep 2002 17:30:56 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:57350 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S318115AbSIAVax>;
	Sun, 1 Sep 2002 17:30:53 -0400
Subject: Re: [PATCH] Re: 2.5.33 PNPBIOS does not compile
From: Ray Lee <ray-lk@madrabbit.org>
To: ldb@ldb.ods.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
In-Reply-To: <1030911455.4803.3.camel@orca>
References: <1030911455.4803.3.camel@orca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 14:35:07 -0700
Message-Id: <1030916108.936.23.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 13:17, Ray Lee wrote:
> These look very wrong. They're not wrapped in the standard do {...}
> while(0) protection, and used inside bare if statements below. Can
> someone who knows the code verify that these should be wrapped?

Back from running errands, and took a longer look at the code. I don't
know if the current form is harmless or not, but it is definitely
incorrect. The patch below corrects the compile failure, as well as the
multi-statement macro defines used in bare if statements; please apply.

Ray

diff -urX ../dontdiff ../linux-2.5.33/drivers/pnp/pnpbios_core.c ./drivers/pnp/pnpbios_core.c
--- ../linux-2.5.33/drivers/pnp/pnpbios_core.c	2002-09-01 09:38:10.000000000 -0700
+++ ./drivers/pnp/pnpbios_core.c	2002-09-01 14:27:55.000000000 -0700
@@ -126,12 +126,16 @@
 );
 
 #define Q_SET_SEL(cpu, selname, address, size) \
+do { \
 set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+} while(0)
 
 #define Q2_SET_SEL(cpu, selname, address, size) \
+do { \
 set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+} while(0)
 
 /*
  * At some point we want to use this stack frame pointer to unwind



