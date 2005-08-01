Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVHAAA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVHAAA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVHAAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:00:56 -0400
Received: from hermes.domdv.de ([193.102.202.1]:61960 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262165AbVHAAAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:00:43 -0400
Message-ID: <42ED6610.9040202@domdv.de>
Date: Mon, 01 Aug 2005 02:00:16 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: "Brown, Len" <len.brown@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: revert yenta free_irq on suspend
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com> <20050731222751.GA28907@redhat.com>
In-Reply-To: <20050731222751.GA28907@redhat.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Jul 31, 2005 at 01:03:56AM -0400, Brown, Len wrote:
> 
>  > But that believe would be total fantasy -- supsend/resume is not
>  > working on a large number of machines, and no distro is currently
>  > able to support it.  (I'm talking about S3 suspend to RAM primarily,
>  > suspend to disk is less interesting -- though Red Hat doesn't
>  > even support _that_)
> 
> After the 'swsusp works just fine' lovefest at OLS, I spent a little
> while playing with the current in-tree swsusp implementation last week.
> 
> The outcome: I'm no more enthusiastic about enabling this in Red Hat
> kernels than I ever was before.  It seems to have real issues with LVM
> setups (which is default on Red Hat/Fedora installs these days).
> After convincing it where to suspend/resume from by feeding it
> the major/minor of my swap partition, it did actually seem
> to suspend. And resume (though it did spew lots of 'sleeping whilst
> atomic warnings, but thats trivial compared to whats coming up next).
> 
> I rebooted, and fsck found all sorts of damage on my / partition.
> After spending 30 minutes pressing 'y', to fix things up, it failed
> to boot after lots of files were missing.
> Why it wrote anything to completely different lv to where I told it
> (and yes, I did get the major:minor right) I have no idea, but
> as it stands, it definitly isn't production-ready.
> 
> I'll look into it again sometime soon, but not until after I've
> reinstalled my laptop.  (I'm just thankful I had the sense not to
> try this whilst I was at OLS).

Hmm,
I'm using swsusp on my x86_64 laptop with lvm and dm-crypt. Works just
fine except for nasty spontaneous reboots from time to time caused by
yenta_socket (I do get these since I started to access my pcmcia flash
disk from initrd to retrieve the dm-crypt swap key). It does work since
at least 2.6.11 up to 2.6.13-rc4 and if the yenta_socket caused
spontaneous reboots after resume could be fixed I'd call it production
ready.

gringo:~ # fdisk -l /dev/hda

Disk /dev/hda: 80.0 GB, 80026361856 bytes
255 heads, 63 sectors/track, 9729 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot   Start      End      Blocks   Id  System
/dev/hda1            1      244     1959898+  83  Linux
/dev/hda2          245      488     1959930   82  Linux swap / Solaris
/dev/hda3          489      732     1959930   82  Linux swap / Solaris
/dev/hda4          733     9729    72268402+   5  Extended
/dev/hda5          733      976     1959898+  82  Linux swap / Solaris
/dev/hda6          977     9729    70308441   88  Linux plaintext (*)

(*) dm-crypt :-)

gringo:~ # vgdisplay
  --- Volume group ---
  VG Name               rootvg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  27
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                8
  Open LV               8
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               67.05 GB
  PE Size               4.00 MB
  Total PE              17165
  Alloc PE / Size       14464 / 56.50 GB
  Free  PE / Size       2701 / 10.55 GB
  VG UUID               oHluq0-H5Nd-90dU-psLn-ygNT-u4GJ-D8aJhG

All filesystems are ext3 as I did have nasty experiences with reiserfs
on lvm+raid on another 2.6 system without ever using swsusp there.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
