Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbTGLO41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbTGLO41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:56:27 -0400
Received: from cherryhinton.org.uk ([194.106.52.201]:20325 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S265879AbTGLO4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:56:25 -0400
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Reply-To: Ruth.Ivimey-Cook@ivimey.org
To: Samuel Flory <sflory@rackable.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached to fix
Date: Sat, 12 Jul 2003 16:11:13 +0100
User-Agent: KMail/1.5.2
Cc: Chad Kitching <CKitching@powerlandcomputers.com>,
       Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
References: <Pine.SOL.4.30.0307110011320.6781-100000@mion.elka.pw.edu.pl> <3F0DF118.3080806@rackable.com>
In-Reply-To: <3F0DF118.3080806@rackable.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121611.13863.ruth@ivimey.org>
X-Spam-Score: -1.6 (-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various people wrote:
> >>Ignore FastTrak BIOS and configure controller for RAID
> >>CONFIG_PDC202XX_FORCE
> >>  Forces the driver to use the ATA-RAID capabilities, overriding the
> >>  BIOS configuration of the controller. Do not enable if you are
> >>  using Promise's binary module.  This option is compatible with the
> >>  ataraid driver.
> >What about this:
> Much better, but
> >Ignore FastTrak BIOS
> >CONFIG_PDC202XX_FORCE
> >  Forces the driver to use FastTrak controller even if it was disabled
> >  by BIOS for Promise software RAID driver.
> This one might confuse people thinking we mean the ataraid driver, and
> not the binary only driver.

My personal experience of the FastTrak device is that you must always "force" 
it if you just want JBOD. [Note: I have never used a promise device as the 
1st controller, because the Southbridge ide controller always comes in 
first]. Now, I have never tried using ataraid or the promise bin-only driver, 
so I guess there are occasions when not forcing is a good thing. I assume 
from other comments that no-force is the right option for the Promise 
binary-only driver?

I am much of the opinion that "CONFIG_PDC202XX_FORCE" should be a run-time 
option so that it can be set up correctly for the user's machine even when 
the kernel is a vendor one with pre-selected config choices. If this doesn't 
happen, in some cases (e.g. installing a new kernel) the user's disks just 
disappear and there isn't much you can do about it :-(   See my comments at 
the end of the mail for more on this.

> Maybe:
> Forces the driver to use FastTrak controller even if it was disabled
>  by BIOS for Promise's binary only software RAID driver.
>
> >  Say Y if you do not use Promise's software RAID or
> >        if you want to use ataraid driver.
> >
> >  Say N if you want to use Promise's binary module.

I don't like this one, as at least on first reading I completely misunderstood 
it -- it seemed as if you only had RAID choices, no non-RAID ones. I see now 
that Y gives you a (veiled) non-RAID choice. Is the following better?


Don't reserve the FastTrak controller for the Promise proprietary RAID driver.
  Say Y if you:
    - want to use attached disks quite independently;
    - want to use attached disks in a Linux Software RAID (mdX) array;
    - want to use attached disks with the Linux 'ataraid' driver. You must
      also enable the option CONFIG_BLK_DEV_ATARAID_PDC.

  Say N if you want to use Promise's proprietary, binary only, Software
    RAID driver.


I think a better configuration setup than this would be a multiple- choice 
arrangement that subsumes CONFIG_PDC202XX_FORCE, CONFIG_BLK_DEV_ATARAID_PDC 
and CONFIG_PDC202XX_NEW option into one question, like this:


Configuration of the FastTrak IDE controller
CONFIG_PDC202XX_MODE
  Please select the appropriate driver for this controller:
    [  ]  Promise proprietary, binary only, Software RAID driver
    [  ]  Linux GPL version of Promise Software RAID driver
    [  ]  Standard IDE driver, for disks that can be used quite independently


 However, this still has the problem of what happens if you have multiple 
controllers and wish to use them in 2 or more different configurations (e.g. 
2 disks on 1st controller ataraid, 2 disks on another controller as JBOD).

Therefore, IMO the best setup would be to provide options that enable 
possibilities (e.g enable you to use ataraid by compiling the code) but that 
the actual use of the disks is defined in a module or command-line switch 
(e.g. "pdc_ide2=ataraid,pdc_ide3=jbod"). In this case, we will keep the 
CONFIG_BLK_DEV_ATARAID_PDC and CONFIG_PDC202XX_NEW options but they do not 
imply a purpose: they just ensure that code is compiled. The option 
CONFIG_PDC202XX_FORCE becomes a run-time only thing, and so disappears from 
the config.

Should I think about coding this?

Regards,

Ruth

-- 
Engineer, Author and Webweaver

