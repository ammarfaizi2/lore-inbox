Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVL3LSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVL3LSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 06:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVL3LSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 06:18:38 -0500
Received: from general.keba.co.at ([193.154.24.243]:47917 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751249AbVL3LSi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 06:18:38 -0500
Content-class: urn:content-classes:message
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 30 Dec 2005 12:18:36 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <AAD6DA242BC63C488511C611BD51F36732330C@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYNE821zrVGUtjyTbmyihG8u6Lr9AAHFDHg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar
> * Lee Revell <rlrevell@joe-job.com> wrote:
> > It seems that either some code path really is forgetting to 
> re-enable 
> > interrupts, or there's a bug in the latency tracer.
> 
> one question is, what do the kernel addresses visible in the first 
> argument of asm_do_IRQ() correspond to:
> 
>  trace1:MyThread-153   0D..1 5977us+: asm_do_IRQ (c030c170 1a 0)
>  trace1:MyThread-153   0D..1 15191us+: asm_do_IRQ (c030c1bc 1a 0)
>  trace2:  <idle>-0     0D..2 8822us+: asm_do_IRQ (c021da24 1a 0)
>  trace2:  <idle>-0     0Dn.2 8920us+: asm_do_IRQ (c021da24 b 0)
>  trace3:     top-169   0D..1 8802us+: asm_do_IRQ (c024e5fc 1a 0)
>  trace4:  insmod-185   0D..1 8794us+: asm_do_IRQ (c030c174 1a 0)
>  trace5:      dd-197   0D..1 8812us+: asm_do_IRQ (c02e4938 1a 0)
>  trace6: kthread-11    0d..3 2670us+: asm_do_IRQ (c02fe2d0 1a 0)
>  trace7:MyThread-95    0D..1  542us+: asm_do_IRQ (c02fe2d0 1a 0)
>  trace7:MyThread-95    0D..1 9755us+: asm_do_IRQ (c02fe2d0 1a 0)
> 
> i.e. what is c02fe2d0, c021da24, c02e4938, etc.?
> 
> but it seems most of the latencies are printk related: one 
> possibility 
> is that something is doing a costly printk with preemption disabled.

The long latency in idle (trace2) is definitely *not* printk related:
It appears without any printk going on.

If I remember correctly, trace3 and trace5 were also taken
without any printk's happening, I'm not sure about trace4 
(my module init function writes a message).

MyThread is a kernel thread of mine which definitely calls printk,
so trace1 and trace7 (and perhaps trace6) could be printk-related.

However, it never ever explicitely locks preemption, interrupts or 
anything similar, especially not around the printk's, and there are
no other printk's happening during the tests.

Hence: printk's yes, printk's with preemption disabled not that I
am aware of.

However, in the meantime I found out that I can generate almost any
latency (exceeding 1 sec!) with massive printk's, no matter if they 
go to the fb console or the sio or both (only if both are disabled
printk doesn't seem to cause long latencies).
That's even the case when the interrupt jitter test program runs
at a higher rt priority than the printk kernel thread.
Why that and what to do against it?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
