Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTH2SkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTH2SkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:40:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:45798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261508AbTH2Sj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:39:58 -0400
Date: Fri, 29 Aug 2003 11:23:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jun.nakajima@intel.com
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Message-Id: <20030829112347.2d8e292d.akpm@osdl.org>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D211@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D211@fmsmsx405.fm.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
> Resending the patch.

Thanks, I'll include these in the next -mm kernel.

Reading the code, the only thing which leaps out is:

+/* Use our own asm for 64 bit multiply/divide */
+#define ASM_MUL64_REG(eax_out,edx_out,reg_in,eax_in) 			\
+		__asm__ __volatile__("mull %2" 				\
+				:"=a" (eax_out), "=d" (edx_out) 	\
+				:"r" (reg_in), "0" (eax_in))
+
+#define ASM_DIV64_REG(eax_out,edx_out,reg_in,eax_in,edx_in) 		\
+		__asm__ __volatile__("divl %2" 				\
+				:"=a" (eax_out), "=d" (edx_out) 	\
+				:"r" (reg_in), "0" (eax_in), "1" (edx_in))

We seem to keep on proliferating home-grown x86 64-bit math functions.

Do you really need these?  Is it possible to use do_div() and the C 64x64
`*' operator instead?


I'd like the rtc emulation patch to be redone to remove the ifdefs please,
they're a real eyesore.

At the top of rtc.c, do something like this:

#ifndef CONFIG_HPET_EMULATE_RTC
#define is_hpet_enabled() 0
#define hpet_set_alarm_time(hrs, min, sec) 0
#define hpet_set_periodic_freq(arg) 0
static inline int hpet_mask_rtc_irq_bit(int arg) { return 0; }
#define hpet_rtc_timer_init() do { } while (0)
#define hpet_rtc_dropped_irq() 0
#endif

And then all those eleven ifdefs can be removed from rtc.c.

Thanks.
