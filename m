Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTJHVTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTJHVTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:19:55 -0400
Received: from [209.77.185.85] ([209.77.185.85]:23471 "EHLO lumo.pacujo.net")
	by vger.kernel.org with ESMTP id S261787AbTJHVTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:19:52 -0400
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, hadi@cyberus.ca (Jamal Hadi Salim),
       Robert.Olsson@data.slu.se (Robert Olsson)
Subject: Re: NAPI Race?
References: <200310081957.XAA01425@yakov.inr.ac.ru>
Date: 08 Oct 2003 14:17:31 -0700
In-Reply-To: <200310081957.XAA01425@yakov.inr.ac.ru>
Message-ID: <m3ekxnzaxg.fsf@lumo.pacujo.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Marko Rauhamaa <marko@pacujo.net>
X-Delivery-Agent: TMDA/0.82 (Needles)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru:

> > interrupted for some other reason, the packet will get processed only at
> > the next jiffie when the soft irq is invoked again.
> > 
> > Am I mistaken?
> 
> Yes, you are wrong. It is processed as soon as possible.

If I receive a packet at the tail end of net_rx_action(), we will
schedule the softirq again. But do_softirq() explicitly refuses to run
the same softirq right away. The softirq will be invoked at the next
interrupt, timer tick, system call (?) or when ksoftirqd is scheduled.
It may happen that none of these events occur for milliseconds.

> > As an aside, it looks also as though the design might technically
> > allow the network driver to starve the CPU (the very situation NAPI
> > was designed to protect against).
> 
> Nope. NAPI is not expected to cure starvation caused by softirqs.

Well, it almost does. You can blast a NAPI driver with a packet flood,
and the system is happy and responsive -- no interrupts are generated,
and packets are polled by ksoftirqd. However, you can find a packet rate
that will cause the CPU to spend virtually all of its time in NAPI.


Marko

-- 
Marko Rauhamaa      mailto:marko@pacujo.net     http://pacujo.net/marko/
