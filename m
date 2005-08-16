Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVHPFbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVHPFbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVHPFbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:31:00 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:43710
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S965103AbVHPFbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:31:00 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508160517.j7G5Hm2D017218@turing-police.cc.vt.edu>
References: <1124165368.10755.136.camel@soltek.michaels-house.net>
	 <200508160517.j7G5Hm2D017218@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 00:30:51 -0500
Message-Id: <1124170251.10755.205.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 01:17 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 15 Aug 2005 23:09:28 CDT, you said:
> 
> > No, dcdbas has nothing to do with this. I'll have to submit a patch
> > against the docs. The program you need to use already exists and is
> > open source. You can use libsmbios to do this.
> > http://linux.dell.com/libsmbios/main.
> 
> Now I'm confoozled.  Maybe - I suspect we're actually in violent agreement...

nope... :-)

> 
> On Mon, 15 Aug 2005 17:58:56 CDT, Michael_E_Brown@Dell.com said:
> > 	Additionally, we are releasing an open source library (GPL/OSL dual 
> > license) that can use these hooks to perform many systems management 
> > functions in userspace. See http://linux.dell.com/libsmbios/main/. We 
> > should have code in libsmbios to do SMI using this driver within about two 
> > weeks.  We currently writing the SMI hooks in libsmbios using this posted 
> > version of the driver. I am the maintainer of this project, and it is my goal 
> > to have code in libsmbios for every Dell SMI call.
> 
> So dcdbas *is* intended as the kernel end of the userspace libsmbios, which
> is the suggested way of getting that BIOS updated. OK, I got it now.. ;)

not quite... :-)

Basically, for the exact case of RBU, libsmbios _today_ has what is
necessary to support this, without using dcdbas.

Today, libsmbios can set certain CMOS bits. _Some_ of the BIOS F2 screen
options are represented in CMOS as bits. Also, other features are made
available through CMOS that are not available through F2, and all of
these bits (F2 bits and other bits) can be manipulated by libsmbios. It
just so happens that RBU is implemented using a CMOS bit (represented by
token 0x005C and 0x005D). 

The addition of 'dcdbas' driver enables _extra_, _additional_
functionality that libsmbios does not today have. The rest of the BIOS
F2 screen options that are not in CMOS are available through SMI. Also,
lots of other interesting stuff that is not related to BIOS F2 screens
is available through SMI.

To give an example: the Asset tag can be set through CMOS and SMI.
Today, libsmbios can only set asset tag through CMOS. With the addition
of dcdbas, libsmbios can use the SMI method to update asset tag. 

SMI is a more reliable way to set asset tag, as it is dynamic and system
flash is updated right away. Future systems may drop CMOS method
completely as we start to run out of room in CMOS (there are only 256
_bytes_ available in CMOS, remember.) 

Basically, I am positioning libsmbios as an open-source way to take
advantage of all of the features of a Dell system that are available
through the system smbios/dmi table (similar to dmidecode), system cmos,
or through SMI calls.

> 
> (continuing on)
> 
> > The binary you want to use is "activateCmosToken", under bins/output/
> > (after compilation). The command line syntax is like this:
> > 	activateCmosToken 0x005C
> > 
> > If you want to cancel a BIOS update that has already been activated
> > (per above), use: 	
> > 	activateCmosToken 0x005D
> > 
> > Basically, follow the docs in the RBU docs as far as cat-ing the bios
> > update image to the rbu sysfs files, then use the activateCmosToken
> > program to tell BIOS to do the update on reboot. 
> 
> Ahh... the missing piece I didn't have before. :)

I provided this info to Abhay when he posted RBU, and I thought he had
already updated the rbu docs with this info. I suppose I should have
checked. :-(

--
Michael

