Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTHVWMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTHVWMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:12:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:62420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263263AbTHVWMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:12:31 -0400
Date: Fri, 22 Aug 2003 15:05:15 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: <torvalds@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <20030822215315.GD2306@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is stable series, and /proc/acpi/sleep was fine for at least
> entering S3 and swsusp. Anyway, if you killed sleep, you should kill
> alarm as well. Its only usefull for sleeping, and IIRC it never worked
> properly, anyway.

I will fix alarm. I will also update Nigel's suspend scripts (or release 
others) that abstract the mechanism for entering sleep away from the user. 

> If you want to help, take a look at drivers/pci/power.c. That file
> should not need to exist, but if I kill it bad stuff happens after
> resume. Killing pm_register() and friends would be nice.

I'll get there. Give me a couple of weeks.. 

> what about enum action { }; extern int (*pm_power_down)(enum action
> state)?

That's doable. 

> > Secondly, you can actually remove the second command line parameter 
> > ("noresume") by simply specifying a NULL partition to this parameter. It 
> > requires about a 5-line change, and makes things simpler. 
> 
> You'd better not. You are expected to have one "resume=/foo/bar"
> specified as append in lilo. You want to able to say noresume and do
> one boot without resuming. Turning resume with
> "resume=/dev/nonexistent" would be playing roulete with command line
> argument order.

AFAIK, you could have

resume=/dev/hda3 always appended to your command line. Should you suspend 
and not want to resume, you should be able to manually add

"resume=" on the command line after the above, and have the setup function 
called again, which would reset it to NULL, thereby keeping the same 
semantics as "noresume", but with less namespace pollution. Anyway, I'm 
not going to do this now. I'll send you a patch if I do.

> > -EAGAIN allows the drivers/devices that really need special care to 
> > specify it. Otherwise, we'll end up calling ->suspend() twice for power 
> > down for each device (those that can do w/ interrupts enabled and those 
> > that need interrupts disabled), which also requires every single driver to 
> > check whether or not interrupts are enabled, instead of just those that 
> > need it. 
> 
> No, you should have simply let it alone and pass "level" parameter
> telling driver if interrupts were disabled or not. No need to
> constantly change API while trying to stabilise the code.

...and modify each driver to check for it? 

The decision to kill the level parameter came from extensive discussions
with Benh, who convinced me that we only need to call ->suspend() once for
any device; though we still need to somehow provide for those that need to
power down with interrupts disabled. I suggested -EAGAIN, since it allows
us to special case those that need it, with the minimum amount of impact.
Ben agreed with me.



	Pat

