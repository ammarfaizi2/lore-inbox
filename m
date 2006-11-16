Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162284AbWKPEYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162284AbWKPEYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162270AbWKPEYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:24:34 -0500
Received: from science.horizon.com ([192.35.100.1]:9258 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1162284AbWKPEYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:24:34 -0500
Date: 15 Nov 2006 23:24:32 -0500
Message-ID: <20061116042432.26300.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It all boils down to the same thing: either we have to know that MSI works 
> (where "know" is obviously relative - it's not like you can avoid _all_ 
> bugs, but dammit, even a single report of "not working" means that there 
> are probably a ton of machines like that, and we did something wrong), or 
> we shouldn't use it. There is no middle ground. You can't really safely 
> "test" for it, and while you _can_ say "just do both", it doesn't really 
> help anything (and potentially exposes you to just more bugs: if enablign 
> MSI actually _does_ disable INTx, but then doesn't work, at a minimum you 
> end up with a device that doesn't work, even if the rest of the kernel 
> might be ok).

Er... why can't you test it?

The fundamental problem in IRQ routing is that if you have it wrong,
you have a screaming interrupt that you can't shut up.

Well, before giving up entirely, assume that *some* device owns that
interrupt, it's just mis-routed.

So start calling the IRQ handlers for *every* PCI device until the
damn interrupt goes away, or you've really proved that it can't
be shut up.

If you have interrupts coming in fast, you might have to retry a few
times to be sure there's nothing to be done, but that's nothing new.

Now, if you get really nasty with the locking, you can disable all
other interrupt handlers on all processors until you've dealt with
the screaming interrupt, and when it goes away, you can point the
finger conclusively at the device which has the misrouted interrupt.
And you've also found where its interrupt *is* routed.

If you don't have such nasty locking, then you only have a strong
suspiscion about what did it, but a few repetitions can firm that up.
Any time a device handles an interrupt that arrived from the expected
place, its index of suspiscion goes down.  You can even use this
to select an order to call the various PCI drivers.

All of this can be rather time-consuming and mess up real-time response,
but it's only once per boot, and being able to point the finger accurately
at buggy hardware rather than not working at all for mysterious reasons is
quite nice.  And an increasing number of BIOS vendors and OEMs are testing
with Linux, even if only cursorily, so there is some (slow) feedback.

Whether you actually learn to cope with misrouted interrupts is
a separate issue that I won't raise.
