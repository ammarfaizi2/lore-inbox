Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbUAFAcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUAFAcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:32:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:29088
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265912AbUAFAcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:32:13 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: udev and devfs - The final word
Date: Mon, 5 Jan 2004 18:31:26 -0600
User-Agent: KMail/1.5.4
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl>
In-Reply-To: <20040106001326.A1128@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051831.26973.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 January 2004 17:13, Andries Brouwer wrote:
> An earlier fragment of the discussion was concerned with the fact
> that random(); is a bad idea. Something reproducible is better.

To find people making bad assuptions that will only break after widespread 
deployment, random() is much better than "usually reproducible".

> Let us abbreviate the above function f. Some driver determines that
> a disk has serial number A809ADGC. Another driver determines that
> some device was produced by HP but otherwise has no opinion.
> A third driver has no stable information at all about the device.
> They assign device numbers f("A809ADGC"), f("HP"), f("").
>
> What is the result? Yes, device numbers are cookies, but a reasonable
> attempt has been made to make the device numbers stable.

Should the same argument be made about process ID's?  When your system boots 
up, your daemons generally start in the same order.  But any script that 
depends on this is broken.

Or filehandles.  They're cookies.  There's whole pages on why it's a bad idea 
to make assumptions about what filehandles point to:

http://en.tldp.org/HOWTO/Secure-Programs-HOWTO/avoid-race.html

> No guarantees anywhere - this is best effort. Better than no effort.

You're suggesting that it should be easier to write things that are 
fundamentally unclean, and bake in assumptions that WILL break, but not on 
the developer's machine, only for end-users who aren't expecting it.

What's the advantage?  Making it easier for people to do something stupid?  
(You can sort of trust this thing we can't make any guarantees about.  Since 
when is "sort of trust" a condition that's encouraged?  At the very least, 
those kinds of cases are backed up by a detection and recovery mechanism and 
the whole thing's called a heuristic.)  Why is there a need for this?

Either the kernel can make a guarantee, or it should very much not make a 
guarantee.  Where is an example of a middle ground?

> And this information helps udev. It may make a callout superfluous,
> or even give udev information that cannot be obtained from userspace.

I'm waiting for the udev maintainer to weight in on this and say "no, it 
doesn't".  If there is information that "cannot be obtained from userspace", 
then we should fix the sysfs exports.  Encoding something in a semi-stable 
cookie and actually trying to USE that information is stupid.

What about kernel upgrades?  Future backwards compatability when developers 
change the device enumeration methods?  (The sata driver got completely 
rewritten from scratch, and now it detects devices in a wildly different 
order, but we need this shim layer for backwards compatability with a 
guarantee we never should have made because we encouraged old scripts to 
remain broken.)  This plants hidden land mines restricting future 
development.  You're basically proposing a whole "device number stabilization 
infrastructure" for future kernels if it's to have ANY meaning at all...

Where's the advantage?  Name a single real-world case that's more difficult to 
fix than it would be to make the kernel pander to it in perpetuity.

> Andries

Rob

