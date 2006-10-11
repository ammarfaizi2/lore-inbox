Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWJKThP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWJKThP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWJKThP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:37:15 -0400
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:38961 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1161063AbWJKThN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:37:13 -0400
Date: Wed, 11 Oct 2006 21:43:01 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH] Remove lilo-loads-only-five-sectors-of-zImage-fixup from setup.S
Message-ID: <20061011194301.GA2084@mailshack.com>
References: <20061011163356.GA2022@mailshack.com> <452D3A11.5020100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D3A11.5020100@zytor.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Wed, 11 Oct 2006 21:36:34 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter (version: 1.1.3-1; AVE: 7.2.0.25; VDF: 6.36.0.109; host: AntiVir1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:38:09AM -0700, H. Peter Anvin wrote:
> Alexander van Heukelum wrote:
> >Hi!
> >
> >The real-mode kernel (on i386 and x86_64) checks if the bootloader
> >loaded it correctly. Apparantly, very old versions of LILO disregarded
> >the setupsects field in the bootsector and always just loaded the first
> >five sectors. If the kernel is compiled as a zImage, the real-mode
> >kernel is able to rectify the situation. At least it was, until the code
> >to do so was moved to the eighth sector in order to make space for more
> >E820 entries (commit: f9ba70535dc12d9eb57d466a2ecd749e16eca866). This
> >occured on 1 May 2005 and as far as I know, noone has complained yet.
> >This patch removes the checks for the signature and the fixup code
> >completely.
> >
> >Comments? Which bootloaders are still in use? Kill zImage?
> >
> 
> Andrew asked me to comment on this...
> 
> This removes support for boot loaders that did not understand boot 
> loader protocol version 2.00 or later.  This probably includes very 
> early versions of LILO as well as the long-since obsolete Bootlin and 
> Shoelace.  Those loaders were unable to load bzImages as well.
> 
> I have been urging that we kill zImage for a long time.  It is virtually 
> impossible to build a kernel today that will fit inside the zImage 512K 
> compressed limitation.
> 
> It would be useful for setup.S to halt with a message if such an early 
> bootloader is detected, however.  This would have to be parked in the 
> first 2K of the setup area, and can simply be detected by looking for 
> zero in type_of_loader.

Hi!

The patch should not alter behaviour for any bootloader that takes
setupsects into account. It just removes 'support' for bootloaders that
have the size of the setup code hardcoded to 4 sectors.

The current version of setup.S already checks if the bootloader
understands boot protocol 2.00+ in the case of a big kernel, but that
code is also after the 2k-mark. The zero-page still has some unused
space between offsets 0x230 and 0x28f. Shall I put/move some code there
to check unconditionally if the type_of_loader has been set?

I'll do that if no objections are put forward.

Thanks,
    Alexander

> 
> 	-hpa
> 
