Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUCRL6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCRL6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:58:14 -0500
Received: from mail.shareable.org ([81.29.64.88]:6798 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262545AbUCRL4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:56:25 -0500
Date: Thu, 18 Mar 2004 11:56:09 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Mark Gross <mgross@linux.co.intel.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>, Philippe Gerum <rpm@xenomai.org>
Subject: Re: Call for HRT in 2.6 kernel was Re: finding out the value of HZ from userspace
Message-ID: <20040318115609.GA29382@mail.shareable.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403161757.48786.mgross@linux.intel.com> <20040317023059.GD19564@mail.shareable.org> <200403170848.01156.mgross@linux.intel.com> <20040317200702.GA25293@mail.shareable.org> <4058F91C.9000207@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4058F91C.9000207@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see we have gone from a desire for soft-rt high-res timers to
pushing hard-rt :)

Karim Yaghmour wrote:
> I'm thinking here of Adeos. It's the smallest subset of services
> required for obtaining hard-rt in the kernel,

In this case, it's not clear that hard-rt is desirable.  VoIP doesn't
like occasional glitches, but it can tolerate them and must do so when
a machine is overloaded, e.g. trying to handle too many scheduling
objectives at once.  I don't know much about the original poster's
problem, that's just my take on VoIP.

> and it's fairly non-invasive (not to mention that configuring it out
> results in no changes to the kernel.) So while Adeos doesn't provide
> abstract services such as "tasks" or "timers", it does provide the
> basic mechanism for all add-ons that want to provide these to obtain
> the hard-rt from Adeos using an architecture-independent API.

There is also Bernard Kuhn's recent "real-time interrupts" patch for
2.6 which could be utilised:

http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040304/rtirq.html
http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040304/rtirq-2.6.2-20040304.tar.bz2

> Actually, most software that needs hard-rt can live as loadable
> modules once Adeos is integrated in the kernel.

A couple of questions.

Can Adeos-registed timer callbacks call the same functions as normal
timer callbacks, schedule userspace, and kick network I/O with near-RT
guarantees?  Or do they run in a non-kernel context?

(Mark can say whether a normal context, i.e. with system calls, memory
allocation and network I/O, is required for Intel's VoIP application.)

Can Adeos itself be loaded as a module which overrides normal non-RT
kernel interrupt and timer functions?  If it can be kept out of the
standard kernel, but loaded when needed, that would be nice.

One more thing would help, IMHO, in getting any fancy interrupt system
in: if it balanced the different execution contexts, i.e. limit total
CPU taken in high priority, low priority interrupts, task queues
etc. in an efficient yet fair way, such that overall throughput was
improved over standard kernels in cases such as network overload.
NAPI does this at the network card level, but there is no reason why
balancing CPU among contexts cannot be done at the generic interrupt
scheduling level, making it work for all I/O devices without special
driver support.

-- Jamie
