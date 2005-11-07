Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVKGKfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKGKfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKGKfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:35:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:738 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750794AbVKGKfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:35:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 15/25] autofs: move ioctl32 to autofs{,4}/root.c
Date: Mon, 7 Nov 2005 11:36:18 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       hpa@zytor.com, autofs@linux.kernel.org
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162716.551500000@b551138y.boeblingen.de.ibm.com> <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net>
In-Reply-To: <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511071136.19087.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 06 November 2005 07:22, Ian Kent wrote:
> On Sat, 5 Nov 2005, Arnd Bergmann wrote:
>
> I'm not sure if I like conditional compilation in the code proper but I'll 
> leave it to you to make the final decision since your running with the 
> change. Is there a reason the definitions can't simply be left in place?

I think the compat_ptr() macro is not defined on architectures that don't
have 32 bit compat code, but we could change that.
 
> Its been a while since I trawled through the compat ioctl code (please 
> point me to the right place) but with this change I think that the 
> AUTOFS_IOC_SETTIMEOUT32 is redundant. Consider a conditional define for 
> AUTOFS_IOC_SETTIMEOUT in include/linux/auto_fs.h instead. Both autofs and 
> autofs4 use that definition.

The point here is that the two are different on 64 bit platforms, since
sizeof (int) != sizeof (long). You also can't do

switch (cmd) {
case AUTOFS_IOC_SETTIMEOUT32:
case AUTOFS_IOC_SETTIMEOUT:
	return do_stuff();
}

because then gcc would complain about duplicate case targets on 32 bit
targets.
 
> The lock_kernel()/unlock_kernel() in the autofs4 patch is ineffective as 
> the BKL is not used for syncronisation anywhere else in autofs4. If 
> removing it causes problems I need to know about'em so I can fix'em 
> (hopefully).

I used the BKL here in order to maintain the current semantics, because
ioctl is always called with BKL held, and compat_ioctl is called without
it.

If you are sure you don't need the BKL, then you should also replace
".ioctl = ..." with ".unlocked_ioctl = ...".

	Arnd <><
