Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWF2AfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWF2AfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWF2AfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:35:03 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30161 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751847AbWF2AfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:35:01 -0400
Date: Wed, 28 Jun 2006 17:34:46 -0700
Message-Id: <200606290034.k5T0YkCw028911@terminus.zytor.com>
Newsgroups: linux.dev.kernel
Subject: Re: klibc and what's the next step?
Summary: 
Expires: 
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home> <f5e0f599448456bcbf2699994f0bbc76@bga.com> <Pine.LNX.4.64.0606290117220.17704@scrub.home>
From: "H. Peter Anvin" <hpa@zytor.com>
Followup-To: 
Distribution: 
Organization: Mostly alphabetical, except Q, with we do not fancy
Keywords: 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Milton Miller <miltonm@bga.com>, LKML <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.64.0606290117220.17704@scrub.home>
By author:    Roman Zippel <zippel@linux-m68k.org>
In newsgroup: linux.dev.kernel
> > 
> > * There is concern about how much is bloat, where do we draw the line 
> > for in-kernel
> 
> That actually wouldn't be my initial concern. Otherwise I'm happy to point 
> out kernel bloat, but here it's more important to prototype a mechanism. 
> In this case bloat can still be fixed later, as it's rather isolated 
> behind a standard API.
> 

First of all, I don't think there is any significant amount of bloat
(in the sense of a larger kernel image.)  I'm not saying kinit-based
kernel images are *smaller*, but they shouldn't be significantly
larger.

Additionally, you can trivially exclude it in entirety by overriding
initramfs_source.txt, if you are providing your own initramfs, which a
lot of people do nowadays.

> > * There is concern about duplicating user space utilities.  We moved 
> > the kernel broken md assemble instead of getting the current one from 
> > mdadm, and that should be part of mdadm package.
> 
> The problem here is twofold. First, duplication means extra maintenance 
> overhead, various version of the copies have to be kept in sync. The 
> temptation to fix only the kernel version without updating the normal 
> version could be quite big, so that users might not realize they have 
> broken tools until they e.g. try reconfigure the system.
> Second, whatever we deliver with the kernel, might become part of kernel 
> API (e.g. config files), which needs to be supported for a long time. 
> Compatibility code can accumulate rather quickly.

The code currently in kinit is trying to be as closely compatible with
the mainstream kernel as practical -- a drop-in replacement.  Thus, I
have actively avoided making radical changes, and have in fact jumped
through hoops trying to stay as close to the current model as humanly
possible unless incredibly obsolete (rdev on x86, everyone I've talked
to agrees it's not worth supporting; it would be trivial if it's ever
an issue.)

I definitely agree -- and I'm sure Neil does as well -- that the md
code should be rewritten, but as long as the whole thing is maintained
by me out of tree I want to minimize the delta.

The whole point of this exercise is that it gives us a platform by
which to reduce the maintenance of multiple different code bases.
Kernel programming is completely different than user-space
programming, it's poorly understood, and it is much more difficult.
With klibc, it's trivial to share code with even fairly large
userspace projects (e.g. udev); furthermore it is trivial to create
standalone components (e.g. nfsmount) which can not only be tested
standalone, but actually used by customized userspaces, thus
improving code reuse and reducing overall complexity.

> > * Some distributions are already using klibc and have been.  They see 
> > the reason to merge is to have the canonical api with the kernel to 
> > avoid version mismatch.
> 
> klibc will continue as independent project anyway, so it should not be 
> difficult to include from the kernel whatever the distribution provides. 
> It would help avoiding possible problems with mixing binaries built from 
> different libraries.

As long as klibc/kinit is not merged, the current code will have to be
maintained.  This means maintaining in-kernel ipconfig, nfsroot, and
it pretty much dooms the possibility of getting stuff like md detect
and partition discovery rewritten.

The utility of klibc is thus greatly diminished by not having it in
the mainline kernel tree.  Its performance in -mm so far has shown
that it works just fine.

Incidentally, there is one more reason for klibc which hasn't gotten
much mention, but it provides a prototype userspace for kernel
developers to:

  a) test new features (or at least a significant subset thereof), and
  b) document, in code, a recommended way for the more advanced libcs
     to make new features available to userspace, in the form of
     headers and the like.

	-hpa

