Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVAZXxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVAZXxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVAZXwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:52:43 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:8171 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262223AbVAZT6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:58:16 -0500
Date: Wed, 26 Jan 2005 23:21:05 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126232105.77781a17@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050126202027.3b56a14f.khali@linux-fr.org>
References: <waZNwjBp.1106750054.2006670.khali@localhost>
	<1106755819.5257.207.camel@uganda>
	<20050126202027.3b56a14f.khali@linux-fr.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 20:20:27 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> [Voluntarily skipping a large part of the discussion so as to stop
> wasting everyone's time and focus on the one technical point I am
> interested in.]
> 
> Hi Evgeniy,
> 
> > As I saw from different documentation - logical devices itself are the
> > same.
> > 
> > And it is the same for superio standard.
> > 
> > For example sc1100 and pc87366 superio chips have the same logical
> > inside, although different logical device set.
> > 
> > (...)
> > 
> > Not only access.
> > Logic inside superio chip is submitted to superio standard.
> > I designed(at least tried to) superio subsistem
> > that it can handle all differencies using per device callbacks.
> 
> I would like to ensure that we agree on what is common to all Super-I/O
> chips (as per Intel's LPC specification).
> 
> 1* Super-I/O are accessed at I/O addresses 0x2e+0x2f or alternate
> addresses 0x4e+0x4f.
> 
> 2* These addresses give access to a 256 byte addressing space.
> 
> 3* Super-I/O chips are divided in logical devices, which can be selected
> by writing its id to 0x07. What each logical device does is not
> standardized (depends of the chip).
> 
> 4* Range 0x00-0x2f is common to all logical devices, while range
> 0x30-0xff is logical-device specific.
> 
> 5* Range 0x20-0x2f contains chip-wide identification and configuration
> registers. Definition of these registers is not standardized.
> 
> 6* 0x31 controls the activation of each logical device, 0x60-0x63 its
> base address, 0x70-0x73 its interrupts. Definition of these registers is
> standardized.
> 
> 7* Range 0xf0-0xff contains logical device-specific configuration
> registers. Definition of these registers is not standardized.
> 
> And that's about it. The way each logical device works (how registers
> are mapped from the base address) is completely chip-specific.
> 
> Do we agree on all this, or did I miss somthing? I would like to make
> sure that, when you refer to sharing as much code as possible between
> the various Super-I/O chips, you really mean the organization of logical
> devices within the Super-I/O (selection, retrieval of base address and
> interrupt configuration) and not the logical devices themselves.

You are absolutely right, I just want to add following note:

Most of the logical devices inside superio chips has standardized access methods.
One just need base address and index, that is all.
For such devices all infrastructure already exists in the provided superio core.
One just need to provide one logical device driver for it(like sc_gpio.c).

But, sometimes it really can be the situation, when logical device is not
obeyed to rules in the existing logical device driver(like GPIO in sc1100, which is
not superio logical device but is fitted design quite well), for such
cases there is also infrastructure in superio driver. For example scx.c -
it has it's own private GPIO logical device, which is "cloned" from the
"standard"(described in sc_gpio.c) logical device(clones actully have 
almost nothing in common).

Situation with device cloning is very unlikely according to various superio
chips I saw and read datasheets.
 
> Thanks,
> -- 
> Jean Delvare
> http://khali.linux-fr.org/


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
