Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUICA7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUICA7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269491AbUICA6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:58:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4547 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269458AbUICAtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:49:51 -0400
Date: Thu, 2 Sep 2004 17:47:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1094170054.14662.391.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409021737310.6412@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com> 
 <1094164096.14662.345.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com> 
 <1094166858.14662.367.camel@cog.beaverton.ibm.com> 
 <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com>
 <1094170054.14662.391.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, john stultz wrote:

> > Of course but its not a generic way of timer acccess and
> > requires a fastcall for each timer. You still have the problem of
> > exporting the frequency and the time offsets to user space (those also
> > need to be kept current in order for one to be able to calculate a timer
> > value!). The syscall/fastcall API then needs to be extended to allow for a
> > system call to access each of the individual timers supported.
>
> Indeed, it would require a fastcall accessor for each timesource, but
> maybe fastcall is the wrong way to describe it. Could it just be a
> function that uses the epc to escalate its privileges? As for freq and
> offsets, those would already be user-visible (see below for more
> details)

The only way curent way to enter the kernel from glibc with a fastcall is
the EPC.

> The plan at the moment is that the timeofday core gettimeofday code path
> as well as any timesource that supports it adds a _vsyscall linker
> attribute. Then the linker will place all the code on a special page or
> set of pages. Those pages would then be mapped in as user-readable. Then
> just like the x86-64's vsyscall gettimeofday, glibc would re-direct
> gettimeofday calls to the user-mapped kernel pages, where it would
> execute in user mode (with maybe the epc privilege escalation for ia64
> time sources that required it).

The EPC call already does do a *secure* transfer like this on IA64 and
will execute kernel code without user space mapping. This idea raises all sorts
of concerns....

> I had to do most of this for the i386 vsyscall-gettimeofday port, but I
> was unhappy with the duplication of code (and bugs), as well as the fact
> that I was then being pushed to re-do it for each architecture. While
> its not currently implemented (I was hoping to keep the discussion
> focused on the correctness of what's been implemented), I feel the plan
> for user-mode access won't be too complex. I'm still open for further
> discussion if you'd like, obviously performance is quite important, and
> I want to calm any fears you have, but I'm sure the new ntp code plenty
> of performance issues to look at before we start digging into usermode
> access, so maybe we can come back to this discussion later?

The functions in the timer source structure is a central problem for IA64. We
cannot take that out right now.

The full parameterization of timer access as I have suggested also allows
user page access to timers with simply mapping a page to access the timer.
No other gimmicks are needed since the timer source structure contains all
information to calculate a timer offset.

> Yes, but x86-64 has one way, and ia64 does it another, and i know ppc
> folks have talked about their own user mode time access. Chasing down a
> time bug across arches gets to be fairly hairy, so I'm trying to
> simplify that.

The simplest thins is to provide a data structure without any functions
attached that can simply be copied into userspace if wanted. If an arch
needs special time access then that is depending on the arch specific
methods available and such a data structure as I have proposed will
include all the info necessary to implement such user mode time access.

A requirement to call functions in the kernel to determine time makes
these solution impossible. And its getting extremely complex if one has to
invoke different functions for each timer supported.

