Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUCWFGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUCWFF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:05:59 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:35793 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262002AbUCWFFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:05:52 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Date: Tue, 23 Mar 2004 16:05:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16479.50592.944904.708098@notabene.cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
In-Reply-To: message from Justin T. Gibbs on Friday March 19
References: <760890000.1079727553@aslan.btc.adaptec.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 19, gibbs@scsiguy.com wrote:
> [ CC trimmed since all those on the CC line appear to be on the lists ... ]
> 
> Lets take a step back and focus on a few of the points to which we can
> hopefully all agree:
> 
> o Any successful solution will have to have "meta-data modules" for
>   active arrays "core resident" in order to be robust.  This
>   requirement stems from the need to avoid deadlock during error
>   recovery scenarios that must block "normal I/O" to the array while
>   meta-data operations take place.

I agree.
'Linear' and 'raid0' arrays don't really need metadata support in the
kernel as their metadata is essentially read-only.
There are interesting applications for raid1 without metadata, but I
think that for all raid personalities where metadata might need to be
updated in an error condition to preserve data integrity, the kernel
should know enough about the metadata to perform that update.

It would be nice to keep the in-kernel knowledge to a minimum, though
some metadata formats probably make that hard.

> 
> o It is desirable for arrays to auto-assemble based on recorded
>   meta-data.  This includes the ability to have a user hot-insert
>   a "cold spare", have the system recognize it as a spare (based
>   on the meta-data resident on it) and activate it if necessary to
>   restore a degraded array.

Certainly.  It doesn't follow that the auto-assembly has to happen
within the kernel.  Having it all done in user-space makes it much
easier to control/configure.

I think the best way to describe my attitude to auto-assembly is that
it could be needs-driven rather than availability-driven.

needs-driven means: if the user asks to access an array that doesn't
  exist, then try to find the bits and assemble it.
availability driven means: find all the devices that could be part of
  an array, and combine as many of them as possible together into
  arrays.

Currently filesystems are needs-driven.  At boot time, only to root
filesystem, which has been identified somehow, gets mounted. 
Then the init scripts mount any others that are needed.
We don't have any hunting around for filesystem superblocks and
mounting the filesystems just in case they are needed.

Currently partitions are (sufficiently) needs-driven.  It is true that
any partitionable devices has it's partitions presented.  However the
existence of partitions does not affect access to the whole device at
all.  Only once the partitions are claimed is the whole-device
blocked. 

Providing that auto-assembly of arrays works the same way (needs
driven), I am happy for arrays to auto-assemble.
I happen to think this most easily done in user-space.

With DDF format metadata, there is a concept of 'imported' arrays,
which basically means arrays from some other controller that have been
attached to the current controller.

Part of my desire for needs-driven assembly is that I don't want to
inadvertently assemble 'imported' arrays.
A DDF controller has NVRAM or a hardcoded serial number to help avoid
this.  A generic Linux machine doesn't.

I could possibly be happy with auto-assembly where a kernel parameter
of DDF=xx.yy.zz was taken to mean that we "need" to assemble all DDF
arrays that have a controler-id (or whatever it is) of xx.yy.zz.

This is probably simple enough to live entirely in the kernel.

> 
> o Child devices of an array should only be accessible through the
>   array while the array is in a configured state (bd_claim'ed).
>   This avoids situations where a user can subvert the integrity of
>   the array by performing "rogue I/O" to an array member.

bd_claim doesn't and (I believe) shouldn't stop access from
user-space.
It does stop a number of sorts of access that would expect exclusive
access. 


But back to your original post:  I suspect there is lots of valuable
stuff in your emd patch, but as you have probably gathered, big
patches are not the way we work around here, and with good reason.

If you would like to identify isolated pieces of functionality, create
patches to implement them, and submit them for review I will be quite
happy to review them and, when appropriate, forward them to
Andrew/Linus.
I suggest you start with less controversial changes and work your way
forward.

NeilBrown
