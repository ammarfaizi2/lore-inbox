Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWGKEsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWGKEsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWGKEsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:48:40 -0400
Received: from ns.suse.de ([195.135.220.2]:49572 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965106AbWGKEsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:48:40 -0400
Date: Tue, 11 Jul 2006 06:48:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
Message-ID: <20060711044834.GA11694@suse.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 03:12:53PM +0200, Roman Zippel wrote:

> So anyone who likes to see klibc merged, because it will solve some kind 
> of problem for him, please speak up now. Without this information it's 
> hard to judge whether we're going to solve the right problems.

I do not want to see kinit merged.
It (the merge into linux-2.6.XY) doesnt solve any real problem in the long term.
Instead, make a kinit distribution. Let it install itself into an obvious
location on the development box (/usr/lib/kinit/* or whatever), remove all
code behind prepare_namespace() and put a disclaimer into the Linux 2.6.XY
releasenote stating where to grab and build a kinit binary:
make && sudo make install
It can even provide its own CONFIG_INITRAMFS_SOURCE file, so that would
be the only required change to the used .config.

The rationale is that there are essentially 2 kind of consumers:

One is the kind that builds static kernels and uses no initrd of any kind.
For those people, the code and interfaces behind prepare_namespace() has
not changed in a long time.
They will install that kinit binary once and it will continue to work with
kernels from 2.6.6 and later, when "/init" support was merged. Or rather
from 2.6.1x when CONFIG_INITRAMFS_SOURCE was introduced.

The other group is the one that uses some sort of initrd (loop mount or cpio),
created with tools from their distribution.
Again, they should install that kinit binary as well because kinit emulates
the loop mount handling of /initrd.image. This is for older distributions
that still create a loop mounted initrd.
A distribution that uses a cpio archive (SuSE does that since 2.6.5 in SLES9,
and since 2.6.13 in 10.0) has no need for the kinit. mkinitrd creates a
suitable cpio archive and the contained "/init" executable does all the 
hard work (as stated in the comment in init/main.c:init())


In earlier mails you stated that having kinit/klibc in the kernel sources
would make it easier to keep up with interface changes.
What interface changes did you have in mind, and can you name any relevant
interface changes that were made after 2.6.0 which would break an external
kinit?

24-klibc-basic-build-infrastructure.patch forces the klibc build, even for
setups where it is not required. CONFIG_KLIBC, if it ever gets merged, should
be optional. usr/initramfs.default as example has a hard requirement.
If CONFIG_KLIBC is off, only /dev, /dev/console and /root should be part of
the cpio archive in the .init.ramfs ELF section. The exectuables come from
the cpio initrd.
I once looked briefly for a patch that would introduce something like 
CONFIG_OBSOLETE_PREPARE_NAMESPACE which will make all code behind
prepare_namespace() optional. For SuSE, this dead code just wastes build time,
and it increases the vmlinux file size. While looking for ROOT_DEV users,
it wasnt obvious to me what requirements mtd has, so I postponed that attempt.
I'm sure ROOT_DEV can go as well in your patch named
29-remove-in-kernel-root-mounting-code.patch
All can be done outside the kernel code, and there is the root= cmdline option.


As others have stated in this thread, the code behind prepare_namespace() is 
very simple. It doesnt know anything abould lvm etc, nor about mount by
filesystem UUID/LABEL nor does it know how to deal with properly with new
technologies like iSCSI, evms, persistant storage device names, usb-storage,
sbp2 or async device probing.
Should all that knowledge end up in the kernel source on day?
An external kinit for such features sounds more logical.
If there are no plans to add these features, that just means that kinit
is real static functionality-wise. So having it as external binary makes
even more sense, given the amount of build time to spent for every new kernel.

Not really related to kinit per se:
There is also not much distribution specific inside initramfs (beside the file
locations to actually create a suitable cpio archive). There is still the
boundary between "/init" and the real init on the final root filesystem.
Otherwise static kernels would not be usable on these distributions.
I'm sure a mkinitrd that works for every distribution out there is possible.
