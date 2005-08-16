Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVHPGKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVHPGKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVHPGKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:10:31 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:48318
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S932268AbVHPGKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:10:31 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Valdis.Kletnieks@vt.edu
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200508160536.j7G5aKox017930@turing-police.cc.vt.edu>
References: <1124168323.10755.179.camel@soltek.michaels-house.net>
	 <200508160536.j7G5aKox017930@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 01:10:23 -0500
Message-Id: <1124172623.10755.230.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 01:36 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 15 Aug 2005 23:58:43 CDT, Michael E Brown said:
> 
> > No, this is an _EXCELLENT_ reason why _LESS_ of this should be in the
> > kernel. Why should we have to duplicate a _TON_ of code inside the
> > kernel to figure out which platform we are on, and then look up in a
> > table which method to use for that platform? We have a _MUCH_ nicer
> > programming environment available to us in userspace where we can use
> > things like libsmbios to look up the platform type, then look in an
> > easily-updateable text file which smi type to use. In general, plugging
> > the wrong value here is a no-op.
> 
> You'll still need to do some *very* basic checking - there's fairly
> scary-looking 'outb' call in  callintf_smi()  and host_control_smi() that seems to
> be totally too trusting that The Right Thing is located at address CMOS_BASE_PORT:

Ok, very nice. Finally some actual code review, thanks. :-)

> 
> +		for (index = PE1300_CMOS_CMD_STRUCT_PTR;
> +		     index < (PE1300_CMOS_CMD_STRUCT_PTR + 4);
> +		     index++) {
> +			outb(index,
> +			     (CMOS_BASE_PORT + CMOS_PAGE2_INDEX_PORT_PIIX4));
> +			outb(*data++,
> +			     (CMOS_BASE_PORT + CMOS_PAGE2_DATA_PORT_PIIX4));
> +		}
> 
> This Dell C840 has an 845, not a PIIX.  What just got toasted if this driver
> gets called?

These are all just standard CMOS port numbers that pretty much every
chipset uses to access CMOS.

If you have not got a PE1300, the worst that happens is you have some
random bits scribbled into your CMOS. Nothing that that "cmos clear"
jumper won't fix. :-)

Seriously, this file is meant to be activated by a userspace program
that looks up the system ID in the appropriate table and writes the
correct value into the driver. I'm not sure there is much more to be
said than "don't do that." The official Dell management stack will
always ensure that this is set correctly. If you don't use the official
Dell stack, libsmbios is available, and we would be happy to make the
appropriate tables available there. If you don't use either of these and
go fiddling with this, I'm not sure there is much more to be done.

> 
> Can we have a check that the machine is (a) a Dell and (b) has a PIIX and (c) the
> PIIX has a functional SMI behind it, before we start doing outb() calls?
> 
> 

I'll have to defer to Doug on this. It may be possible to arrange this.
--
Michael


