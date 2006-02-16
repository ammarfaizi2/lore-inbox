Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWBPRC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWBPRC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBPRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:02:58 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:29555 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750891AbWBPRC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:02:58 -0500
Message-ID: <43F4B002.9010007@cfl.rr.com>
Date: Thu, 16 Feb 2006 12:01:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Seewer Philippe <philippe.seewer@bfh.ch>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <43F4A519.4050005@bfh.ch>
In-Reply-To: <43F4A519.4050005@bfh.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 17:03:53.0744 (UTC) FILETIME=[F7472900:01C6331A]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14271.000
X-TM-AS-Result: No--17.790000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> I think what we should be talking about here is what is necessary to
> write a mbr and partition a disk, not how the whole c/h/s shebang works,
> because that is no longer of any real interest.
> 
> The important fact here is that Linux does not really depend on an MBR
> which matches the BIOS. Only other os do...

True.

> 
> The current behaviour of partitioning tools under Linux is (most of the
> time) quite simple: If an MBR exists, determine the geometry to use to
> create new partitions from the MBR.
> 
> The problem starts when creating a new MBR. In this case we need a
> geometry. There most Utilities depend (probably historically) on
> HDIO_GETGEO. By now we know that these values do not necessarily
> correspond to bios values. They don't have to, because they can contain
> as much bogus as we want. Why? Because all partitions will be created
> with these values as a base. The question here is actually only if the
> user wants compatible values or not.
> 

That is the sticking point.  The MBR can NOT contain whatever values we 
want.  It must contain the values that the bios expects, otherwise boot 
loaders that use those values will fail to operate correctly.

> The problem increases when we use tools such as dosemu, which need to
> emulate a bios. If we do things there like deploy windows with dosemu
> (please remember, this is just an example), the geometry values
> represented by dosemu need to be exactly the same as the bios returns.
> 

dosemu emulates the bios and talks to the disk via the kernel, so it 
does not care what the real bios geometry is, or even if there IS a real 
bios geometry.  You can run dosemu on any block device, including a loop 
device, which clearly has no geometry.  It can choose whatever geometry 
it wants to emulate, though it should probably use whatever existing 
geometry is in the MBR of the disk ( physical or virtual ) that you are 
having it use.

> The problem increases further with the use of bootloaders. Because they
> need at least some basic geometry information. See the thread "Support
> HDIO_GETGEO on device-mapper volumes" in this mailinglist for an example
> (Actually this thread is among the reasons why I started this).
> 

The boot loaders get it from the MBR if they are not operating in LBA 
mode.  The partitioners put the geometry in the MBR.  The geometry that 
they place there must match the values expected by the bios.  If the 
kernel does not know those values, then it should not lie to the 
partitioning tools about it, it should fail the request, and let the 
partitioning tool decide what to do.

> So the whole thing comes to the question whether we drop any interfaces
> reporting geometry, making userspace tools responsible or if we provide
> a common interface which can be modified by userspace if necessary.
> (There are no other workable options i can see)
> 

Right, the kernel can keep the old interface and rely on yet another 
user space tool to tell the kernel what it should report, or it can drop 
it and rely on the partitioners to deal with it.

> I vote for keeping it in the kernel, because otherwise tons of
> user-space tools would need to be modified and it actually might be the
> case that a driver knows what he's returning...
> 

You said already that as of 2.6 the kernel no longer knows the bios 
values, so the driver NEVER knows the right value to return.  Since that 
is the case, it should not pretend that it does know, it should let the 
user space partitioning tools know it does not know.  Yes, they may need 
modified to handle that case, but that is something they should have 
been doing a long time ago, and why complicate the kernel when this is 
really done in user space anyhow?


