Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319228AbSHNBIp>; Tue, 13 Aug 2002 21:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319230AbSHNBIo>; Tue, 13 Aug 2002 21:08:44 -0400
Received: from rj.sgi.com ([192.82.208.96]:33444 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319228AbSHNBIn>;
	Tue, 13 Aug 2002 21:08:43 -0400
Message-ID: <3D59AEB7.7B80F33@alphalink.com.au>
Date: Wed, 14 Aug 2002 11:13:27 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> (BTW, the format is great - I can use 'M-x compile' and 'M-x
> next-error' and Emacs pulls up files and lines for me.)

This is not a coincidence.

> CONFIG_SCSI should be defined earlier, like in the "Block Devices"
> menu.  Then again, 'sg' is not a block device so this isn't strictly
> correct.  Perhaps a "kernel subsystems" submenu under "general setup",
> or even as a toplevel menu.

Sounds like a good idea.  You could put CONFIG_SERIAL and CONFIG_PCMCIA
in there too.

> CONFIG_INPUT - arch/{alpha,mips,mips64}/config.in are broken.  There's
> a comment in other arch/*/config.in files to the effect that
> drivers/input/Config.in must come before drivers/usb/input/Config.in.
> These 3 explicitly do the opposite.

There are many broken things about the arch toplevel config.ins, mostly
due to them starting life as copy-n-paste jobs from arch/i386/config.in
and then slowly diverging.  A brief sampling from my bugs list...

*   CONFIG_KERNEL_ELF
    	Defined in arch/ppc/config.in as "define_bool CONFIG_KERNEL_ELF y".
	Specified in a large number of ppc defconfigs.
	Not used anywhere in the source.
	Appears to be an obsolete artifact.
	
    CONFIG_ELF_KERNEL
    	Defined in arch/mips/config.in as "define_bool CONFIG_ELF_KERNEL y".
	Specified in a large number of mips defconfigs.
	Not used anywhere in the source.
	Appears to be an obsolete artifact.

*   arch/ia64/config.in has this:

	if [ "$CONFIG_DEVFS_FS" = "y" ]; then
	  bool '    Enable DEVFS Debug Code' CONFIG_DEVFS_DEBUG n
	fi

    but why!?!? Not only does this have a bogus third argument as
    if it were dep_bool, but it defines a symbol already defined
    over in fs/Config.in, which is *included* from this config.in.

*   Most architectures have two global menus "General setup", one from
    their own arch/foo/config.in, one from init/Config.in.

*   One of these two correctly describes the device(s) it supports:

    arch/m68k/config.in:      dep_tristate 'A2091 WD33C93A support' CONFIG_A2091_SCSI $CONFIG_SCSI
    drivers/scsi/Config.in:   dep_tristate 'A2091/A590 WD33C93A support' CONFIG_A2091_SCSI $CONFIG_SCSI

*   What's the story with CONFIG_ALPHA_EV56?  It's defined as a symbol
    three times in arch/alpha/config.in with different banners:
    
            bool 'EV56 CPU (speed >= 333MHz)?' CONFIG_ALPHA_EV56
    bool 'EV56 CPU (speed >= 366MHz)?' CONFIG_ALPHA_EV56
    bool 'EV56 CPU (speed >= 400MHz)?' CONFIG_ALPHA_EV56

*   WTF?!?  arch/cris/drivers/bluetooth/Makefile has an install: target
    which actually hacks Config.in and Makefile in other directories!?!?!
    
*   There's a fair bit of confusion between the architectures about
    CONFIG_BINFMT_ELF{,32}...
    
    ARCH    C_B_ELF 	C_B_ELF32
    ----    ------- 	---------
    alpha   	1
    arm     	1
    cris    	1
    i386    	1
    ia64    	1
    m68k    	1
    mips64  	2   	    4
    mips    	3
    parisc  	1
    ppc64   	2   	    5
    ppc     	3
    s390    	1
    s390x   	1   	    6
    sh	    	1
    sparc64 	2   	    5
    sparc   	1
    x86_64  	1

    
    1='Kernel support for ELF binaries'
    2='Kernel support for 64-bit ELF binaries'
    3=define_bool
    4=define_bool,unset
    5='Kernel support for 32-bit ELF binaries'
    6='Kernel support for 31 bit ELF binaries'

    Note that the interpretation of CONFIG_BINFMT_ELF appears to be
    "support for largest-ELF" but some 64 bit platforms present this
    to the user as explicitly "64-bit" while other 64 bit platforms
    don't seem to care.  The 32-bit platforms just pretend there's
    no such thing as 64-bits.


> CONFIG_SOUND_GAMEPORT - defined in drivers/input/gameport/, used only
> in sound/oss/.  I'm not sure what's going on here

I couldn't figure out CONFIG_SOUND_GAMEPORT or CONFIG_INPUT_GAMEPORT either.


Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
