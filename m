Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVBXMvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVBXMvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVBXMvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:51:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49345 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262335AbVBXMvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:51:00 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, haveblue@us.ibm.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH] Fix for broken kexec on panic
References: <1109236432.5148.192.camel@terminator.in.ibm.com>
	<20050224011312.29668947.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Feb 2005 05:48:16 -0700
In-Reply-To: <20050224011312.29668947.akpm@osdl.org>
Message-ID: <m1650it97z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
> >  re-organization of boot memory allocator initialization code.
> 
> OK...
> 
> Where are we up to with these patches, btw?  

Currently we are in the middle of a reorganization that places
more of the work in user space, making the solution more robust.  

> Do you consider them close-to-complete?  

If you consider complete working code yes.
Design wise I believe we are complete except proving out
the pieces.

Off the top of my head the current todo looks like:
- kexec on panic user space preparation 
  Basically generating ELF headers of a CORE dump before
  we crash.

- Moving ioapic setup on x86 and x86_64 into init_IRQs, where it
  belongs.  Currently when using IOAPICs we use them for everything
  except calibrating the delay loop.  Where we assume the legacy
  interrupt controller is setup.  When initiating kexec from
  panic() we don't do a clean shutdown so that is not the case
  and SMP is broken.

Once those two pieces are in place and tested we should
be able to drop all of the crashdump-* patches.  As well
as the crash_shutdown patches that touch the apics.

Of course there will still be lots of pieces left to make the drivers
more robust, and to make things easier to use.    But all of those
are evolutionary improvements, not core architecture things.

> Do you have a feel for what proportion of machines will
> work correctly?

Yes.

For the non panic case I need to get ioapic virtual wire
setup working on ACPI systems. And I need to fix the ACPI
using interrupts on the shutdown path bug.

Most device drivers work without being touched.

So we should work fine on x86 and x86_64 systems
using either the legacy interrupt controller or IOAPICs.

So it should be most of x86 and x86_64 systems, working
with no more effort than I have described.   And as device
drivers are fixed even more systems.

In addition there is nothing non-portable about the architecture,
although avoiding firmware calls on non-embedded ports can be a very
challenging modification to the boot process.  So we should
be able to start picking up most machines on other architectures like
ppc, ppc64 and ia64 as soon the ports are complete.

>From a user perspective things are going to be rough for a while
as things all the final kinks get worked out.  But things will
be largely usable and we should be able to get usable
bug reports.  Of course that is the level where we start seeing
a whole new class of bug reports :)

The biggest theoretical gotcha are systems with hot plug memory.
As we are memorizing the memory map and storing it in a safe
along with the recovery kernel before a crash occurs.

Basically we are in pretty good shape except for systems
like an SGI-Altix or an IBM-s390.  Hot-plug memory, multi-terabyte
core dump sizes, and weird SMP architectures are problems that
we don't/won't cope with well.  With only hotplug memory requiring a
modification of responsibilities to handle.

Eric
