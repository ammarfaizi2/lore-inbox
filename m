Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCOTVp>; Fri, 15 Mar 2002 14:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSCOTVh>; Fri, 15 Mar 2002 14:21:37 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:2298 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S293169AbSCOTV2>; Fri, 15 Mar 2002 14:21:28 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 15 Mar 2002 11:57:22 -0700
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
Message-ID: <20020315185722.GA920@turbolinux.com>
Mail-Followup-To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020315135240.A5979@wotan.suse.de> <Pine.LNX.4.33.0203151736460.1477-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0203151736460.1477-100000@biker.pdb.fsc.net>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 15, 2002  18:41 +0100, Martin Wilck wrote:
> +#define __SLOW_DOWN_IO_PORT 0x80
> +#define __SLOW_DOWN_IO "\noutb %%al,$0x80"

You may want to change the above to:
#define __SLOW_DOWN_IO_ASM	"\noutb %%al,$__SLOW_DOWN_IO_PORT"

> +	outb(3, __SLOW_DOWN_IO_PORT);

You may also want to replace the above entirely with a macro, like:
#define __SLOW_DOWN_IO		outb(3, __SLOW_DOWN_IO_PORT)

so that on architectures that don't need/have this ISA nonsense can
just replace __SLOW_DOWN_IO with something else like udelay.

> --- ./arch/i386/boot/setup.S.orig	Fri Mar 15 17:23:15 2002
> +++ ./arch/i386/boot/setup.S	Fri Mar 15 18:33:12 2002
> @@ -65,6 +66,7 @@
>  				# ... and the former contents of CS
> 
>  DELTA_INITSEG = SETUPSEG - INITSEG	# 0x0020
> +DELAY_PORT = __SLOW_DOWN_IO_PORT	# port for IO delay (0x80)
> 
>  .code16
>  .globl begtext, begdata, begbss, endtext, enddata, endbss

May as well just stick with a single define here (i.e. remove DELAY_PORT).

> @@ -1001,7 +1003,7 @@
> 
>  # Delay is needed after doing I/O
>  delay:
> -	outb	%al,$0x80
> +	outb    %al,$DELAY_PORT
>  	ret

And use __SLOW_DOWN_IO_ASM here.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

