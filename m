Return-Path: <linux-kernel-owner+w=401wt.eu-S932488AbWLSAhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWLSAhX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWLSAhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:37:23 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:20394 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932488AbWLSAhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:37:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:Subject:Date:User-Agent:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=NFGQmVLyNQvmKRVKKzOwJNdj+nAEXzzRXbTi7xNvHPfN3QPenpDmzpjIPdgj1XbFSKDfoY7KRalZUL35d8MQkL0vL96oD8JxmO/hVvdvecAExNtuKigWHkkyVRlzQ0yJ2ZQt2aA8foVG3Ak+mvhpSF1JhljaF4M1aAthOd6MUeo=  ;
X-YMail-OSG: rBqSGI0VM1kPUlxVE3PMnks.7jD2tW9lKNojETEle2J.LXnqlFNEwMVw05JMQtZtXzz33llgDmUC7TuLBp1hPRnkk4aBfUpt2PR4RFj3ayJoq_pPog019FWnmClnxR18HcpLju43m9wa6EVheX.4XlF50.Z_hLbOfpoMbHbttVEc2CIw8_ApgZPIQjjs
From: David Brownell <david-b@pacbell.net>
Subject: FYI: [patch 2.6.20-rc1 0/6] I2C driver model updates, part II
Date: Mon, 18 Dec 2006 16:37:19 -0800
User-Agent: KMail/1.7.1
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612181637.20077.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a heads-up to the folk who read LKML more than more specialized
Linux lists ... there's work afoot to clean up the I2C core and make it fit
the driver model better.  (Some would say "overdue work...".)

The most interesting/useful part (IMO) is summarized in the appended message;
you can read list archives starting at:

  http://lists.lm-sensors.org/pipermail/i2c/2006-December/000633.html

The "part I" stuff gets rid of i2c_adapter.dev (it was pretty pointless),
which opens the door to eliminating even more of the redundancy between
i2c-core and the driver model.  It also lets I2C device drivers use the
standard driver model suspend()/resume()/shutdown mechanisms.  Innocuous,
despite the number of i2c_adapter.dev users that needed to change.

The "part II" bits basically leave "legacy" I2C drivers alone; they add
support for "new style" drivers.  The difference is that legacy drivers
create their own device nodes, and their probe() routines look at busses;
while new style drivers work like any other driver in current Linux,
with probe() being handed a pre-created device node (i2c_client).

I think the plan is to get this into MM soonish; "part I" being nearly
ready, and "part II" probably still needs a bit of tweaking.  (I have
my own notions, and suspect at least one person on LKML will have some
opinions to share...)  There are already OpenFirmware conversion patches,
and driver/platform conversions will as usual take a while to sort out.

- Dave



----------  Forwarded Message  ----------

Subject: [patch 2.6.20-rc1 0/6] I2C driver model updates, part II
Date: Monday 18 December 2006 2:59 pm
From: David Brownell <david-b@pacbell.net>
To: i2c@lm-sensors.org

As promised, the second set of patches ... adding "new style" driver
probe support.  This will help at least

 - Embedded I2C in general (which need IRQs, and board-specific config)
 - OMAP (where I2C can't use SMBUS_QUICK)
 - RTCs (which for various reasons often can't use SMBUS_QUICK probing)
 - OpenFirmware (which provides tables of I2C devices)
 - DVB (I'm told the probing is problematic there too)

These patches apply after the latest "part I" patches (sent to this list,
with three updates posted after feedback from Jean).  The patches are:

 - Support probe(), and hotplug/coldplug
 - Support remove()
 - Document the "new style" driver model probe() and remove()
 - Drive new style driver binding by {bus#, dev#, info} device declarations
 - Update the i2c-omap adapter driver to use bus# matching chip docs
 - Update one OMAP board, and a driver, to use the new infrastructure

I expect that last patch will get split in two; for this series it's
best viewed as an example.

- Dave


-------------------------------------------------------
