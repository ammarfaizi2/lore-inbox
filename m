Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbRLGGJx>; Fri, 7 Dec 2001 01:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282771AbRLGGJe>; Fri, 7 Dec 2001 01:09:34 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46217 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285426AbRLGGJW>; Fri, 7 Dec 2001 01:09:22 -0500
Date: Thu, 6 Dec 2001 23:09:14 -0700
Message-Id: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] / ALSA-0.9.0beta[9,10]
In-Reply-To: <20011207003528.1448673e.rene.rebe@gmx.net>
In-Reply-To: <20011207003528.1448673e.rene.rebe@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
> At least since 2.4.17-pre4 and -pre5 devfs is not handling
> permissions in the right way with ALSA:

Please define what is the "right way".

> rene@jackson:/dev > l dsp sound/dsp 
> ls: sound/dsp: Permission denied
> lr-xr-xr-x   1 root     root            9 Dec  7 00:14 dsp -> sound/dsp
> rene@jackson:/dev > cd sound/
> bash: cd: sound/: Permission denied
> rene@jackson:/dev > 
> 
> rene@jackson:/dev > l snd
> ls: snd/..: Permission denied
> ls: snd/.: Permission denied
> ls: snd/controlC0: Permission denied
> ls: snd/controlC1: Permission denied
> ls: snd/timer: Permission denied
> ls: snd/midiC0D0: Permission denied
> ls: snd/pcmC0D2p: Permission denied
> ls: snd/pcmC0D1c: Permission denied
> ls: snd/pcmC0D0p: Permission denied
> ls: snd/pcmC0D0c: Permission denied
> ls: snd/midiC1D0: Permission denied
> ls: snd/pcmC1D0p: Permission denied
> ls: snd/pcmC1D0c: Permission denied
> total 0
> 
> They all have 666 (or 777 for dirs)!

Are you saying this is good or bad?

> It is possible to this as root.

It's possible to do what? List the inodes? Open then? What?

> Also loading the modules gives me:
> Dec  7 00:31:58 jackson kernel: devfs: devfs_register(unknown): could not append to parent, err: -17

Two possibilities:

- the module is trying to register "unknown" twice. The old devfs core
  was forgiving about this (although it was always a driver bug to
  attempt to create a duplicate). The new core won't let you do that.
  Error 17 is EEXIST. Please fix the driver

- something in user-space created the "unknown" inode before the
  driver could create it. This is a configuration bug. It seems
  Mandrake has boot scripts which indiscriminately "restore" inodes in
  /dev. This is a bug, because they also restore inodes created by the
  drivers, whereas they should only be restoring admin-created inodes.
  Grab devfsd-v1.3.20 which has the RESTORE directive which does this
  properly, and blow away the part of the Mandrake boot scripts which
  are causing the problem

FYI: what happens now with duplicates is that the old entry remains,
and the new one is discarded. If you really are creating the same
entry, there should be no harm, just that annoying message.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
