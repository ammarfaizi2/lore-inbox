Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUHESlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUHESlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267919AbUHESf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:35:57 -0400
Received: from fmr05.intel.com ([134.134.136.6]:44233 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267877AbUHESZU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:25:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:22:26 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C4@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR67KSkq2pUMRq9QeihuSVc82SjGgALABLA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ulrich Drepper" <drepper@redhat.com>
X-OriginalArrivalTime: 05 Aug 2004 18:23:11.0172 (UTC) FILETIME=[43991040:01C47B19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)


> -----Original Message-----
> From: Ingo Molnar [mailto:mingo@elte.hu]
> Sent: Thursday, August 05, 2004 3:59 AM
> To: Perez-Gonzalez, Inaky
> Cc: linux-kernel@vger.kernel.org; robustmutexes@lists.osdl.org; Andrew Morton; Ulrich Drepper
> Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
> 
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > but, couldnt there be more sharing between futex.c and fusyn.c? In
> > particular on the API side, why arent all these ops done as an
> > extension to sys_futex()? That would keep the glibc part much simpler
> > (and more compatible) as well. [...]
> 
> i believe the key to integration of this feature is to try to make it
> used by normal (non-RT) apps as much as possible. I.e. try to make
> current futexes a subset of fusyn.c and to merge the two APIs if
> possible (essentially renaming your fusyn.c to futex.c and implementing
> the futex API). Is this possible without noticeable performance overhead
> (and without too many special-cases)?

I mentioned it in some other answer...I think. Nevermind. One of the fusyn
layers (ufuqueue) can emulate futexes completely [except for a few extra 
errno codes and the scheduling policy based wakeup and the missing requeue
[easy to do] and FUTEX_FD -- only NGPT uses it, afaik]. 

The interface is now through a three system calls (sys_ufuqueue_{wait,wake,ctl}), 
but it should be easy to redirect sys_futex().

> such an approach would ensure that key portions of the code would be
> triggered by everyday apps. Developers wouldnt break the feature every
> other day, etc. Deadlock detection and priority boosting might not be
> tested this way, but the basic locking/waking/VM-keying mechanism sure
> could be.

That makes sense. Performance overhead wise would be related only to the
extra spinlocks we take...I'll work on that redirection layer--I am going
on vacation tonight, but it should be ready in a couple of days as soon
as I come back.
