Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318928AbSHMDgM>; Mon, 12 Aug 2002 23:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSHMDgM>; Mon, 12 Aug 2002 23:36:12 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:38277 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318928AbSHMDgL>; Mon, 12 Aug 2002 23:36:11 -0400
Date: Mon, 12 Aug 2002 22:39:51 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020813033951.GF761@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D587483.1C459694@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Greg Banks]
> Ah.  If you're willing to knowingly feed Linus with patches that
> break current config behaviour, then OK we have a way to proceed.

Things knowingly break in 2.5 all the time.  I for one have no problem
with this.  Especially since the breakage is so easy to pinpoint,
thanks to your script.

> I don't think there's any value to gratuitously breaking 2.4's
> config.  That's the point of a "stable" series right?

Correct.  I for one have no intention of changing 2.4 semantics,
except to expand them to allow '!' syntax, if I can finish that up.

> Ah, glad you asked, see attached output from the latest version of gcml2
> (not yet released).

Thank you thank you thank you!  Exactly what I wanted!

Now, while some (perhaps a lot) of these instances will break with the
proposed new semantics, many will not.  Starting from the top:

> =====alpha
> warning:drivers/pcmcia/Config.in:22:forward declared symbol "CONFIG_ARCH_SA1100" used in dependency list for "CONFIG_PCMCIA_SA1100"

In context:

   if [ "$CONFIG_ARM" = "y" ]; then
      dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
   fi

With the new semantics, there would be no need for the 'if' statement.
CONFIG_ARCH_SA1100 is a sufficient guard, since non-ARM machines will
never define it.

The next 7 lines are similar, with CONFIG_PPC, CONFIG_MIPS and
CONFIG_ARM as the guards.

> warning:drivers/block/Config.in:38:forward declared symbol "CONFIG_SCSI" used in dependency list for "CONFIG_CISS_SCSI_TAPE"

This one is legit.  It's a weird case where a single driver can be
built with or without using the SCSI subsystem - in effect, two
drivers sharing a single piece of hardware and presenting two views of
it.

My preferred "fix" is to move the 'tristate CONFIG_SCSI' to early in
the Block Devices menu.  ATA should be under Block Devices too, come
to think of it, and perhaps a generic guard for non-IDE-non-SCSI RAID
cards.  The actual menus could come later under toplevel, or be nested
within "Block Devices".

> warning:drivers/ide/Config.in:21:forward declared symbol "CONFIG_SCSI" used in dependency list for "CONFIG_BLK_DEV_IDESCSI"

See above.

> warning:drivers/ide/Config.in:84:forward declared symbol "CONFIG_ARCH_ACORN" used in dependency list for "CONFIG_BLK_DEV_IDE_ICSIDE"
> warning:drivers/ide/Config.in:88:forward declared symbol "CONFIG_ARCH_ACORN" used in dependency list for "CONFIG_BLK_DEV_IDE_RAPIDE"
> warning:drivers/ide/Config.in:91:forward declared symbol "CONFIG_AMIGA" used in dependency list for "CONFIG_BLK_DEV_GAYLE"
> warning:drivers/ide/Config.in:95:forward declared symbol "CONFIG_ZORRO" used in dependency list for "CONFIG_BLK_DEV_BUDDHA"
> warning:drivers/ide/Config.in:98:forward declared symbol "CONFIG_ATARI" used in dependency list for "CONFIG_BLK_DEV_FALCON_IDE"
> warning:drivers/ide/Config.in:101:forward declared symbol "CONFIG_MAC" used in dependency list for "CONFIG_BLK_DEV_MAC_IDE"
> warning:drivers/ide/Config.in:104:forward declared symbol "CONFIG_Q40" used in dependency list for "CONFIG_BLK_DEV_Q40IDE"
> warning:drivers/ide/Config.in:107:forward declared symbol "CONFIG_8xx" used in dependency list for "CONFIG_BLK_DEV_MPC8xx_IDE"
> warning:drivers/net/Config.in:28:forward declared symbol "CONFIG_ARCH_EBSA110" used in dependency list for "CONFIG_ARM_AM79C961A"
> warning:drivers/net/Config.in:34:forward declared symbol "CONFIG_ALL_PPC" used in dependency list for "CONFIG_MACE"
> warning:drivers/net/Config.in:38:forward declared symbol "CONFIG_ALL_PPC" used in dependency list for "CONFIG_BMAC"
> warning:drivers/net/Config.in:48:forward declared symbol "CONFIG_GSC_LASI" used in dependency list for "CONFIG_LASI_82596"
> warning:drivers/net/Config.in:239:forward declared symbol "CONFIG_PPC_ISERIES" used in dependency list for "CONFIG_VETH"

All obviously tied to a specific arch.  Most but not all are guarded
by ARCH_* symbols, but that doesn't matter - with the new semantics
they work with or without extra guards.


All in all, by asserting that 'n' == '', you can drop all the
'define_bool FOO n' from the arch/*/config.in files (like CONFIG_SBUS
on i386 or CONFIG_PCI on s390), and you can drop a *lot* of guard 'if'
statements.  A few things would actually break, like not defining
CONFIG_SCSI soon enough.

I think it's worth it.  It will take some time to go through your 260
unique warnings (984 total), of course.

BTW - speaking of the length of your warnings list - what would be
*really* nice would be a way to determine that a particular "forward
declared symbol" is actually a "never-in-this-arch declared symbol".
That would eliminate most of the false positives.  If for example we
can determine that we will never define CONFIG_ZORRO on this arch, we
can safely assume that anything which depends on CONFIG_ZORRO *should*
be suppressed.  (Modulo outright bugs where someone wrote
$CONFIG_ZORRO for something that does not in fact require zorro.)

Peter
