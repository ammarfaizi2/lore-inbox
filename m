Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVBDBUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVBDBUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVBDBTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:19:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41348 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261658AbVBDA5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:57:31 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: kdump on non-boot cpu
References: <20050203171700.18E7.ODA@valinux.co.jp>
	<m1pszi6k45.fsf@ebiederm.dsl.xmission.com>
	<20050204082358.18ED.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 17:55:03 -0700
In-Reply-To: <20050204082358.18ED.ODA@valinux.co.jp>
Message-ID: <m1fz0d9mag.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> On 03 Feb 2005 02:58:02 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > Itsuro Oda <oda@valinux.co.jp> writes:
> > 
> > > Hi,
> > > 
> > > This is not for kdump but an experience of our project(mkdump).
> > > The dump kernel(not SMP config) boot hangs if machine_kexec()
> > > excutes on non-boot CPU on x86_64 platform.
> > 
> > ?? x86_64 is Opteron cpu, amd64, Intel cpu?
> > Are the kernels running in 32bit or 64bit mode. I'm guessing
> > SMP Opterons running in 32bit mode.
> 
> SMP Opterons running in 64bit mode. (The normal kernel is SMP configed.
> The dump kernel is not SMP configed.)

The reason I was asking and assuming you had a 32bit kernel is that
you were quoting pieces of arch/i386/kernel/crash.c instead of
arch/x86_64/kernel/crash.c

While the functionality can easily be transfered I didn't think
any one had done that yet.

> > Anyway one thing I want to do is actually drop the apic shutdown
> > code altogether in this code path.  
> 
> It sounds nice. (if available)

All that has to happen is to drop the x86-crash_shutdown-apic-shutdown.patch
from Andrews tree.  That patch just added the handful of lines that
disabled the apics.   Once I get a test case that someone can boot a
kernel without disabling apics I will ask Andrew to drop the above
mentioned patch.

> > My best hunch is that your UP kernel is not getting interrupts.
> 
> yes. It seems the timer interrupts is not comming up.
> 
> > Any chance on getting a serial console boot log?  
> > 
> attached. both success case and unsuccess case.

Thanks.

> > I suspect it can be made to work if you compile your UP
> > kernel with IOAPIC support.  I do know the table parsers
> > no longer complain about the configuration.
> 
> with IOAPIC support. the config is attached.

Ok. Thanks.  This is a legitimate bug.  And it is probably the reason
I even care about the non-SMP interrupt case some days.  The problem
is that the kernel just assumes interrupts are setup in non-APIC mode
when it starts booting, and quite possibly only the bootstrap cpu can
see those interrupts. 

So I believe the fix needs to be to enable apics before we calibrate
the delay timer.  I'm not certain off the top of my head what that
patch will look like but it should not be fundamentally hard.  
With that code in place we also don't need to do any APIC shutdown
as the kernel knows enough to completely setup the apics.

Eric
