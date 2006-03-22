Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWCVWYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWCVWYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWCVWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:24:12 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:19895
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932176AbWCVWYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:24:10 -0500
From: Rob Landley <rob@landley.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] initramfs: CPIO unpacking fix
Date: Wed, 22 Mar 2006 17:23:28 -0500
User-Agent: KMail/1.8.3
Cc: Michael Neuling <mikey@neuling.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       klibc@zytor.com, Al Viro <viro@ftp.linux.org.uk>, hpa@zytor.com,
       miltonm@bga.com
References: <20060216183745.50cc2bf6.mikey@neuling.org> <20060322061220.8414067A70@ozlabs.org> <4420F93C.1050705@garzik.org>
In-Reply-To: <4420F93C.1050705@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221723.29279.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 2:14 am, Jeff Garzik wrote:
> Michael Neuling wrote:
> > Unlink files, symlinks, FIFOs, devices etc. (except directories) before
> > writing them when extracting CPIOs.  This stops weird behaviour like:
> >  1) writing through symlinks created in earlier CPIOs. eg foo->bar in
> >     the first CPIO.  Having foo as a non-link in a subsequent CPIO,
> >     results in bar being written and foo remaining as a symlink.
> >  2) if the first version of file foo is larger than foo in a
> >     subsequent CPIO, we end up with a mix of the two.  ie. neither
> >     the first or second version of /foo.
> >  3) special files like devices, fifo etc. can't be overwritten in
> >     subsequent CPIOS.
> >
> > With this, the kernel will more closely replicate
> >   for i in *.cpio; do cpio --extract --unconditional < $i ; done
> >
> > This is a change but it's regarded as fixing broken functionality.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>
> For the kernel, I would regard that as needless code...  Coding for a
> chain of CPIO archives overwriting each other seems like overengineering.

There's an obvious use case:

First initramfs.cpio.gz built into the kernel, second initramfs.cpio.gz 
supplied as an external file via the initrd mechanism.  Both get extracted 
into the same rootfs, and I believe external one will overwrite the internal 
one if files conflict.

And yes, there are people out there who want to deploy the same binary kernel 
image across a product line (or at least put each new one through 3 months of 
testing).  And others who want to be able to twiddle the rootfs contents 
without rebuilding the kernel from source each time.  (And of course anybody 
who needs to supply binary firmware to a statically linked device driver like 
ipw2200 is probably pretty happy about the ability to keep it in a separate 
file from the kernel, for license reasons.  Or should be, anyway.)

I'm actually fiddling with a script to let people do this for 
vmlinux->bzImage.  Objcopy with a new init.ramfs section and then go through 
the song and dance to make a bzImage.  Replacing the initramfs _in_ a 
bzimage?  Not fun.  Turning vmlinux into each of the other binary packaging 
types for other platforms?  Also not fun.  (I don't even have a complete list 
of what they all _are_ yet.  Working on it...)

> 	Jeff

Rob
-- 
Never bet against the cheap plastic solution.
