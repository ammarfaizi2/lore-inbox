Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272221AbRHWFFx>; Thu, 23 Aug 2001 01:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272222AbRHWFFn>; Thu, 23 Aug 2001 01:05:43 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:419 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272221AbRHWFFb>; Thu, 23 Aug 2001 01:05:31 -0400
Date: Wed, 22 Aug 2001 23:05:54 -0600
Message-Id: <200108230505.f7N55sr05856@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Taylor Carpenter <taylorcc@codecafe.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
In-Reply-To: <20010822191227.A11226@pioneer.oftheInter.net>
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net>
	<200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca>
	<20010821223042.A30478@pioneer.oftheInter.net>
	<200108220507.f7M576q25412@vindaloo.ras.ucalgary.ca>
	<20010822191227.A11226@pioneer.oftheInter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taylor Carpenter writes:
> On Tue, Aug 21, 2001 at 11:07:06PM -0600, Richard Gooch wrote:
> > Taylor Carpenter writes:
> > Trace; c015469b <devfs_unregister_blkdev+12eb/1960>
> > Are you unloading the floppy driver at some point? Or using module
> > autoloading?
> 
> I am using module autoloading.  It seems that right after the
> mountall script is called this happens.

You mean the floppy module gets loaded as a result of the mountall
script being run?

> > Interesting. What happens if you use /dev/floppy/0 instead of /dev/fd0
> > in the /etc/fstab? Still an Oops?
> 
> I will try that...  
> 
> I did not get the oops, but I could not access the device until I manually
> loaded the floppy module (the /dev/fd0 was created as usual).

Is the /etc/modules.devfs the one that ships with devfsd?
Specifically, you need the following line:
alias     /dev/floppy		floppy

and of course the MODLOAD action in /etc/devfsd.conf.

> After booting w/the floppy module not loaded I can start and stop
> devfsd and load and unload the floppy module in any order w/o an
> oops. I only get the oops if the module is loaded during boot.
> 
> Also when I get the oops during boot, the floppy module is not
> loaded once the system is through booting and I login, but /dev/fd*
> are all there!  With out the oops /dev/fd* is only there when I load
> the floppy module (and disappears as usual when I rmmod the module).

Do you mean to say that the Oops happens during the boot sequence,
before you can log in?

> > Strange. I tried the following sequence, without problems:
> > # devfsd /dev
> > # mount /floppy
> > # ls -lF /dev/floppy
> 
> I could not mount the floppy until I manually loaded the floppy
> module!  This is after editing /etc/fstab as you said below.

You must have a bogus /etc/devfsd.conf or /etc/modules.devfs file for
module autoloading not to work.

> > where /etc/fstab has:
> > /dev/floppy/0  /floppy  ext2  defaults,noauto,user  0 0
> > 
> > I have nothing in my /etc/devfsd.conf which refers to the floppy.
> 
> I only reference floppy in my perms file.

I don't know what a "perms" file is. I know Debian uses some
convoluted directory tree for devfsd configuration, but frankly, I
don't want to know about that. If you have one of these monstrosities,
please collapse them all into a single /etc/devfsd.conf file a report
based on that.

> > In addition, I don't have any LOOKUP entries. I did this with 2.4.9 with
> > devfs-patch-v188.
> 
> I have many LOOKUP entries.  I did not have any specific to
> /dev/fd*, but that was caught by the .* LOOKUP entry.  I commented
> that out, which is probably why mdir and other commands do not work
> w/o manually loading floppy.o.

Oh! Well, duh!

> > Could you please try reproducing the problem with the setup and sequence I
> > used?
> 
> I believe I followed your steps, and had no oops during boot w/the
> /etc/fstab change.  I do not think that made the difference though.
> I think telling devfsd to not autoload floppy is what let me boot
> w/o oops.  So I think there still is a problem w/loading the floppy
> module during boot.

Hm. Please try a virgin 2.4.9 kernel with CONFIG_DEVFS_FS=n and try
again. I have this feeling that I'm chasing someone else's bug...

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
