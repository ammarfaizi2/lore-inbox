Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUIJW6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUIJW6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUIJW6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:58:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42165 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267866AbUIJWyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:54:52 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       kr@cybsft.com, Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040910132841.GA8552@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
	 <20040909130526.2b015999.akpm@osdl.org>  <20040910132841.GA8552@elte.hu>
Content-Type: text/plain
Message-Id: <1094856888.2721.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 18:54:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 09:28, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > diff -puN mm/vmscan.c~swapspace-layout-improvements mm/vmscan.c
> > --- 25/mm/vmscan.c~swapspace-layout-improvements	2004-06-03 21:32:51.087602712 -0700
> > +++ 25-akpm/mm/vmscan.c	2004-06-03 21:32:51.102600432 -0700
> 

OK, Andrew's patch seems to be an improvement.  I can still cause
unbounded latencies, but these only seem to happen when we fill all
available RAM and swap space, at which point we start spending
milliseconds at a time in scan_swap_map:


preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 6032 us, entries: 550 (550)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: xfs/1098, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: rtc_interrupt+0x294/0x450
 => ended at:   get_swap_page+0x13f/0x350
=======>
00010002 0.000ms (+0.000ms): touch_preempt_timing (rtc_interrupt)
00010002 0.000ms (+0.000ms): printk (rtc_interrupt)
00010002 0.000ms (+0.001ms): vprintk (printk)
00010003 0.002ms (+0.000ms): vscnprintf (vprintk)
00010003 0.002ms (+0.002ms): vsnprintf (vscnprintf)
00010003 0.005ms (+0.004ms): number (vsnprintf)
00010003 0.009ms (+0.001ms): number (vsnprintf)
00010003 0.010ms (+0.001ms): number (vsnprintf)
00010003 0.011ms (+0.000ms): emit_log_char (vprintk)

[...]

00010002 1.983ms (+0.000ms): preempt_schedule (do_IRQ)
00000003 1.984ms (+0.000ms): do_softirq (do_IRQ)
00000003 1.984ms (+0.911ms): __do_softirq (do_softirq)
00010002 2.896ms (+0.000ms): do_IRQ (scan_swap_map)
00010002 2.896ms (+0.000ms): do_IRQ (<00000008>)
00010003 2.897ms (+0.004ms): mask_and_ack_8259A (do_IRQ)
00010003 2.901ms (+0.000ms): preempt_schedule (do_IRQ)

Full trace: 

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk12-S0#/var/www/2.6.9-rc1-bk12-S0/swapspace-layout-improvements-A1.txt

The above are just the initial results; I am still testing this.  It
certainly seems like it can take a beating.

Lee

Lee

