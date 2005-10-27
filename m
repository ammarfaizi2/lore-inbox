Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVJ0HwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVJ0HwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVJ0Hv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:51:58 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:42990 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S964986AbVJ0Hvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:51:55 -0400
Date: Thu, 27 Oct 2005 16:45:50 +0900 (JST)
Message-Id: <20051027.164550.59465163.noboru.obata.ar@hitachi.com>
To: maneesh@in.ibm.com
Cc: hyoshiok@miraclelinux.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <20051013054940.GA15878@in.ibm.com>
References: <20051013054940.GA15878@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2005, Maneesh Soni wrote:
> 
> Many of the discussions are on fastboot mailing list. As of now
> work is being done to port kdump to x86_64 and ppc64 architectures
> and tackling the device initialization issues.

Thanks.

> > Reliability
> > -----------
> > 
> > In terms of reliability, hardware-related issues, such as a
> > device reinitialization problem, an ongoing DMA problem, and
> > possibly a pending interrupts problem, must be carefully
> > resolved.
> 
> As of now the idea is to tackle these issues as per driver basis,
> as and when reported. It seems there may not be any generic way 
> to solve device initialization.

Agreed.  A generic way would be something like what is done in
device_shutdown().  That is, make major drivers implement their
own "reset" code in struct device_driver, and call it upon a
crash.  It would be nice if the reset code also stops DMA
transfer.

I understand that doing this in the first kernel has a risk that
following a device chain upon a crash would cause further
problem when kernel memory is corrupted.  But the
driver-dependent reset code had better be implemented in its own
device_driver structure.  Hmm...

> > Manageability
> > -------------
> > 
> > As for manageability, it is nice if a user can easily setup
> > kdump just by writing DEVICE=/dev/sdc6 to one's
> > /etc/sysconfig/kdump and start the kdump service, for example.
> > It is also desirable that an action taken after capturing a dump
> > (halt, reboot, or poweroff) is configurable.  I believe these are
> > userspace tasks.
> 
> These are user space things and mostly distro specific. Though there
> are some prototypes done for automatically loading the second kernel
> and autmoatically saving the captured dump using initrd at
> http://lse.sf.net/kdump/ 

Interesting.  I'll try it.

My concern in this area is that the device name (e.g.,
/dev/sdc6) in the first kernel may not be the same in the second
kernel due to the order in loading device drivers.  Hope UUID in
recent filesystems would help.

> > One of my worries is that the current kdump requires distinct
> > two kernels (one for normal use, and one for capturing dumps) to
> > work.  And I'm not fully convinced whether a use of two kernels
> > is the only solution or not.  Well, I heard that this decision
> > better solves the ongoing DMA problem (please correct me if
> > other reasons are prominent), but from a pure management point
> > of view handing one kernel is happier than two kernels.
> 
> I think there were some efforts being done in having a relocatable
> kernel, which can facilitate running the same kernel as regular and
> dump capture kernel, though at different physical start address.

Hmm...

I'm wondering how the second kernel (and its associated device
drivers) will be provided when kdump-ready distros are shipped.

> > Flexibility
> > -----------
> > 
> > To minimize the downtime, a crashed kernel would want to
> > communicate with clustering software/firmware to help it detect
> > the failure quickly.  This can be generalized by making
> > appropriate hook points (or notifier lists) in kdump.
> > 
> Sorry, I am not getting what is being said here. I think the right thing
> is to always minimize what a crashed kernel is supposed to do. So, why/what
> should a crashed kernel communicate to someone.

The idea is to provide some hooks for a system administrator
that run upon a crash.

One would want to use this hook to provide the faster failover
in a clustering system.  Usually a failover is executed when a
heart-beat between nodes is lost.  Such a detection takes about,
say, 10 or 30 seconds, depending on a configuration.  But if the
oopsed node can notice the failure to others, the detection of
failure can be done more quickly, possibly less than a second.

Another use of this hook will be resetting devices.  If device
drivers in distros do not support robust reinitialization in the
second kernel, one would want to use this hook to reset the
device so that kdump works.

I'm not fully convinced that doing minimum on a crashed kernel
is always right.  As for preparing hardware conditions for the
second kernel, doing more on the crashed kernel may make sense
because most drivers expect that.

Anyway, providing appropriate hooks seems to be a good
compromise for me.

Regard,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

