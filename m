Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbTIIKxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTIIKxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:53:43 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:14988 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S264019AbTIIKxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:53:41 -0400
Date: Tue, 9 Sep 2003 12:53:23 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
Message-ID: <20030909105323.GA14859@lps.ens.fr>
References: <20030907095423.GA10520@lps.ens.fr> <Pine.LNX.4.33.0309081244080.972-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0309081244080.972-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 12:54:12PM -0700, Patrick Mochel wrote:
> > * swsusp doesn't like accelerated graphics. If the following modules are
> >   loaded:
> >     i830                   68120  20
> >     intel_agp              14744  1
> >     agpgart                25640  3 intel_agp
> >   resuming fails. (Different kind of failures, from spontaneous reboot to
> 
> This is not suprising, and likely something that many people will run 
> into. There is a lot of driver work that needs to be done, especially WRT 
> video devices, as many of them are not tied into the new driver model at 
> all. 

If you want more testers and interesting bug reports, that should be some
kinfd of priority, no ? Everybody is running with accelerated graphics
modules, nowadays.
> 
> For now, the best I can say is to manually unload those modules before 
> suspending and reloading them after resume. We'll work on getting the 
> drivers fixed up, but it will probably take a while. 
> 
> >   However, the mouse is not working anymore (mouse is usb, the only usb
> >   device connected) nor network on eth1 (I haven't tried eth0.)
> 
> For both the mouse and eth1, will they work if you unload the modules 
> first, and reload them after resuming? 

Ok, I tried this: after a normal boot, I went back to runlevel 3,
ifconfig'ed down eth1, unloaded modules i830, hid, ehci-hcd, uhcd-hcd
ne2K-pci and 8390 and echoed 4 to /proc/sleep/acpi. Note that intel_agp,
agpgart and usbcore were still there, those modules can't be removed once
loaded.

The system suspended and resumed correctly. 

I ifconfig'ed up eth1 (which loaded automagically the two modules), and
network was working. I loaded hid, ehci-hcd and uhcd-hcd, and mouse was
working. I telinit'ed 5, X started, went back to runlevel 3 to load i830
which I had forgotten, went back again to runlevel 5. X was working fine,
and video acceleration too. (I think I saw a little glitch on screen; a
little gray line, there, that diseapeared quickly.)

Then I tried to pinpoint more precisely what was wrong. Back to telinit
3. ifconfig down eth1, but keep the modules loaded. rmmod i830, hid, but
keep ehci-hcd and uhci-hcd. I expected that, at least, the computer would
suspend and resume, and I wanted to see if I could recover my mouse and
network interface. I got a black screen at suspend time, and had to
reboot with magic sysrq. I thought that the computer wouldn't suspend
twice in a row.

After a clean boot, I tried again my latest experiment: telinit 3, rmmod
i830, rmmod hid, ifconfig eth1 down, echo 4 > /proc/acpi/sleep.
As I said, the computer should be able to suspend/resume in that
configuration. This time, it failed at resuming. Beautifull kernel panic,
tried to kill init, etc.

It isn't logical. To sum up:

agpgart		i830		hid+uhci+ehci	eth1	  | suspend+resume
+intel_agp						  |
----------------------------------------------------------+--
unloaded	unloaded	loaded		loaded+up | works but
							  | mouse+eth1 fail

loaded		unloaded	unloaded	unloaded  | works and
							  | mouse+eth1 can be
							  | recovered

loaded		unloaded	partially	loaded	  | does not work.
				loaded		but down

What this probably means is that one of my succes was a piece of luck,
non reliably reproducible. Unfortunately, my wife came back from her
trip, and I now have much less time for testing...

If, anyway, I decide to try test5, what patches should be applied ?

Éric
