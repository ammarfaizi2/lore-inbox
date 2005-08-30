Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbVH3Rg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVH3Rg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVH3Rg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:36:58 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:6964 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751449AbVH3Rg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:36:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lyHoGc3trOkhLudEfUsGDB+YpIN3JiMXJ4V/qAYea4phPHMaAmDkkdzNtYNoDFvpxHVQ/YJ7NK4MJJse6dMpa0I8RHSUbMtXUWOw6M20HBUm3KYl9a18hiZGE4woJuo/FpZAKfoosturnXkYbdRozORDYOYyFWcrT+R7DOAPyyc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Date: Tue, 30 Aug 2005 19:37:59 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050830170502.GA10694@localhost.localdomain> <9a874849050830101743c421db@mail.gmail.com> <20050830172115.GA11784@localhost.localdomain>
In-Reply-To: <20050830172115.GA11784@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301938.00044.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 August 2005 19:21, Stephane Wirtel wrote:
> Le Tuesday 30 August 2005 a 19:08, Jesper Juhl ecrivait: 
> > On 8/30/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> > > Hi all,
> > > 
> > > Here is the first patch for kernel 2.6.13 from Linus tree.
> > > 
> > 
> > Take it easy. Don't kill __check_region() unless you first convert all
> > users of it.
> > And by removing __check_region() you've just broken check_region() -
> > There are still some drivers left that use check_region() and there's
> > no reason to break them.
> > 
> > The right approach is to identify all users of
> > check_region()/__check_region(), then submit patches to convert them
> > to use request_region instead. *Then*, when there are no more
> > in-kernel users left, submit patches to remove the deprecated
> > functions.
> 
> I know, I did not check with check_region, I will check all users of
> check_region and I hope to send a new patch in few days.
> 

Here's a quick list of suspects for you :

$ find ./ -name *.[ch] | xargs -i grep -H check_region {} | awk -F: {'print $1'} | sort | uniq
./arch/ppc/platforms/hdpu.c
./arch/sparc/kernel/pcic.c
./drivers/block/floppy.c
./drivers/cdrom/isp16.c
./drivers/cdrom/sbpcd.c
./drivers/char/amiserial.c
./drivers/char/riscom8.c
./drivers/char/specialix.c
./drivers/char/watchdog/pcwd.c
./drivers/ide/pci/trm290.c
./drivers/isdn/sc/init.c
./drivers/md/dm-raid1.c
./drivers/media/radio/radio-aimslab.c
./drivers/media/radio/radio-aztech.c
./drivers/media/radio/radio-cadet.c
./drivers/media/radio/radio-gemtek.c
./drivers/media/radio/radio-rtrack2.c
./drivers/media/radio/radio-sf16fmi.c
./drivers/media/radio/radio-sf16fmr2.c
./drivers/media/radio/radio-terratec.c
./drivers/media/radio/radio-typhoon.c
./drivers/media/radio/radio-zoltrix.c
./drivers/net/arcnet/com90io.c
./drivers/net/depca.c
./drivers/net/eepro.c
./drivers/net/lance.c
./drivers/net/lne390.c
./drivers/net/tlan.c
./drivers/pnp/resource.c
./drivers/sbus/char/display7seg.c
./drivers/scsi/BusLogic.c
./drivers/scsi/advansys.c
./drivers/scsi/eata.c
./drivers/scsi/u14-34f.c
./drivers/tc/zs.c
./include/asm-m68k/sun3xflop.h
./include/asm-m68knommu/ide.h
./include/asm-parisc/ide.h
./include/asm-sparc/floppy.h
./include/linux/ioport.h
./kernel/resource.c
./sound/oss/aci.c
./sound/oss/ad1816.c
./sound/oss/aedsp16.c
./sound/oss/opl3.c
./sound/oss/pss.c
./sound/oss/trident.c
./sound/oss/uart401.c
./sound/oss/wavefront.mod.c
./sound/oss/wavfront.c

And please test your patches before submitting them.

As a minimum compile test any code you change and any code impacted by your
changes.
Also boot a kernel with the changes applied to make sure nothing blows up at
runtime.
And if possible (if you have the hardware), test that the drivers still work
properly. If you don't have hardware to test with then you can at least still
try loading the drivers and see if they fail in a sane manner (no hardware 
detected) or if they blow up.

When submitting a patch, please always provide a description of what change 
the patch makes and why it makes sense to make that change. Also tell what 
level of testing the patch has seen - and remember to Cc: maintainers/authors
of the code you change in addition to sending to the list.

And patches are generally preffered inline as opposed to attachments, as 
should be clear from the documents I pointed you at yesterday.


-- 
 Jesper Juhl

