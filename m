Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUICC3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUICC3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbUICC1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 22:27:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44010 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269451AbUICAMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:12:12 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
	 <1094164096.14662.345.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
	 <1094166858.14662.367.camel@cog.beaverton.ibm.com>
	 <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com>
Content-Type: text/plain
Message-Id: <1094170054.14662.391.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 17:07:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 16:39, Christoph Lameter wrote:
> On Thu, 2 Sep 2004, john stultz wrote:
> 
> > Then you implement a fastcall for fastcall_readcyclonecounter(), which
> > in crazy ia64 asm would do something like:
> >
> > ENTRY(fastcall_readcyclonecounter)
> > blip	// magic privledge escalation
> > blop	// load cyclone counter into memory
> > bloop	// copy cyclone counter back into return register
> > ;;
> > END(fastcall_readcyclonecounter)
> >
> >
> > This avoids 150+ lines of asm needed to re-implement the gettimeofday
> > math.
> >
> > However, I could be mistaken. Is something like this possible?
> 
> Of course but its not a generic way of timer acccess and
> requires a fastcall for each timer. You still have the problem of
> exporting the frequency and the time offsets to user space (those also
> need to be kept current in order for one to be able to calculate a timer
> value!). The syscall/fastcall API then needs to be extended to allow for a
> system call to access each of the individual timers supported.

Indeed, it would require a fastcall accessor for each timesource, but
maybe fastcall is the wrong way to describe it. Could it just be a
function that uses the epc to escalate its privileges? As for freq and
offsets, those would already be user-visible (see below for more
details)

> And how would this be supported from user space? We link in special
> libraries to support for cyclone and any other supported timers into
> each program? I thought a kernel would provide hardware abstraction?

The plan at the moment is that the timeofday core gettimeofday code path
as well as any timesource that supports it adds a _vsyscall linker
attribute. Then the linker will place all the code on a special page or
set of pages. Those pages would then be mapped in as user-readable. Then
just like the x86-64's vsyscall gettimeofday, glibc would re-direct
gettimeofday calls to the user-mapped kernel pages, where it would
execute in user mode (with maybe the epc privilege escalation for ia64
time sources that required it).

I had to do most of this for the i386 vsyscall-gettimeofday port, but I
was unhappy with the duplication of code (and bugs), as well as the fact
that I was then being pushed to re-do it for each architecture. While
its not currently implemented (I was hoping to keep the discussion
focused on the correctness of what's been implemented), I feel the plan
for user-mode access won't be too complex. I'm still open for further
discussion if you'd like, obviously performance is quite important, and
I want to calm any fears you have, but I'm sure the new ntp code plenty
of performance issues to look at before we start digging into usermode
access, so maybe we can come back to this discussion later?

> The current IA64 fastcall timer interface is generic and is bound into the
> clock_gettime interface of glibc.

Yes, but x86-64 has one way, and ia64 does it another, and i know ppc
folks have talked about their own user mode time access. Chasing down a
time bug across arches gets to be fairly hairy, so I'm trying to
simplify that.

Again, I really appreciate your thoughts and feedback. Let me see if in
the next release I can have more code to illustrate the user-mode access
plan.

thanks!
-john

