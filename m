Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVACIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVACIcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVACIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:32:10 -0500
Received: from orb.pobox.com ([207.8.226.5]:58314 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261286AbVACIcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:32:04 -0500
Date: Mon, 3 Jan 2005 00:31:55 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: lindqvist@netstar.se, pavel@ucw.cz, edi@gmx.de, john@hjsoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050103083154.GA4460@ip68-4-98-123.oc.oc.cox.net>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:10:18PM -0800, Barry K. Nathan wrote:
> So, I think this bug probably lies in ACPI or swsusp. I highly *highly*
> doubt it's driver bugs. Hopefully I'll have time later tonight or
> tomorrow morning to see if I can figure anything else out...

The following patch is a ridiculously dirty kludge which (very arguably)
improves the situation somewhat:

--- linux-2.6.10-bk4/arch/i386/kernel/mpparse.c	2004-12-14 03:17:21.723010806 -0800
+++ linux-2.6.10-bk4-bkn1/arch/i386/kernel/mpparse.c	2005-01-02 23:43:13.647613575 -0800
@@ -1091,9 +1091,10 @@
 		return gsi;
 	}
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
-		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
+		printk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return gsi;
+		/* return gsi; */
+		printk(KERN_DEBUG "However, I will reprogram it anyway.\n");
 	}
 
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);


With this patch, unloading and reloading 8139too will make it work again
after a resume -- as long as I boot *without* "noapic". This doesn't fix
the actual problem (it's still broken after resume, and reloading the
module still doesn't work for "noapic") but it might provide clues.

More specifically, this shows that the 
mp_ioapic_routing[ioapic].pin_programmed[] array is inconsistent with
the IO-APIC's real configuration after the resume.

I think the reason that "pci=routeirq" works is that, with that option,
the kernel sets up everything on the IO-APIC early in bootup and leaves
nothing to be done later on -- that way, the IO-APIC ends up having the
same setup after the resume that it did at suspend time. At leas, that's
what I suspect; I don't think I've proven it yet. I wouldn't be
surprised if a similar phenomenon is happening with acpi=off.

Anyway, I'm going to keep working on this and see if I can figure it out
some more...

-Barry K. Nathan <barryn@pobox.com>

