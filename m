Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269774AbUJAM40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269774AbUJAM40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269784AbUJAM4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:56:25 -0400
Received: from nat.ecole.ensicaen.fr ([193.49.200.25]:31678 "EHLO
	e450.ensicaen.ismra.fr") by vger.kernel.org with ESMTP
	id S269774AbUJAM4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:56:13 -0400
From: "Jean Delvare" <khali@linux-fr.org>
To: Adrian Cox <adrian@humboldt.co.uk>, Greg KH <greg@kroah.com>
Cc: Michael Hunold <hunold-ml@web.de>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Date: Fri, 1 Oct 2004 14:57:06 +0100
Message-Id: <20041001123741.M30026@linux-fr.org>
In-Reply-To: <1096633365.16121.125.camel@newt>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com> <41545421.5080408@web.de> <20040924200503.652ccf8e.khali@linux-fr.org> <415481B4.10804@web.de> <20041001065209.GA9561@kroah.com> <1096633365.16121.125.camel@newt>
X-Mailer: Open WebMail 2.10 20030617
X-OriginatingIP: 62.23.212.160 (delvare)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 13:22:45 +0100, Adrian Cox wrote
> Either the i2c devices need to be able to support a list of permitted
> adapters, or the i2c adapters need a list of permitted clients. A single
> class isn't adequate. Consider the following scenario:
> 
> The FooTV123 has multiplexor MX3R0K3 and frontend XYZZY, the TVMatic3000
> has frontend XYZZY and multiplexor MX31337, and the FooTV124 has
> multiplexor MX31337 and frontend FR012. All three cards are 
> installed in the same machine. In the worst case the probe code for 
> MX31337 puts MX3R0K3 into a state that requires a hard reset.
> 
> Manual connection of clients makes it easier to develop a driver outside
> the kernel tree, then merge it when ready, without having to 
> allocate a number from a central authority.

Agreed. Greg's proposal would somehow mean one class per video device adapter,
which doesn't sound good. We have room for only 32 classes anyway. However, I
agree with Greg that a "no probe" flag isn't needed if we already have
well-defined classes.

Basically, probing is something only hardware monitoring chip drivers do (+
eeprom, so we can include the DDC world). Video clients don't probe as far as
I know (because probing just doesn't work here). So, if we were to have a "no
probe" flag, it would always be clear when class is VIDEO and always set when
class is HWMON (I voluntarily simplify, there are a couple more classes), so
it means that the "no probe" flag is redundant. To put it short, simply not
declaring an adapter as class HWMON means it won't be probed ever (the eeprom
case is to be considered separately and may require a class of its own).

> Creating the adapter with a list of permitted clients is also an
> adequate solution for a bus like I2C which doesn't properly support
> probing. The OCP bus on PowerPC has no explicit probing, and uses a
> similar approach of creating the bus with a list of the devices possible
> for that PowerPC model.

This may be fine for the PPC world, but in the i386 world it wont work. To
give you an idea, the MBM database has 1155 motherboards listed, most of which
have hardware monitoring chips on-board. It happens quite often that I don't
find motherboard models I am looking for therein, so a complete base would
have maybe 1500 or 2000 entries. We certainly don't want to have such a base
in the linux kernel tree. It would be unmaintainable, and also would ensure
that new hardware has no chance to work until us developers know about it.
Probing is the way to go there, even if the I2C bus was obviously not designed
for this.

So I2C bus probing won't go away. Classes or flags are what we need (unless we
go for separated I2C adapter lists, but that's a completely different
approach, and obviously we are not interested until someone comes with a solid
patch that really does this.) A working classes system is really next door,
Michael did most of the work already, half of which is already merged into the
kernel tree.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

