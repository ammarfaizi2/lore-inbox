Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSHMPxL>; Tue, 13 Aug 2002 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSHMPxL>; Tue, 13 Aug 2002 11:53:11 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:50311 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318191AbSHMPxJ>; Tue, 13 Aug 2002 11:53:09 -0400
Date: Tue, 13 Aug 2002 10:53:30 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020813155330.GG761@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D59110B.6D9A1223@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Greg Banks]
> Ok, here it is.  

Thanks again.  It will take some time to double-check what I termed
the "false positives", but now you've reduced the "interesting cases"
down to 30 symbols.

(BTW, the format is great - I can use 'M-x compile' and 'M-x
next-error' and Emacs pulls up files and lines for me.)

Here are the problem cases - things known to break with my proposed
'n'=='' - and my proposed solutions.  I'll see if I can roll a patch
later today:


CONFIG_SCSI should be defined earlier, like in the "Block Devices"
menu.  Then again, 'sg' is not a block device so this isn't strictly
correct.  Perhaps a "kernel subsystems" submenu under "general setup",
or even as a toplevel menu.

CONFIG_I2C and CONFIG_USB are also widely used outside their own
subtrees.  They should probably go in with the "kernel subsystems"
menu along with CONFIG_SCSI.

CONFIG_PROC_FS is needed by ISDN hysdn.  That's actually in my opinion
more of a "general kernel facility" than a filesystem.  Eh?

Then again it could be said that requiring CONFIG_PROC_FS is actually
a design bug in hysdn - does the driver *really* need CONFIG_PROC_FS?
Everything else in the kernel seems to cope without it.  Granted,
non-/proc kernels are not widely tested....  Kai?

CONFIG_ISDN_CAPI - interestingly, CONFIG_HYSDN_CAPI, which is under
the menu "Old ISDN4Linux (obsolete)" seems to require CAPI 2.0.  I
suppose the CAPI stuff should come first in drivers/isdn/Config.in.
Kai?

CONFIG_SOUND_ACI_MIXER - the miroSOUND radio driver wants something
from OSS sound.  Really I think sound/Config.in "Sound Card Support"
should be moved to a sub-menu of drivers/media/Config.in "Multimedia
Devices".

CONFIG_INPUT - arch/{alpha,mips,mips64}/config.in are broken.  There's
a comment in other arch/*/config.in files to the effect that
drivers/input/Config.in must come before drivers/usb/input/Config.in.
These 3 explicitly do the opposite.

CONFIG_SOUND_GAMEPORT - defined in drivers/input/gameport/, used only
in sound/oss/.  I'm not sure what's going on here - why a separate
define (there is also CONFIG_GAMEPORT), and why do some sound cards
require its presence?  Also I'm a bit suspicious of the logic in
drivers/input/gameport/ - it's either buggy, or way too clever.

This one is just confusing.  Not sure what to recommend.  I'll
probably have to stare at the Makefiles and the C for awhile to see
what's actually going on.
