Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751267AbWFESJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWFESJc (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWFESJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:09:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15752 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751267AbWFESJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:09:31 -0400
Date: Mon, 5 Jun 2006 20:09:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
In-Reply-To: <448366FB.1070407@zytor.com>
Message-ID: <Pine.LNX.4.64.0606050207080.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> <448366FB.1070407@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 4 Jun 2006, H. Peter Anvin wrote:

> Andrew Morton wrote:
> > 
> > git-klibc.patch
> > 
> >  Similar.  This all appears to work sufficiently well for a 2.6.18 merge.
> > But it's been so long since klibc was a hot topic that I've forgotten who
> >  wanted it, and what for.
> > 
> >  Can whoever has an interest in this work please pipe up and let's get our
> >  direction sorted out quickly.
> > 
> 
> klibc (early userspace) in its current form is fundamentally a cleanup.  What
> it does is unload code from the kernel which has no fundamental reason to be
> kernel code (written during kernel rules, with all the problems it entails.)
> The initial code to have removed is the root-mounting code, with all the
> various ugly mutations of that (ramdisk loading, NFS root, initrd...)

For a cleanup it adds quite a lot of code, where I'm not really sure it 
should all be distributed with the kernel. I'm really surprised there 
hasn't been any larger discussion about or maybe I missed something?

It adds various utitilies (dash, gzip, ...) to the kernel source, which 
are not kernel specific at all. Why do we need this duplication? IMO code 
duplication like this is not a desirable thing, as it increases the 
maintenance overhead. Sometimes this is necessary, but IMO it should have 
a good reason and should be temporary. Where does this duplication end 
(e.g. udev, module tools), are we going to pull everything into the kernel 
source, which might be needed for an initramfs?

I think the most questionable duplication is the libgcc copy. Why do you 
even provide your own copy of this? This is a private library of the 
compiler and the last thing I would duplicate.

How is this going to integrate with the rest of the system, especially on 
the distribution side. They have their own mechanisms to produce an 
initrd. What happens if NFS root requires a network module, which requires 
a firmware file? How is this going to work?
How can e.g. embedded users control what's going into the initramfs, they 
certainly don't want any duplication here (e.g. initrd on top of 
initramfs?)

I'm not really comfortable with merging the whole thing at once, it's a 
huge patch (or thousands of little commits) with no real documentation, 
which makes it very hard to review. IMO it would be preferable to 
distribute the non-kernel specific parts separatly and make this more 
modular, so that the user can exchange any part he like. The patch also 
already removes a lot of the old setup stuff, which makes it an 
all-or-nothing approach. It doesn't leave us with the possibility to make 
the new setup optional and gradually convert the various boot 
initialization to it and experiment a little with it at first (not just 
kernel developer but also everyone else).

Considering the impact all these changes will have, I would be really 
interested in more opinions on this or just does everyone hope it will 
somehow work out by itself?

bye, Roman
