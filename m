Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUJKDqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUJKDqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUJKDqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:46:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:17083 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268667AbUJKDqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:46:14 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1097466354.3539.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 13:45:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 12:41, Linus Torvalds wrote:

> > Any reason why this totally broken code was ever merged upstream ?
> 
> Because it fixes a lot of drivers.

Disagreed. Sorry, but can you give me a good example ? The drivers still
do the broken assumptions of passing directly the state parameter to
pci_set_power_state() (or whatever we call this one these days) but this
is worked around by defining PM_SUSPEND_MEM to 3 in pm.h.

(Which was actually done in the tree)

What this code in the PCI layer does is basically just turning the "4"
of suspend-to-disk into a "3" for D3 (and by doing so, confirms what is
imho a broken interface). This is wrong. That means that driver D3 all
over the place on suspend-to-disk which is totally useless and even not
wanted in various cases. It prevents things like radeonfb from properly
special casing suspend-to-disk to keep us with a working console until
late in the process.

> > Please, revert that to something sane before 2.6.9...
> 
> Nope. There's just too much confusion abou what the state thing means. 
> See the TG3 driver, for one, all the USB drivers for another.

tg3 is fixed for now with 2 lines:

===== drivers/net/tg3.c 1.209 vs edited =====
--- 1.209/drivers/net/tg3.c	2004-09-15 15:15:06 +10:00
+++ edited/drivers/net/tg3.c	2004-10-11 13:36:19 +10:00
@@ -8445,6 +8445,9 @@
 	spin_unlock(&tp->tx_lock);
 	spin_unlock_irq(&tp->lock);
 
+	if (state != PM_SUSPEND_MEM)
+		return 0;
+
 	err = tg3_set_power_state(tp, state);
 	if (err) {
 		spin_lock_irq(&tp->lock);

USB suffer from various breakage still in PM code. For one, that PCI
change will do nothing with the USB "device" drivers, and as far as
hosts are concerned, well, I don't see the problem. Just go to D3 when
passed PM_SUSPEND_MEM, and disconnect when passed PM_SUSPEND_DISK. But
have you tried removing a USB device while the machine is asleep with
any of the later versions of the USB code ? deadlock on some semaphore
on resume, 100% reproduceable, which is actually a regression as it used
to work with earlier versions of the kernel. The USB code path are
something I haven't found my way in to try to fix it though, I think we
have some fundamental issues with adding/removing devices vs. walking
the PM tree.

> The long-term solution is to make this thing be not a number at all, but a 
> restricted type (ie a "struct" with one member, or similar) to make sure 
> you _cannot_ mis-use it. As it is, most PCI drivers do seem to expect a 
> PCI suspend state. 

Maybe. There is more confusion than that actually. The device-level PM
via /sysfs allows you to pass the number down directly, which is bogus
as those have totally different semantics than the system sleep and
won't properly walk the tree to suspend children etc...
 
> > I'll bomb it ever and ever again until some sense gets into
> > all of this.
> 
> If you have the energy to complain about it, maybe you have the energy to 
> change it to use a "struct", and fix up all the drivers and verify that 
> they actually get it right.
> 
> Until that happens, we pass in PCI suspend states, and we _also_ make sure 
> that the PCI suspend states "almost match" the PM_SUSPEND_xxx constants, 
> so that when there is confusion, it tends to be as benign as possible.

If we can ever agree about the format of that structure and what kind
of information we want to pass to drives ... The actual D state we want is
something which is a "mix" of driver-specific and platform-specific knowledge.

The problem with your fix is that it removes from the drivers the knowledge
of PM_SUSPEND_DISK (well ,maybe still obtainable via a global, but that's
really ugly). Also, it causes drivers to default to D3 for suspend-to-disk
which doesn't make much sense.

I'd rather have drivers try to pass "4" to pci_set_power_state() and having
the later just "do nothign" in this case.

Ben.


