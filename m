Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265549AbSJXRGc>; Thu, 24 Oct 2002 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265556AbSJXRGc>; Thu, 24 Oct 2002 13:06:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26929 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265549AbSJXRGb>; Thu, 24 Oct 2002 13:06:31 -0400
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
	<1035328636.29319.55.camel@andyp> <m1ptu1sm5u.fsf@frodo.biederman.org>
	<1035393105.25019.73.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Oct 2002 11:10:36 -0600
In-Reply-To: <1035393105.25019.73.camel@andyp>
Message-ID: <m1vg3rrcdv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> > > lspci output for the system:
> > > 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> > > 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> > > 00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
> > > 00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 08)
> 
> > > 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> > > 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> > > 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
> > > 01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
> 
> 
> > And please tell me what kexec_test-1.4 reports. I would love to find out which
> 
> > BIOS calls are hanging your system.
> 
> It's this one: call print_dasd_type

Cool, thanks.  

This is both good, and bad.
The Good: This BIOS call is only used to populate disk_info to get the
          disk geometry, which is only in hd.c, and further this call
          rests on a broken assumption that the both the first and the
          second BIOS disks are IDE, so it should be safe to remove
          the call from setup.S,  And there is another filter in 
           that makes it work.

The Bad: That would take patching the kernel, so on some machines
         older kernels will not work...

I have not setup the x86 pic so it may be worth setting that up and
testing to see if that helps. 
 
> If I comment it out, kexec_test-1.4 runs to completion.
> 
> FYI: My installation is on a scsi disk.  I'm beginning to wonder if
> there is something funky with the BIOS not being able to talk to
> the SCSI controller after the kernel has used it...  Hmmm.

I would not be surprised, if that is part of the problem.
Did you have to edit the aic7xxx reboot notifier to get scsi reboots
to work?  The reboot notifier should be what sets the controller up
so it can be reinitialized by Linux later.

I am attempting to figure out where to go with the user space side to 
get a useable, and useful ability to boot new kernels.

Pieces:
1) If loaded from loadlin or a sufficiently buggy BIOS is present
   we need to skip the 16bit BIOS calls already.
2) It is ideal to requery the system BIOS in case there are enhancements
   like the EDD work that make the new kernel more useable.

So my strategy will be:
1) As much as is reasonable fix setup.S to work in strange hostile environments,
   there is a lot to be gained and currently it usually works as is.
2) Query the existing kernel infrastructure and as much as possible
   fill in the table of data wants.  And I will skip to the 32bit entry point,
   with that information.

The second will take a bit more work, but having it as an option looks like
a very healthy thing to have.

Eric

