Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUIVLHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUIVLHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUIVLHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:07:15 -0400
Received: from nat.ecole.ensicaen.fr ([193.49.200.25]:25987 "EHLO
	e450.ensicaen.ismra.fr") by vger.kernel.org with ESMTP
	id S264299AbUIVLHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:07:11 -0400
From: "Jean Delvare" <khali@linux-fr.org>
To: Adrian Cox <adrian@humboldt.co.uk>, Michael Hunold <hunold-ml@web.de>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Reply-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Date: Wed, 22 Sep 2004 13:08:00 +0100
Message-Id: <20040922102938.M15856@linux-fr.org>
In-Reply-To: <1095843365.18365.48.camel@localhost>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de> <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>
X-Mailer: Open WebMail 2.10 20030617
X-OriginatingIP: 62.23.212.160 (delvare)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 09:56:06 +0100, Adrian Cox wrote
> On Tue, 2004-09-21 at 19:05, Michael Hunold wrote:
> 
> > With that addition, it's possible for the i2c core to check if the
> > .class entries of the adapter and the client match. If they don't then
> > there is no need to probe a driver. This will help to keep non-i2c
> > drivers to be probed on dvb i2c busses (and screw them up accidently).
> > Currently it's up to the driver to decide wheter to probe a bus or not.
> 
> I've said it before, but:
> This is all the wrong way round. I2C probing is a solution for the
> problem of finding sensors on a pre-ACPI PC. We'd never have 
> invented it if all we had was DVB cards and monitor detection.

Agreed, the sensors case is different from the other I2C bus users. However I
don't get the "pre-ACPI PC" part. Detecting the hardware monitoring chip is
still needed even in ACPI-enabled PCs. I've almost never seen the ACPI
subsystem handle hardware monitoring (except on my laptop where it presents a
single temperature value and no limits). Instead, the hardware monitoring
chips are still there sitting on the I2C or ISA bus, waiting for us to probe
them. I'm not familiar with ACPI, but if it is supposed to handle hardware
monitoring, it looks like at least the current BIOS and/or Linux
implementations don't handle it yet.

> These .class entries are workarounds that shouldn't be required. For 
> DVB cards, TV capture cards, monitor detection, and embedded systems 
> the required behaviour is normally known in advance. Why should the top
> level driver have to use these workarounds to steer the result of
> probing when it already has all the information?

Well, I don't quite follow you here. On the one hand you agree that sensors
and video/embedded stuff should be handled differently, but then you don't
want us to tag them according to their function in order to actually behave
differently.

Of course we could limit the difference to a simple "do probe or do not probe"
flag. This would probably be sufficent. While we are at it though, clearly
labeling adapters with a class promises a wider usability. Another superiority
with the classes is that the check is done by the core instead of relying on
the client's good will. OK, the client could lie on its class(es) to bypass
the check, but this is quite different from simply omitting to check the "do
not probe" flag and less likely to happen by accident too.

> My rough proposal would be:
> 1) One by one, disable probing on these I2C adapters.

The clients are probing the adapters, not the other way around, so there is no
way to "disable probing on these I2C adapters". The only way is to tag the
adapters as "do not probe" and have either the core or the clients respect
this, just as I described above.

> 2) In the pci probe function of the DVB or capture card, do a 
> sequence like this: my_dev_priv->i2c_adapter = 
> i2c_adapter_create(...); my_dev_priv->tea6415 = 
> tea6415_create(my_dev_priv->i2c_adapter,                             
>          &my_tea6415_parameters); my_dev_priv->saa7111 = 
> saa7111_create(my_dev_priv->i2c_adapter);
> 
> 3) Then to use the i2c client:
> tea6415_switch(my_dev_priv->tea6415, &vm);

As far as I know, this is exactly what video folks already do. The whole issue
is not with video folks probing adapters, but with them not wanting us (the
sensors clients) to arbitrarily probe their video i2c busses in search of
hardware monitoring chips. Michael's proposal is meant to give us a way not to
do this anymore.

> This is type safe, it allows out of tree DVB and capture drivers,
>  and it never ever sends an unexpected event down an I2C bus. It 
> doesn't even need to change the I2C core very much.

The change in the i2c-core will be really simple (comparing two bitfields
isn't that hard), although I agree it'll almost certainly cause troube in the
early days if .class fields are not properly filled in some adapters or clients.

All in all I don't see how we can solve the problem without either a "do not
probe" flag in the adapter structure or a class bitfield in both the adapter
and the client structures. I would be fine with either option unless someone
explains how one is better than the other in any particular case.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

