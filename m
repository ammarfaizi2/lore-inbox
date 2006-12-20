Return-Path: <linux-kernel-owner+w=401wt.eu-S1030206AbWLTQuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWLTQuZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWLTQuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:50:25 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:57344 "EHLO
	mail-gw2.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbWLTQuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:50:24 -0500
To: mikulas@artax.karlin.mff.cuni.cz
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.64.0612201732040.6115@artax.karlin.mff.cuni.cz>
	(message from Mikulas Patocka on Wed, 20 Dec 2006 17:36:57 +0100
	(CET))
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0612201732040.6115@artax.karlin.mff.cuni.cz>
Message-Id: <E1Gx4dv-00058S-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Dec 2006 17:50:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> I've came across this problem: how can a userspace program (such as for
> >> example "cp -a") tell that two files form a hardlink? Comparing inode
> >> number will break on filesystems that can have more than 2^32 files (NFS3,
> >> OCFS, SpadFS; kernel developers already implemented iget5_locked for the
> >> case of colliding inode numbers). Other possibilities:
> >>
> >> --- compare not only ino, but all stat entries and make sure that
> >>  	i_nlink > 1?
> >>  	--- is not 100% reliable either, only lowers failure probability
> >> --- create a hardlink and watch if i_nlink is increased on both files?
> >>  	--- doesn't work on read-only filesystems
> >> --- compare file content?
> >>  	--- "cp -a" won't then corrupt data at least, but will create
> >>  	hardlinks where they shouldn't be.
> >>
> >> Is there some reliable way how should "cp -a" command determine that?
> >> Finding in kernel whether two dentries point to the same inode is trivial
> >> but I am not sure how to let userspace know ... am I missing something?
> >
> > The stat64.st_ino field is 64bit, so AFAICS you'd only need to extend
> > the kstat.ino field to 64bit and fix those filesystems to fill in
> > kstat correctly.
> 
> There is 32-bit __st_ino and 64-bit st_ino --- what is their purpose? Some 
> old compatibility code?

Yes.

> > SUSv3 requires st_ino/st_dev to be unique within a system so the
> > application shouldn't need to bend over backwards.
> 
> I see but kernel needs to be fixed for that. Would patches for changing 
> kstat be accepted?

I don't see any problems with changing struct kstat.  There would be
reservations against changing inode.i_ino though.

So filesystems that have 64bit inodes will need a specialized
getattr() method instead of generic_fillattr().

Miklos
