Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbUKKAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUKKAPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUKKAPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:15:52 -0500
Received: from soundwarez.org ([217.160.171.123]:50107 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262161AbUKKAMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:12:14 -0500
Date: Thu, 11 Nov 2004 01:12:12 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: /sys/devices/system/timer registered twice
Message-ID: <20041111001212.GA2796@vrfy.org>
References: <20041109193043.GA8767@vrfy.org> <20041109193947.GA5758@kroah.com> <20041110022535.GA10011@vrfy.org> <20041110223629.GA5925@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110223629.GA5925@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 04:36:29PM -0600, Maneesh Soni wrote:
> On Wed, Nov 10, 2004 at 03:25:35AM +0100, Kay Sievers wrote:
> > On Tue, Nov 09, 2004 at 11:39:47AM -0800, Greg KH wrote:
> > > On Tue, Nov 09, 2004 at 08:30:43PM +0100, Kay Sievers wrote:
> > > > Hi,
> > > > I got this on a Centrino box with the latest bk:
> > > > 
> > > >   [kay@pim linux.kay]$ ls -l /sys/devices/system/
> > > >   total 0
> > > >   drwxr-xr-x  7 root root 0 Nov  8 15:12 .
> > > >   drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
> > > >   drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
> > > >   drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
> > > >   drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
> > > >   drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
> > > >   ?---------  ? ?    ?    ?            ? timer
> > > > 
> > > > 
> > > > It is caused by registering two devices with the name "timer" from:
> > > > 
> > > >   arch/i386/kernel/time.c
> > > >   arch/i386/kernel/timers/timer_pit.c
> > > > 
> > > > If I change one of the names, I get two correct looking sysfs entries.
> > > > 
> > > > Greg, shouldn't the driver core prevent the corruption of the first
> > > > device if another one tries to register with the same name?
> > > 
> > > Yes, we should handle this.  Can you try the patch below?  I just sent
> > > it to Linus, as it fixes a bug that was recently introduced.
> > > 
> > > The second registration should fail, and this patch will make it fail,
> > > and recover properly.
> > 
> > Yes, the registration fails. But it seems that the second call to
> > create_dir(kobj) with a kobject with the same name and parent corrupts
> > the dentry from the first call.
> > 
> > To test it, I just called create_dir(kobj) a second time for my video
> > driver and the sysfs entry of the successful registered kobject was
> > corrupted:
> 	> 
> >   [kay@pim ~]$ ls -la /sys/class/video4linux/
> >   total 0
> >   drwxr-xr-x   3 root root 0 Nov 10 02:53 .
> >   drwxr-xr-x  18 root root 0 Nov 10 02:53 ..
> >   ?---------   ? ?    ?    ?            ? video0
> > 
> 
> Thanks for reporting this bug. I think the problem here is doing d_drop()
> for the existing directory dentry in create_dir() for error case. It should
> not be done for EEXIST. Could you please try the same test with the following 
> patch applied.

My second create_dir(), also and the double "timer" registration do not corrupt
the sysfs directory from the first call anymore. Nice fix!

Thanks,
Kay
