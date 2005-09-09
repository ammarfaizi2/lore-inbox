Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVIIRkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVIIRkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVIIRkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:40:41 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:12246 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030255AbVIIRkk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:40:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P796Ns2/Aid1lJsvC1JsZJpl9jFKlyxz2InghU7fpGB/G9Z3hgHFNewg5qQGBQHJQ7F2woXrMxqpOKpXBjWBiugqQW8ZWJaqzDFQmqxvtW3vfdBW8rEa052cp8DFuR1aHIHcUHVvh0FE65Zc0Ja5Xc/HedQvmo8ZEJusUJPlkIU=
Message-ID: <528646bc0509091040364ae7d4@mail.gmail.com>
Date: Fri, 9 Sep 2005 11:40:39 -0600
From: Grant Likely <glikely@gmail.com>
Reply-To: glikely@gmail.com
To: David Brownell <david-b@pacbell.net>
Subject: Re: SPI redux ... driver model support
Cc: linux-kernel@vger.kernel.org, basicmark@yahoo.com,
       dpervushin@ru.mvista.com
In-Reply-To: <20050909030934.8419AE9DCC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050907183843.14745.qmail@web30307.mail.mud.yahoo.com>
	 <20050909030934.8419AE9DCC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, David Brownell <david-b@pacbell.net> wrote:
> That implies whoever is registering is actually going and creating the
> SPI devices ... and doing it AFTER the controller driver is registered.
> I actually have issues with each of those implications.
> 
> However, I was also aiming to support the model where the controller
> drivers are modular, and the "add driver" and "declare hardware" steps
> can go in any order.  That way things can work "just like other busses"
> when you load the controller drivers ... and the approach is like the
> familiar "boot firmware gives hardware description tables to the OS"
> approach used by lots of _other_ hardware that probes poorly.  (Except
> that Linux is likely taking over lots of that "boot firmware" role.)
To clarify/confirm what your saying:

(I'm going to make liberal use of  stars to hilight "devices" and
"drivers" just to make sure that a critical word doesn't get
transposed)

There should be four parts to the SPI model:
1. SPI bus controller *devices*; attached to another bus *instance*
(ie. platform, PCI, etc)
2. SPI bus controller *drivers*; registered with the other bus
*subsystem* (platform, PCI, etc)
3. SPI slave *devices*; attached to a specifiec SPI bus *instance*
4. SPI slave *drivers*; registered with the SPI *subsystem*

a. SPI bus controller *drivers* and slave *drivers* can be registered
at any time in any order
b. SPI bus controller *devices* can be attached to the bus subsystem at any time
c. SPI bus controller *drivers* attach to bus controller *devices* to
create new spi bus instances whenever the driver model makes a 'match'
d. SPI slave devices can be attached to an SPI bus instance only after
that bus instance is created.
e. SPI slave *drivers* attach to SPI slave *devices* when the driver
model makes a match.  (let's call it an SPI slave instance)
f. Unregistration of any SPI bus controller *driver* or *device* will
cause attached SPI bus instance(s) and any attached devices to go away
g. Unregistration of any SPI slave *driver* or *device* will cause SPI
slave instance to go away.

[pretty much exactly how the driver model is supposed to work I guess  :)  ]

Ideally controller drivers, controller devices, slave drivers and
slave devices are all independent of each other.  The board setup code
will probably take care of attaching devices to busses independent of
the bus controller drivers and spi slave drivers.  Driver code is
responsible for registering itself with the SPI subsystem.

If this is what your saying, then I *strongly* second that opinion. 
If not, then what is your view?

I've been dealing with the same problems on my project.  Just for
kicks, here's another implementation to look at.

http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019259.html
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019260.html
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019261.html
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019262.html

It also is not based on i2c in any way and it tries ot follow the
device model.  It solves my problem, but I've held off active work on
it while looking at the other options being discussed here.

Thanks,
g.
