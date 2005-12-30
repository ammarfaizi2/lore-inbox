Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVL3ICo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVL3ICo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVL3ICo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:02:44 -0500
Received: from general.keba.co.at ([193.154.24.243]:9259 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751209AbVL3ICn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:02:43 -0500
Content-class: urn:content-classes:message
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 30 Dec 2005 09:02:39 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323309@MAILIT.keba.co.at>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYNEtQLK7ErQBxVQ3CJ+52XEMlTMwAADvZA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: <mingo@elte.hu>, "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lee Revell
> On Thu, 2005-12-29 at 16:08 +0100, kus Kusche Klaus wrote:
> > However, traces 1, 2, 6 and 7 are completely mysterious to me.
> > Interrupts seem to be blocked for milliseconds, while 
> nothing is going
> > on on the system? Moreover, there are console-related function names
> > in
> > traces 6 and 7, although I've unconfigured the framebuffer 
> console for
> > these runs!
> 
> It seems that either some code path really is forgetting to re-enable
> interrupts, or there's a bug in the latency tracer.
> 
> Do these correspond to observed latencies?

As far as I can tell, probably not, but I'm not yet sure, 
because I don't really know how to measure latencies *continuously*.

Currently, I'm measuring clock interrupt jitter, i.e. how late 
(compared to the theoretical clock tick interval) do events 
triggered by the clock interrupt arrive at an usermode process. 

This jitter does not exceed 120 microseconds for a pri 99 RT task
or 400-500 microseconds for a pri 1 RT task, so it is far from the
5000-10000 microseconds observed by the latency tracer.

So there are two possibilities:
* Either the latency tracer is wrong.
* Or the latencies are perfectly synchronized with the system clock 
(i.e. always fit nicely in between two clock interrupts).
This could well be the case, because all my kernel modules doing 
printk's are also clock-triggered.

There seem to be very rare jitters up to 1 second (!),
I'm still hunting those (they also seem to be related to massive 
printk's), but they also seem to be unrelated to those observed 
by the latency tracer.

By the way, has nobody ever used the latency tracer for ARM yet?
Initially, it gave only 0 timings.
I hacked the following in timex.h to make it work:
#define mach_read_cycles() (OSCR)
#define mach_cycles_to_usecs(d) ((d)>>2)
#define mach_usecs_to_cycles(d) ((d)<<2)

OSCR should be a free-running counter register with 3.6864 MHz.


-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
