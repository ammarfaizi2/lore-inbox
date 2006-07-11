Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWGKO2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGKO2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWGKO2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:28:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:22101 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750809AbWGKO2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:28:53 -0400
Message-ID: <44B3B59C.3080506@tls.msk.ru>
Date: Tue, 11 Jul 2006 18:28:44 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Olaf Hering <olaf@aepfle.de>,
       "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <20060711134554.GC24029@thunk.org>
In-Reply-To: <20060711134554.GC24029@thunk.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Tue, Jul 11, 2006 at 06:48:34AM +0200, Olaf Hering wrote:
[]
> Kinit SHOULD be merged into the kernel, and the responsibility of
> creating the initrd/initramfs image should be moved from the
> distribution into the kernel build process.  There can and should be a

Hmm.

> way for distro's to add their own "value add specials" into the
> initrd/initramfs image, but we have to take over creating the base
> initial userspace environment.  It's not just uswsusp (still not
> convinced it's a good idea, but if we're going to do it we have to
> wrest control of the initramfs away from the distro's), but finding
> and mounting iSCSI disks, LVM setup, etc.
> 
>> In earlier mails you stated that having kinit/klibc in the kernel sources
>> would make it easier to keep up with interface changes.
>> What interface changes did you have in mind, and can you name any relevant
>> interface changes that were made after 2.6.0 which would break an external
>> kinit?
> 
> When you load a SCSI driver (the one that bit me was the MPT Fusion
> driver), it no longer waits for SCSI bus probe to finish before
> returning.  So the RHEL4 initrd fails to find the root filesystem, and
> bombs out.  This change was definitely made after 2.6.0, and is an
> example of the sort of change which wouldn't have happened if kinit
> was under the kernel sources and not supplied by the distro.

How kinit is involved in loading drivers, and how it will know
that it should wait for certain things after doing something?

Nowadays, udev+modprobe are responsible for loading drivers, not kinit.
If you suggesting kinit should do that, well.. it becomes bigger at
least.

And oh, determining which modules to include into initramfs...
it's definitely NOT part of kernel BUILD process, but, so to say,
kernel package install process (note I for one often build initramfses
for OTHER machines - something most mkinitrd solutions are unable to
do - by specifying eg alternative root filesystem, or different set
of modules etc).

[]
> Some of this will probably need to be farmed out into files provided
> by external packages, but I **hope** that they are true upstream
> external packages, and not distro-specific specials, which is one of
> the reasons why the current initrd/initramfs situation is
> so.... unsatisfactory.  Clearly some kernel-mandated interface for
> other packages to insert scripts and binaries during the early-boot
> process would be a good thing; but the core initramfs functionality
> should IMHO belong to the kernel.

The main reason why the situation is so unsatisfactory (yes it definitely
is), IMHO, is that it's at least difficult to discover which stuff should
be included into early userspace (initramfs).  For example, having a list
of drivers and their modaliases, I'd like to be able to get a list of
modules in *new* kernel for those devices (based on whatever currently
running kernel sees in PCI etc).  Another examples include stuff like
already mentioned softraid, lvm and iSCSI - that things should be provided
by upstream packages (mdadm, lvmtools etc), as hooks to initramfs creation
(as, for example, Debian and Ubunto currently tries to do, for their
home-grown initramfs-tools package).

I can give another example.  Somewhere between 2.6.11 and 2.6.14,
softraid module has been renamed from md.ko to md-mod.ko.  So my
home-grown (yes, yet another :) mkinitramfs broke.  So now it
contains something like
  if included "md-mod|md" CONFIG_RAID then
     ...
and later,
  modprobe md-mod || modprobe md
for root-on-md-device.  But the same should be done in mdadm
initscript as well so.. kinit does not help here again.
Ditto for various ide-mod, ide-generic/generic renames
(including distro-specific mods), and especially for - seems
to be upcoming - ide=>pata conversion (which has quite alot
of other side effects, since all sdXX devices will move and
hdXX will gone).

But that's all beyong the point really.  I mean, there's really nothing
which requires kinit to be in kernel.  The argument above - about waiting
for mptfusion to settle - is moot just because kinit does not (currently
anyway) provide that functionality.

(And oh... I really dislike udev being in initramfs... just like the whole
udev stuff in the first place... but that's entirely different topic ;)

/mjt
