Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSFPNAl>; Sun, 16 Jun 2002 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSFPNAk>; Sun, 16 Jun 2002 09:00:40 -0400
Received: from fungus.teststation.com ([212.32.186.211]:47377 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316204AbSFPNAj>; Sun, 16 Jun 2002 09:00:39 -0400
Date: Sun, 16 Jun 2002 14:59:06 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Erik McKee <camhanaich99@yahoo.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        <kernel-newbies@vger.kernel.org>, <davej@suse.de>,
        Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [ERROR][PATCH] smbfs compilation in 2.5.21
In-Reply-To: <20020616042831.19489.qmail@web14204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0206161257390.5774-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Erik McKee wrote:

> diff -Nru a/fs/smbfs/smb_debug.h b/fs/smbfs/smb_debug.h
> --- a/fs/smbfs/smb_debug.h	Sat Jun 15 23:12:04 2002
> +++ b/fs/smbfs/smb_debug.h	Sat Jun 15 23:12:04 2002
> @@ -12,8 +12,10 @@
>   */
>  #ifdef SMBFS_PARANOIA
>  # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__, ## a)
> +# define PARANOIA2(f) printk(KERN_NOTICE "%s: "f, __FUNCTION__)

Are you looking at BK, the 2.5.21 tree I'm looking at still has:
#define PARANOIA(x...) printk(KERN_NOTICE __FUNCTION__ ": " x)

I assume you are using gcc 3.x? (which one?)
I don't get any warnings/errors on 2.96.


I think having two macros for exactly the same thing is ugly. A better
solution might be to borrow some code from arch/ia64/kernel/unaligned.c

#define PARANOIA(f...) \
	do { printk(KERN_NOTICE "%s: ", __FUNCTION__); printk(f); } while(0)

(untested, and I think this will print an extra "<4>" ?)
Unless someone has a better idea. In any case, the other printk macros in
smb_debug.h needs treatment too and not just the PARANOIA macro.


If you are cleaning things up I think that the following also sometimes
use debug macros with a single string, but with a 'macro(a, b...)' syntax:

drivers/net/pci-skeleton.c
drivers/char/i810_rng.c
sound/oss/via82cxxx_audio.c
	DPRINTK

drivers/hotplug/pci_hotplug_{core,util}.c
	dbg/err/info/warn

drivers/char/machzwd.c
	dprnintk

drivers/ieee1394/sbp2.c
	SBP2_ORB_DEBUG

net/ipv4/netfilter/ipt_ULOG.c
net/ipv4/netfilter/ip_conntrack_irc.c
	DEBUGP

sound/oss/vwsnd.c
	DBGP

fs/ntfs/debug.h
	ntfs_warning/ntfs_error


Many of them are not enabled by default, and maybe they have already been
taken care of.

And maybe run suggested changes by the respective maintainers first.
Thanks.

/Urban

