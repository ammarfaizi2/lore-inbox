Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUCGKeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUCGKeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:34:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53925 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261798AbUCGKel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:34:41 -0500
Date: Sun, 7 Mar 2004 11:34:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Voluspa <lista4@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040307103438.GC23525@suse.de>
References: <200403051858.i25IwLa12467@d1o404.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403051858.i25IwLa12467@d1o404.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05 2004, Voluspa wrote:
> On 2004-03-03 12:25:06 Jens Axboe wrote:
> > On Wed, Mar 03 2004, Alistair John Strachan wrote:
> >> On Wednesday 03 March 2004 11:37, you wrote:
> [...]
> >> Is this a general optimisation, i.e. will the rip methods used by
> >> cdda2wav and cdparanoia, etc. be optimised, or do you need some
> >> specific userspace tools to utilise it?
> 
> > The patch only affects CDROMREADAUDIO ioctl. cdda2wav (with recent
> > libscg) will use SG_IO, which works equally well already. cdparanoia
> > uses CDROMREADAUDIO as well iirc, if it can use /dev/sg* sg v2
> > interface. I'm not completely sure, if you send me an strace of the
> > process in question I can tell you for sure :)
> 
> Here the patch boosted cdparanoia, but it is far from cdda2wav results
> (don't understand the tech talk so just reporting on outcome)
> 
> Celeron 800MHz @ 1075MHz, 360Meg mem.  Hewlett-Packard CD-Writer Plus 9100
> cdparanoia III release 9.8 (March 23, 2001)
> cdda2wav Version 2.01a18
> 
> _2.6.4-rc2_ (unpatched)
> 
> # time cdda2wav -D /dev/cdrom
> [...]
> samplefile size will be 52190924 bytes.
> recording 295.8666 seconds stereo with 16 bits @ 44100.0 Hz ->'audio'...
> overlap:min/max/cur, jitter, percent_done:
>  0/ 0/ 1/      0  99%EnableCdda_cooked (CDIOCSETCDDA) is not available...
>  0/ 0/ 1/      0 100%  track  1 successfully recorded
> 
> real    0m37.923s
> user    0m0.144s
> sys     0m0.796s
> 
> --- (reboot)
> 
> # time cdparanoia 1
> [...]
> real    2m43.071s
> user    0m9.039s
> sys     0m1.798s
> 
> +++
> 
> _2.6.4-rc2-cddaDMA_ (patched)
> 
> # time cdda2wav -D /dev/cdrom
> [same results as unpatched]
> 
> --- (reboot)
> 
> # time cdparanoia 1
> [...]
> real    1m54.289s
> user    0m6.538s
> sys     0m1.381s
> 
> # md5sum *.wav
> 510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-audio.wav
> 510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-cdda.wav
> 510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-cddaDMA-audio.wav
> 510e2fb29d9f67c3f80b380bd9b66566  2.6.4-rc2-cddaDMA-cdda.wav

That all looks expected, I think. cdda2wav uses SG_IO so it utilizes
zero copy dma with an unpatched kernel already, my CDROMREADAUDIO dma
patch makes zero difference for that io path (it's already fully
optimized). WRT the difference in run time between cdparanoia w/patched
kernel and cdda2wav, it probably has to do with the various jitter
corrections and scratch resistance stuff that cdparanoia does. If you
disable some of those options, its runtime will probably get a lot
closer to that of cdda2wav.

-- 
Jens Axboe

