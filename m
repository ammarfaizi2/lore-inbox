Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136104AbREGNqf>; Mon, 7 May 2001 09:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136106AbREGNqZ>; Mon, 7 May 2001 09:46:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40465 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136104AbREGNqS>; Mon, 7 May 2001 09:46:18 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: vt.c: unimap changes to (fg_?)console
Date: 7 May 2001 06:45:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9d68ug$g7n$1@cesium.transmeta.com>
In-Reply-To: <20010507123709.D8052@garloff.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010507123709.D8052@garloff.suse.de>
By author:    Kurt Garloff <garloff@suse.de>
In newsgroup: linux.dev.kernel
> 
> Hi Linus, Alan, Andries,
> 
> if you open /dev/tty4 and change the font via ioctl(KDFONTOP), it will be
> applied to the opened console, i.e. tty4. Then you set the corresponding
> unicodemap via PIO_UNIMAPCLR and PIO_UNIMAP ioctls. Those get applied to the
> current foreground console. Which is inconsistent.
> 
> Looking at vt.c: vt_ioctl(), the situation is a bit messy: Some ioctls don't
> explicitly specify a tty (probably not needed, as some settings are global),
> some apply to fg_console, some apply to the opened console which is
> ((struct vt_struct*)tty->driver_data)->vc_num.
> 

Okay, these should either be global or apply to the invoked (file
descriptor) tty.  Anything else is completely broken.  In fact, I'd
argue that using ioctl's for anything but global data (since it's
global, it has to be privileged) is in itself broken.  (Note: all the
font stuff used to be global state for kernel memory reasons.)

Why do you have the following in your patch?  It makes the permissions
on the console depend on whether or not it is in the foreground, which
seems like another stupid inconsistency:

> +		if (!perm && fg_console !=3D console)
> +			return -EPERM;
	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
