Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUJKW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUJKW10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUJKW1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:27:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:54466 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269312AbUJKW1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:27:01 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200410110936.37268.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
	 <16746.299.189583.506818@cargo.ozlabs.ibm.com>
	 <200410110936.37268.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097533600.13662.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 08:26:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 02:36, David Brownell wrote:

> I can say that USB suspend/resume works much better now on
> some x86 hardware, especially with patches in Greg's bk-usb tree;
> at the level of "those never worked on 2.6 before!"  There are still
> several PMcore problems getting in the way though, and I'd not
> be surprised if your "used to work" translated as "somehow a
> bunch of bugs canceled each other out on PPC" ...

Well... the difference may be that PPC had working suspend to RAM for
ages way before x86 had anything working better than shitty APM, _and_
based on the device model ...

One thing is that CONFIG_USB_SUSPEND is a 100% killer with USB and
suspend. When set, we will deadlock on some semaphores randomly at
wakeup under various conditions. The typical case is removing your
device (like the mouse) while the machine is asleep, but that's not the
only one.

> > Maybe the real problem is that we are trying to use the device suspend
> > functions for suspend-to-disk, when we don't really want to change the
> > device's power state at all.
> 
> I've made that point too.  STD is logically a few steps:  quiesce system,
> write image to swap, change power state.  The ACPI spec talks about
> that as keeping the system in a G1/S4 powered state, but "swusp"
> doesn't use that ... it does a full power-off.   And of course, full power-off
> means that the BIOS probably mucks with the USB hardware, so it's
> not a real resume any more.

Well, on a lot of platforms, you don't have the choice but do a full power
off anyway. swsusp can do an ACPI S4 if asked to. The only problem at the
moment is that the first round does actually ask for a suspend (D3 with the
new PCI translation) while it should only ask for an "idle" state (I wouldn't
call it D1 neither, we only wnat the driver to stop all activities & DMA,
we don't care about the HW power state proper).

Ben.


