Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318935AbSHME0k>; Tue, 13 Aug 2002 00:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318936AbSHME0k>; Tue, 13 Aug 2002 00:26:40 -0400
Received: from rj.sgi.com ([192.82.208.96]:393 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S318935AbSHME0j>;
	Tue, 13 Aug 2002 00:26:39 -0400
Message-ID: <3D588B97.A5514DAC@alphalink.com.au>
Date: Tue, 13 Aug 2002 14:31:19 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Greg Banks]
> > Ah, glad you asked, see attached output from the latest version of gcml2
> > (not yet released).
> 
> Thank you thank you thank you!  Exactly what I wanted!

Pleased to be of service ;-)

> Now, while some (perhaps a lot) of these instances will break with the
> proposed new semantics, many will not.  Starting from the top:
> 
> > =====alpha
> > warning:drivers/pcmcia/Config.in:22:forward declared symbol "CONFIG_ARCH_SA1100" used in dependency list for "CONFIG_PCMCIA_SA1100"
> 
> In context:
> 
>    if [ "$CONFIG_ARM" = "y" ]; then
>       dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
>    fi
> 
> With the new semantics, there would be no need for the 'if' statement.
> CONFIG_ARCH_SA1100 is a sufficient guard, since non-ARM machines will
> never define it.

Agreed, the current form is a direct result of the current dep_tristate
semantics and would not be necessary with your proposed semantics.

> > warning:drivers/block/Config.in:38:forward declared symbol "CONFIG_SCSI" used in dependency list for "CONFIG_CISS_SCSI_TAPE"
> 
> This one is legit.  It's a weird case where a single driver can be
> built with or without using the SCSI subsystem - in effect, two
> drivers sharing a single piece of hardware and presenting two views of
> it.

Bizarre.

> My preferred "fix" is to move the 'tristate CONFIG_SCSI' to early in
> the Block Devices menu.  ATA should be under Block Devices too, come
> to think of it, and perhaps a generic guard for non-IDE-non-SCSI RAID
> cards.  The actual menus could come later under toplevel, or be nested
> within "Block Devices".

Along these lines, CML2 had a menu 'buses' very early in the root of
the tree, containing queries for ISA, PCI, MCA, SERIAL, PARPORT,
HOTPLUG, IDE, SCSI, USB, IEEE1394 and FC4.  I won't post the code
here because I can't fully understand it anymore :-(

> All in all, by asserting that 'n' == '', you can drop all the
> 'define_bool FOO n' from the arch/*/config.in files (like CONFIG_SBUS
> on i386 or CONFIG_PCI on s390), and you can drop a *lot* of guard 'if'
> statements.  A few things would actually break, like not defining
> CONFIG_SCSI soon enough.

You will also probably want to deal with the cases where possibly null-valued
symbols are compared against "n" like this

if [ "$CONFIG_NOT_DECLARED" != "n" ]; then....

73     forward-compared-to-n
    13     drivers/parport/Config.in:40:CONFIG_ZORRO
    13     sound/oss/Config.in:209:CONFIG_INPUT_GAMEPORT
    11     drivers/parport/Config.in:14:CONFIG_SERIAL
    10     drivers/media/video/Config.in:33:CONFIG_USB
    6      drivers/video/Config.in:134:CONFIG_I2C
    3      drivers/net/Config.in:324:CONFIG_CARDBUS
    3      drivers/scsi/Config.in:264:CONFIG_PCMCIA
    2      drivers/char/Config.in:193:CONFIG_PCMCIA
    2      drivers/net/Config.in:327:CONFIG_PCMCIA
    2      drivers/net/wireless/Config.in:27:CONFIG_PCMCIA
    2      drivers/net/wireless/Config.in:41:CONFIG_PCMCIA
    2      drivers/scsi/Config.in:116:CONFIG_PARPORT
    1      arch/alpha/config.in:262:CONFIG_PROC_FS
    1      arch/sh/config.in:298:CONFIG_MAPLE
    1      drivers/ide/Config.in:26:CONFIG_PCI
    1      drivers/parport/Config.in:27:CONFIG_PCMCIA

> I think it's worth it.  It will take some time to go through your 260
> unique warnings (984 total), of course.

;-)

> BTW - speaking of the length of your warnings list - what would be
> *really* nice would be a way to determine that a particular "forward
> declared symbol" is actually a "never-in-this-arch declared symbol".
> That would eliminate most of the false positives.  If for example we
> can determine that we will never define CONFIG_ZORRO on this arch, we
> can safely assume that anything which depends on CONFIG_ZORRO *should*
> be suppressed. 

Shouldn't be too hard, I'm already doing something like this to distinguish
between forward declared and undeclared symbols for the forward-reference
and undeclared-symbol warnings.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
