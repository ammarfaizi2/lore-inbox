Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262403AbSJJAsb>; Wed, 9 Oct 2002 20:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSJJAsb>; Wed, 9 Oct 2002 20:48:31 -0400
Received: from pc132.utati.net ([216.143.22.132]:25762 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262403AbSJJAsa>; Wed, 9 Oct 2002 20:48:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Adrian Bunk <bunk@fs.tum.de>, marcelo@connectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH]: Move Fusion MPT config menu into scsi driver support (was Re: The end of embedded Linux?)
Date: Wed, 9 Oct 2002 15:54:00 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Matt Porter <porter@cox.net>, <linux-kernel@vger.kernel.org>
References: <Pine.NEB.4.44.0210091335450.8340-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0210091335450.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021010005415.77E60635@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 07:38 am, Adrian Bunk wrote:
> On Tue, 8 Oct 2002, Rob Landley wrote:
> >...
> > Go into make menuconfig in 2.4.19.  Switch off "scsi support".  Back to
> > the main menu, try to descend into "fusion mpt device support".  The menu
> > still shows up (at the top level, I might add), but you can't go into it.
> >
> > That's been broken for over a year now.  It's in the top level of
> > menuconfig. I first reported it back around 2.4.6 or so.  It just doesn't
> > get in anybody's way, and that area of code is a mess, and not fixing it
> > isn't embarassing anybody specific.
> >...
>
> I assume the patch below fixes this for i386 (similar patches are needed
> for at most four other architectures)?
>
> > Rob
>
> cu
> Adrian
>
> --- l/arch/i386/config.in.old	2002-10-09 13:28:59.000000000 +0200
> +++ l/arch/i386/config.in	2002-10-09 13:31:44.000000000 +0200
> @@ -357,7 +357,11 @@
>  fi
>  endmenu
>
> -source drivers/message/fusion/Config.in
> +if [ "$CONFIG_SCSI" != "n" ]; then
> +   if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
> +      source drivers/message/fusion/Config.in
> +   fi
> +fi
>
>  source drivers/ieee1394/Config.in

Ah, is that how you do it?  (Where were you eight months ago? :)

The bigger problem is that the sucker belongs in the SCSI menu, not in the top
level menu, so something more like...  (Patch against 2.4.19)

--- linuxold/arch/i386/config.in        Wed Oct  9 15:35:43 2002
+++ linux-2.4.19/arch/i386/config.in    Wed Oct  9 15:41:03 2002
@@ -332,8 +332,6 @@
 fi
 endmenu

-source drivers/message/fusion/Config.in
-
 source drivers/ieee1394/Config.in

 source drivers/message/i2o/Config.in
--- linuxold/drivers/scsi/Config.in     Wed Oct  9 15:39:42 2002
+++ linux-2.4.19/drivers/scsi/Config.in Wed Oct  9 15:41:52 2002
@@ -117,6 +117,7 @@
       bool  '  ppa/imm option - Assume slow parport control register' CONFIG_SCSI_IZIP_SLOW_CTR
    fi
 fi
+source drivers/message/fusion/Config.in
 dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
 if [ "$CONFIG_MCA" = "y" ]; then
    dep_tristate 'NCR Dual 700 MCA SCSI support' CONFIG_SCSI_NCR_D700 $CONFIG_SCSI

The above "Works for me."  Not that I have a fusion MPT controller, but the config
menu looks right now. :)  And help says it's a specific brand of fiber channel
controller, so life is good...

Rob
