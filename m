Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWDMXLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWDMXLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWDMXK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:10:57 -0400
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:30603 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S965022AbWDMXKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:43 -0400
Message-ID: <443EDAD1.8090406@keyaccess.nl>
Date: Fri, 14 Apr 2006 01:12:17 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl> <20060413145756.GA29959@flint.arm.linux.org.uk> <443E79AD.50505@keyaccess.nl> <20060413170549.GB7805@flint.arm.linux.org.uk> <20060413220205.GA1770@suse.de>
In-Reply-To: <20060413220205.GA1770@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> I still really don't understand why these ALSA drivers are so unlike
> any of the zillion other drivers we have in the kernel that work just
> fine today.

It's nothing to do with ALSA, only with ISA -- ALSA is just one of the 
few remaining serious ISA users. Have said this a number of times now, 
so apologies to anyone who _is_ following this. I promise it's going to 
be the last time. The issue:

Historically, ALSA ISA drivers failed to load upon not finding their 
hardware at load time, same as most ISA drivers. When 2.6.16 switched 
them to use of the platform driver interface this behaviour was 
inadvertently changed due to the platform driver interface not passing 
up the probe() return. Things such as the "alsaconf" configuration 
script actualy rely on the non-load behaviour and current submissions to 
-stable simply use drvdata() being !NULL as a private success flag to 
restore that behaviour. This is okay.

Longer term (than -stable) it could ofcourse be better to follow the 
model from saner busses such as PCI more closely -- we could just load 
whether or not a device was bound to. The difference though is that a 
PCI device has a life all by itself by virtue of its _bus_ knowing that 
it's present (it has an entry in /sys/devices/pci*, without any device 
specific driver loaded) while these old ISA devices only exist in the 
driver model by virtue of a driver creating them as a platform device 
because it might want to drive them. If we keep them registered even 
after failing a probe, then /sys/devices/platform turns into an 
enumeration of the drivers we loaded, not a view of what's present in 
the system.

(and there is no point in keeping the driver loaded when we don't keep 
the devices registered as well -- you couldn't do anything with that 
driver, it would just be sitting there taking up memory)

Problem therefore: /sys/devices pollution. Note that ALSA supports some 
20 (non-pnp-only) ISA drivers and imagine loading them all, with all of 
them creating one or more devices in /sys/devices/platform, with none of 
the actual hardware present. I consider this not nice, not from the view 
of ALSA, but because I've been told that one of the reasons for /sys was 
this nice view of "what's in this system" that /sys/devices would provide.

The answer needed -- if you _do_ think it's okay to just have those 
devices present in /sys/devices/platform without the hardware existing, 
then I do not have a problem. I'll just suggest to keep them registered 
and be done with it (*).

If on the other hand you agree it's not nice, I'll try and look into 
what a seperate isa_bus could provide.

Rene.

(*) Note by the way I do not necesarily qualify as an ALSA person. I 
only ran into this when I submitted a new ALSA ISA driver for 2.6.16+. 
Takashi Iwai is being CCed on all these messages though, and he hasn't 
yet protested anything I've been saying, so I assume he's okay with my 
worries at least...

