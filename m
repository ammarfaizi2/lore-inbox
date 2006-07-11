Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWGKK34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWGKK34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWGKK3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:29:55 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:41553 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750970AbWGKK3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:29:54 -0400
Message-ID: <44B37D9D.8000505@tls.msk.ru>
Date: Tue, 11 Jul 2006 14:29:49 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de>
In-Reply-To: <20060711044834.GA11694@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> On Tue, Jun 27, 2006 at 03:12:53PM +0200, Roman Zippel wrote:
> 
>> So anyone who likes to see klibc merged, because it will solve some kind 
>> of problem for him, please speak up now. Without this information it's 
>> hard to judge whether we're going to solve the right problems.
> 
> I do not want to see kinit merged.
> It (the merge into linux-2.6.XY) doesnt solve any real problem in the long term.
> Instead, make a kinit distribution. Let it install itself into an obvious
> location on the development box (/usr/lib/kinit/* or whatever), remove all
> code behind prepare_namespace() and put a disclaimer into the Linux 2.6.XY
> releasenote stating where to grab and build a kinit binary:

kinit SHOULD go with kernel. To stay compatible, to be able to move some more
stuff to it from kernelspace with time, and so on.

The question was about klibc, not kinit.

> The rationale is that there are essentially 2 kind of consumers:
> 
> One is the kind that builds static kernels and uses no initrd of any kind.
> For those people, the code and interfaces behind prepare_namespace() has
> not changed in a long time.
> They will install that kinit binary once and it will continue to work with
> kernels from 2.6.6 and later, when "/init" support was merged. Or rather
> from 2.6.1x when CONFIG_INITRAMFS_SOURCE was introduced.

And stuff will break on them after eg uswsusp move into kinit etc.

> The other group is the one that uses some sort of initrd (loop mount or cpio),
> created with tools from their distribution.
> Again, they should install that kinit binary as well because kinit emulates
> the loop mount handling of /initrd.image. This is for older distributions
> that still create a loop mounted initrd.

There's no need for loop-mounting of any initrd.images.  Initramfs (cpio image,
possible gzipped) works just fine, and it will NOT go away because something
should do the unpacking/loading of that image so that kinit &Co will run.
There's no need for old initrd+pivot_root at all.  Only the ones who are,
for some reason, didn't switch to initramfs yet.  And I personally see no
reasons not to switch - initramfs (rootfs) concept is much more clean and
easy to handle and gives more possibilities than initrd.

> A distribution that uses a cpio archive (SuSE does that since 2.6.5 in SLES9,
> and since 2.6.13 in 10.0) has no need for the kinit. mkinitrd creates a
> suitable cpio archive and the contained "/init" executable does all the 
> hard work (as stated in the comment in init/main.c:init())

It does need that.  At least partially.  Or, it should provide compatible
replacement for the next kernel you compile -- See above, with more stuff
moved from kernel to kinit (or utils based on it), the more tricky it will
be to maintain such a beast outside of the kernel.

> In earlier mails you stated that having kinit/klibc in the kernel sources
> would make it easier to keep up with interface changes.
> What interface changes did you have in mind, and can you name any relevant
> interface changes that were made after 2.6.0 which would break an external
> kinit?

Ok.  To be fair, except of swsusp (which i don't use anyway, as it does not
work on VIA C3-based boxes), I can't think of anything more.  The rest (like
dhcp (kernel-level IP autoconfig), etc) is already in kinit, and it should
be compatible with future kernels.

So hmm.  Maybe my arguments above are wrong.

Once that same swsusp is moved to kinit, the latter should be updated --
that's basically all.

> 24-klibc-basic-build-infrastructure.patch forces the klibc build, even for
> setups where it is not required. CONFIG_KLIBC, if it ever gets merged, should
> be optional. usr/initramfs.default as example has a hard requirement.
> If CONFIG_KLIBC is off, only /dev, /dev/console and /root should be part of
> the cpio archive in the .init.ramfs ELF section. The exectuables come from
> the cpio initrd.

Agreed 100%.

> I once looked briefly for a patch that would introduce something like 
> CONFIG_OBSOLETE_PREPARE_NAMESPACE which will make all code behind
> prepare_namespace() optional. For SuSE, this dead code just wastes build time,
> and it increases the vmlinux file size. While looking for ROOT_DEV users,
> it wasnt obvious to me what requirements mtd has, so I postponed that attempt.
> I'm sure ROOT_DEV can go as well in your patch named
> 29-remove-in-kernel-root-mounting-code.patch
> All can be done outside the kernel code, and there is the root= cmdline option.
> 
> 
> As others have stated in this thread, the code behind prepare_namespace() is 
> very simple. It doesnt know anything abould lvm etc, nor about mount by
> filesystem UUID/LABEL nor does it know how to deal with properly with new
> technologies like iSCSI, evms, persistant storage device names, usb-storage,
> sbp2 or async device probing.
> Should all that knowledge end up in the kernel source on day?
> An external kinit for such features sounds more logical.
> If there are no plans to add these features, that just means that kinit
> is real static functionality-wise. So having it as external binary makes
> even more sense, given the amount of build time to spent for every new kernel.

Nod.

/mjt

> Not really related to kinit per se:
> There is also not much distribution specific inside initramfs (beside the file
> locations to actually create a suitable cpio archive). There is still the
> boundary between "/init" and the real init on the final root filesystem.
> Otherwise static kernels would not be usable on these distributions.
> I'm sure a mkinitrd that works for every distribution out there is possible.

