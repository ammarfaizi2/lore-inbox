Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSHSAoU>; Sun, 18 Aug 2002 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSHSAoU>; Sun, 18 Aug 2002 20:44:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15002 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S316578AbSHSAoT>; Sun, 18 Aug 2002 20:44:19 -0400
Date: Sun, 18 Aug 2002 18:48:16 -0600
Message-Id: <200208190048.g7J0mGW12548@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <Pine.LNX.4.44.0208060034260.28515-100000@serv>
References: <200208052212.g75MCrN17655@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208060034260.28515-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies for the late response. I had half a reply composed, then
got distracted by other things]
Roman Zippel writes:
> Hi,
> 
> On Mon, 5 Aug 2002, Richard Gooch wrote:
> 
> > > > Yes. RTFS.
> > >
> > > I'm trying - without getting headache.
> >
> > Take a valium.
> 
> Staying away from devfs sources is cheaper.

Valium might also help you resist taking cheap shots.

> > > In the "devfs=only" case, where is the module count incremented, when a
> > > block device is opened?
> >
> > The module count is incremented when the device is opened,
> > irrespective of whether it's a character or block device, or even a
> > "regular" file.
> 
> Would you please answer my question and tell me where that exactly
> happens in that case?

I've already told you about fops_get(). And for a block device, it's
def_blk_fops.open().

> > > > No. I leverage fops_get(), a common function.
> > >
> > > Which is also insufficiently protected.
> >
> > Incorrect.
> 
> What protects the module from unloading from getting the ops pointer
> until try_inc_mod_count()?

Well, I was going to say that once devfs_unregister() has been called,
you can't get reach devfs_open() for that entry, because the
corresponding dentry is unhashed, and devfs_lookup() won't reach the
entry either.

However, after thinking about it more closely, I note that if you have
already started devfs_open(), and then the module tries to unload,
there is a small window before the call to def_blk_fops.open()/fops_get()
where the ops pointer can become invalid. I've fixed that in my tree,
by using devfs_get_ops(), which safely handles this. I've also added
some comments, to make it clearer.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
