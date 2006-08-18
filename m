Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWHRV5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWHRV5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWHRV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:57:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12972 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751503AbWHRV5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:57:51 -0400
Date: Fri, 18 Aug 2006 14:56:44 -0700
From: Greg KH <greg@kroah.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 Spurious ACK/NAK on isa0060/serio0, 2.6.18-rc2 is fine
Message-ID: <20060818215644.GA1893@kroah.com>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060817221052.GA3025@aitel.hist.no> <20060817223434.GA3616@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817223434.GA3616@aitel.hist.no>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 12:34:34AM +0200, Helge Hafting wrote:
> On Fri, Aug 18, 2006 at 12:10:52AM +0200, Helge Hafting wrote:
> > So I tried 2.6.18-rc4-mm1 on my opteron. (Running 64-bit)
> > 
> > The kernel did not boot, but went into an infinite loop of
> > 
> > Spurious ACK on isa0060/serio0
> > over and over.  I have two keyboards, one attached the usual
> > way and another attached where a mouse usually goes.
> > This works fine with 2.6.18-rc2, but no longer now.
> > One keyboard is dead, and on the other, two of the
> > leds blink on and off.
> > 
> > Unplugging a keyboard changes the repeating message to
> > Spurious NAK ... instead.
> > 
> > Unplugging both keyboards stops the nonsense, but then - no keyboard.
> > 
> > This kernel also fails to mount root, a fact that is hard to see as
> > the stupid messages quickly scroll everything else away.
> > That might be something simple like the changed ATA config
> > or multithreaded pci probe.
> > 
> > There just cannot be any program "trying to access hw directly",
> > I don't get the root fs so I don't even have init running.
> >
> I got rid of the multithreaded PCI probe - and the root fs was
> recognised again (I have both SATA and SCSI, perhaps they
> were probed in wrong order)

Are you using the ata_piix driver by chance for your root partition?  If
so, the multi-thread stuff will not work unless you use the hack below.

> Curiously enough, the keyboard trouble went away too.  Odd.
> Now posting from a working 2.6.18-rc4-mm1 (With the jiffies hotfix)

The keyboard stuff is very odd, your keyboard should not be on the PCI
bus :(

thanks,

greg k-h

--------------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver: multi-threaded hacks

 - Fix "issue" with ata_piix doing multi-threaded boot

Use at your own risk.

---
 drivers/scsi/ata_piix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/scsi/ata_piix.c
+++ gregkh-2.6/drivers/scsi/ata_piix.c
@@ -945,7 +945,7 @@ static int __init piix_init(void)
 	if (rc)
 		return rc;
 
-	in_module_init = 0;
+//	in_module_init = 0;  multi-threaded probe doesn't like this...
 
 	DPRINTK("done\n");
 	return 0;
