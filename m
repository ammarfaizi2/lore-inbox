Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286488AbSABBHu>; Tue, 1 Jan 2002 20:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286468AbSABBHl>; Tue, 1 Jan 2002 20:07:41 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:7692 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S286491AbSABBH3>;
	Tue, 1 Jan 2002 20:07:29 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: hpa@zytor.com
Cc: robert@schwebel.de, linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de
In-Reply-To: <3C32487C.4040006@zytor.com> (hpa@zytor.com)
Subject: Re: [RFC] Embedded X86 systems Was: [PATCH][RFC] AMD Elan patch
Reply-To: wingel@t1.ctrl-c.liu.se
In-Reply-To: <Pine.LNX.4.33.0201020006240.3056-100000@callisto.local> <3C32487C.4040006@zytor.com>
Message-Id: <20020102010727.E0BEC36F9F@hog.ctrl-c.liu.se>
Date: Wed,  2 Jan 2002 02:07:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Robert Schwebel wrote:
> > Hmm, there is no special section for chipset issues, the only ones I could
> > find are "Toshiba Laptop support" and "Dell Laptop Support" (also in
> > "Processor type and features"). Other chipset bugfix options are in the
> > IDE driver section, but this doesn't apply here. So the options would be
> > 
> > - add something like "Elan Support" in "Processor type and features"
> > - add a new section for general chipset fixes
> 
> "Processor type and features" is good enough for now, I think.  It's not 
> a very large section.

I belive that we're going to see a lot more x86-based embedded systems
in the future, some that won't even have a normal PC BIOS.  So I think
that we ought to do something like the m68k and arm architectures
where it's possible to have different setup code for different CPUs,
chipsets and specific board designs.  

I've been working with three different NatSemi Geode based designs
lately (two really PC compatible, one requiring special boot code) and
I think it would be good to come up with some guidelines for where to
put these config options and how to name them.

The different x86 embedded CPUs I've been working with are the AMD
Elan SC410, Cyrix MediaGX/National Semiconducgtor Geode with the
Cx5530 companion chip, National SC2200 (basically a Geode + Cx5530 on
a chip) and ZF Embedded.  All of these have some quirks or features
that could use some configuration options.

Some CPUs/Chipsets/Design choices will stop the kernel from working
properly on a normal PC, e.g. an Elan enabled kernel will have the
wrong clock, while some other options such as the National SC2200 only
have some extra chipset features that can be safely detected and
ignored when not present.

Right now I'm working on a Natsemi SC2200 design and this is how I
feel the support for this design should be split up:

Processor family:

Maybe add a CONFIG_GEODE option since all Geode CPUs have a cache line
size of 16 bytes, so CONFIG_X86_L1_CACHE_SHIFT should be 4.  How
important is the cache line size for the performance of the kernel,
does it really make a difference, if it doesn't the generic M586
option is enough.

Chipset:

There is the basic Cx5530 chipset, which could have support in the
Linux kernel (IDE, graphics and sound).

"IA on a chip" SCx200 which is an integrated Geode + Cx5530, so most
of the the 5530 options would apply here.  Additionally there is a
built in watchdog timer in the CPU, some GPIO lines, and a high
precision timer that could be used instead of the TSC to get a good
time of day reading.

There are three different SCx200 variants, some features are common
for all chips, some are specific for a variant, such as the video
input port and graphics overlay/genlock.

Board design:

There are a lot of different designs based on the Geode family CPUs
and chipsets, and they are all different.  Some are mostly PC
compatible and some are wholly customised, the IRQ routing can be
unique for each board and GPIOs can have multiplexed functions, so
that if one isn't careful, it's possible to configure the TFT screen
outputs as an parallell port instead and possibly fry the screen.

Firmware, BIOS or boot loader:

Right now the design I'm working on uses an Insyde BIOS which is a
rather normal PC BIOS, but I'm looking at the possibility of doing my
own bootloader in the future, to lose the licence fees and to
implement some features such as a serial or network console.  This
means that right now the board looks and boots like a PC but in the
future there might be no BIOS functions available at all.

So, does anyone have any ideas on how to organize the configuration
options?  How should they be named?  The choices I've made so far are:

I've added a config option (near CONFIG_VISWS) for the chipset:

    bool 'National Geode SCx200 support' CONFIG_ARCH_SCx200

and right after it have an option to do board-specific initialization:

    mainmenu_option next_comment
    comment 'NatSemi SCx200 implementations'
    bool '  My little design' CONFIG_SCx200_MY_LITTLE_DESIGN

For the generic SCx200 features, I've added drivers in the respective
directories such as a watchdog driver in drivers/char:

    dep_tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WATCHDOG \
					     $CONFIG_ARCH_SCx200

Does this organization look good?  Any suggestions on what to call a
config option that changes the setup code to work with a custom
bootloader or board:

    bool '  Normal PC BIOS support' CONFIG_SETUP_PC_BIOS
    bool '  Ericsson eBox boot protocol' CONFIG_SETUP_EB100
    bool '  Magic GRUB variant as BIOS' CONFIG_SETUP_MAGIC_GRUB_VARIANT

  /Christer (being a wee bit to verbose again)

-- 
"Just how much can I get away with and still go to heaven?"
