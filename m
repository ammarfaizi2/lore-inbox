Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVAYTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVAYTTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVAYTTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:19:20 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:11769 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261878AbVAYTRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:17:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OfRQkDPa/6S/6PUfAWoPjjQCOncxqLthF0+nrxC5yC+eDNXJeEENZ16OPvXSJ0rSUDe6kx2Jp5bSUFHJSIiq3SUajPY6k3FEvGuyv6S7/aDCKqH/Bm1RFWTdrvWU2ebmxAWytT4qE1aT6KmzGMekloLcnINTxJHgBSjwcWE75Ro=
Message-ID: <d120d5000501251117120a738a@mail.gmail.com>
Date: Tue, 25 Jan 2005 14:17:33 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: i8042 access timings
Cc: linux-input@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050125105139.GA3494@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501250241.14695.dtor_core@ameritech.net>
	 <20050125105139.GA3494@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 11:51:39 +0100, Andries Brouwer <aebr@win.tue.nl> wrote:
> On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
> 
> > Recently there was a patch from Alan regarding access timing violations
> > in i8042. It made me curious as we only wait between accesses to status
> > register but not data register. I peeked into FreeBSD code and they use
> > delays to access both registers and I wonder if that's the piece that
> > makes i8042 mysteriously fail on some boards.
> 
> You are following this much more closely than I do, but isn't the
> usual complaint "2.4 works, 2.6 fails"?
> 

Quite often it is but too much has changed in input layer to pinpoing
exact cause of the failure and I am open to any suggestions. Common
problems I see:

1. ACPI sometimes interferes with i8042, especially battery status
polling. I am concerned about embedded controller access as well, it
looks like it takes sweet time to read/write data to it and ec.c does
it with interrupts disabled. I have a patch that enables interrupts
but nobody seems to be interested in testing. ACPI interference ranges
from losing bytes and bytes arriving with > 0.5 sec delay to "Can't
read/write CTR" type of errors. And on the other hand I see some
boxces need ACPI or they will not talk to i8042 (although I suspect
cold boot will also fix that).
How many 2.4 boxes have ACPI on? I honestly do not know. 

2. USB legacy emulation - we used to have PS/2 initialization in
GPM/Xfree which means that USB modules (if any) are already loaded and
requested handoff so results were very consistent. Now it all depends
on who's first. There were couple of PCI quirk patches doing early USB
handoff but they have not been applied out of fear breaking some
boxes. I wonder if there are concrete examples of such patches
breaking boxes, how many and whether DMI decode/workaround will be
beneficial for these.

Also, In 2.4 if BIOS detected PS/2 mouse we trusted it and did not do
any additional checks, now that i8042 is not x86 specific we do
everything by hand and it looks like some hardware is not expecting
it...

Still, I wonder if implementing these delays will give IO controller
better chances to react to our queries and will get rid of some
failures.

-- 
Dmitry
