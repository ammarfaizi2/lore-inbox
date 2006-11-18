Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755982AbWKRKqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbWKRKqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbWKRKqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:46:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:34488 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1755982AbWKRKq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:46:29 -0500
Date: Sat, 18 Nov 2006 01:47:06 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)
Message-ID: <20061118094706.GA17879@kroah.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home> <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DD42B.1020004@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:24:27PM +0100, Stefan Richter wrote:
> I wrote:
> > Mattia Dongili wrote:
> >>>> http://oioio.altervista.org/linux/2.6.19-rc5-mm2-1-ko
> > and
> > http://oioio.altervista.org/linux/config-2.6.19-rc5-mm2-1
> > | # CONFIG_SYSFS_DEPRECATED is not set
> > 
> > | ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[080046030227e7bb]
> > | ieee1394: Node removed: ID:BUS[20754571-38:0455]  GUID[00000000f8ee6067]
> > | BUG: unable to handle kernel NULL pointer dereference at virtual
> > address 000000a4
> > |  printing eip:
> > | c0238c60
> > | *pde = 00000000
> > | Oops: 0000 [#1]
> > | SMP
> > | last sysfs file: /devices/pci0000:00/0000:00:00.0/class
> > [...]
> > | EIP is at class_device_remove_attrs+0xd/0x34
> > | eax: f7e02b8c   ebx: 00000000   ecx: ffffffff   edx: 00000000
> > | esi: 00000000   edi: f7e02b8c   ebp: f7629e04   esp: f7629df8
> > | ds: 007b   es: 007b   ss: 0068
> > | Process rmmod (pid: 2419, ti=f7628000 task=f702a550 task.ti=f7628000)
> > | Stack: f7e02b8c f7e02b94 00000000 f7629e20 c0238d47 00000000 f7e02a30
> > f7e02b8c
> > |        f7e02a30 00000000 f7629e2c c0238d82 f7e029f4 f7629e54 f8d5da3d
> > f8d63087
> > |        013cb08b 00000026 000001c7 f8ee6067 00000000 00000000 f8d5da52
> > f7629e5c
> > | Call Trace:
> > |  [<c0238d47>] class_device_del+0xc0/0xf0
> > |  [<c0238d82>] class_device_unregister+0xb/0x15
> > |  [<f8d5da3d>] nodemgr_remove_ne+0x64/0x79 [ieee1394]
> > |  [<f8d5da5d>] __nodemgr_remove_host_dev+0xb/0xf [ieee1394]
> > |  [<c02366dc>] device_for_each_child+0x1d/0x46
> > |  [<f8d5dd82>] nodemgr_remove_host+0x36/0x5d [ieee1394]
> > |  [<f8d5b4f3>] __unregister_host+0x1b/0x9c [ieee1394]
> > |  [<f8d5b70b>] highlevel_remove_host+0x24/0x47 [ieee1394]
> > |  [<f8d5b14f>] hpsb_remove_host+0x3b/0x5c [ieee1394]
> > |  [<f8dcbf9d>] ohci1394_pci_remove+0x47/0x1c7 [ohci1394]
> > |  [<c01dd619>] pci_device_remove+0x19/0x39
> > 
> > Either the FireWire host's device->klist_children was overwritten before
> > the call to device_for_each_child
> 
> or *during* the run of device_for_each_child, which first successfully
> called nodemgr_remove_ne for node [0-00:1023] but then stumbled over the
> false node [20754571-38:0455].
> 
> > (perhaps nodemgr didn't hold a reference which it should have), or/and
> > all of this is an issue with the ongoing migration away from class_device.

I don't have any firewire class_device migration patches in -mm right
now.

I do have one sitting here if you wish to play around with it, but it
needs some more infrastructure patches that I have not really tested all
that well yet.

Either way, I don't think this is caused by any new class_device
patches, but I'm very willing to be proven wrong :)

thanks,

greg k-h
