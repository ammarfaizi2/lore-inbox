Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSDJR6Z>; Wed, 10 Apr 2002 13:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313392AbSDJR6Y>; Wed, 10 Apr 2002 13:58:24 -0400
Received: from air-2.osdl.org ([65.201.151.6]:46347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313384AbSDJR6Y>;
	Wed, 10 Apr 2002 13:58:24 -0400
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: suparna@in.ibm.com, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <m1y9fvlfyb.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 10:58:42 -0700
Message-Id: <1018461522.4453.212.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 08:40, Eric W. Biederman wrote:

> Unless I missed something the Linux kernel won't work on smp though.
> It is a matter of resetting the state of the apics, and ensuring you
> are running on the first processor.  I don't believe bootimg did/does that.
> 

The copy of bootimg that I have makes no effort to offline CPU's or
reset the APICs.  If there is a newer version, I could not find it.

I have tried 3 different solutions for for Linux-reloading-linux
(bootimg, two-kernel monte, and kexec), and none of them fully support
the kinds of enterprise-class systems we (OSDL) care about:

	1. multiprocessor x86 (p3, p4, +xeons) with APICs
	2. >4GB memory
	3. CPU hotplug
	4. device hotplug
	5. >= 2.5.x kernel

In fact, I have yet to find any variation of linux-loading-linux that
works at all on the 2-way P4-Xeon under my desk or the 8-way P3-Xeon in
the lab.  The only system I have ever seen Two Kernel Monte work on here
is a Celeron-based machine in a nearby cube.

Why do we care about this?  Rebooting these kinds of sytsems can take
several minutes, and in my sample of the systems in the lab, ~80% of the
reboot time is spent slogging through the platform's firmware, ~20% of
the time is spent between LILO and login:.  80% of several minutes is
often greater than the allowable annual downtime for some enterprise
systems.

What about LinxuBIOS?  While an attractive solution for many, it is a
long, uphill battle to add support for chipset after chipset, and
motherboard after motherboard.

The >4GB of memory problem is an interesting quirk -- if the
linux-loading-linux implementation assumes that it can perform the final
copy in 32-bit protected mode *without* paging enabled, it won't
reliably work on >4GB systems.

> In general yes.  There are some interesting side effects though.
> Going through the pci bus and shutting off bus masters is a good
> first approximation of what needs to happen.
> 

The new device model from Pat (mochel@osdl.org) is probably the best way
to go here; you'll be able to walk the driver tree and reliably turn off
devices.

For the CPU side of things, the CPU hotplug work looks promising as
well.

Andy


