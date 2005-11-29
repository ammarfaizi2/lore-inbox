Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVK2Xh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVK2Xh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVK2Xh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:37:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:57051 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751201AbVK2Xh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:37:57 -0500
Date: Tue, 29 Nov 2005 15:37:44 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129233744.GA32316@kroah.com>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <200511292247.09243.rjw@sisk.pl> <200511292342.36228.rjw@sisk.pl> <20051129145328.3e5964a4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129145328.3e5964a4@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 02:53:28PM -0800, Stephen Hemminger wrote:
> On Tue, 29 Nov 2005 23:42:35 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Update:
> > 
> > On Tuesday, 29 of November 2005 22:47, Rafael J. Wysocki wrote:
> > > On Tuesday, 29 of November 2005 05:11, Linus Torvalds wrote:
> > > > 
> > > > I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> > > > diffstats appended.
> > > 
> > > Hangs solid on boot on dual-core Athlon64.  No details yet, but I'm working
> > > on them.  I wonder if anyone else is seeing this.
> > 
> > The problem is caused by the ehci_hcd driver and fixed by the David
> > Brownell's ehci-hang-fix.patch that's already in -mm.
> 
> I assume this is that bug:
> -- 
> [   47.145873] kjournald starting.  Commit interval 5 seconds
> [   47.187797] EXT3-fs: mounted filesystem with ordered data mode.
> [   48.395152] usbcore: registered new driver usbfs
> [   48.433382] usbcore: registered new driver hub
> [   58.733294] NMI Watchdog detected LOCKUP on CPU 1
> [   58.770674] CPU 1 
> [   58.799348] Modules linked in: ehci_hcd i2c_amd8111 i2c_amd756 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc sky2 tg3 usbcore
> [   58.950846] Pid: 2042, comm: modprobe Not tainted 2.6.15-rc3-sky2 #1
> [   58.996375] RIP: 0010:[<ffffffff803c145b>] <ffffffff803c145b>{.text.lock.spinlock+34}
> [   59.022530] RSP: 0018:ffff81007fb39bb0  EFLAGS: 00000086
> [   59.090005] RAX: 0000000000000296 RBX: 0000000000002301 RCX: 0000000000000005
> [   59.138990] RDX: 0000000000000008 RSI: 0000000000002301 RDI: ffff81007cf84554
> [   59.187922] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
> [   59.236698] R10: 0000000000000037 R11: 000000000000000a R12: ffff81007cf84400
> [   59.285266] R13: 0000000000002395 R14: 0000000000000008 R15: ffff81007cf84538
> [   59.333549] FS:  00002aaaaaac53c0(0000) GS:ffffffff805c6880(0000) knlGS:0000000000000000
> [   59.385260] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [   59.429103] CR2: 0000003d49a92660 CR3: 000000007d1c3000 CR4: 00000000000006e0
> [   59.477671] Process modprobe (pid: 2042, threadinfo ffff81007fb38000, task ffff81007c001060)
> [   59.530809] Stack: ffffffff88114d8a ffff810037cae1b0 0000000000000000 0000000000040000 
> [   59.557613]        0000000000004283 0000000000000016 ffffffff8811ac60 ffff810037cae1b0 
> [   59.609531]        0000000000000004 0000000000000002 
> [   59.651373] Call Trace:<ffffffff88114d8a>{:ehci_hcd:ehci_hub_control+90} <ffffffff80257d38>{pci_bus_read_config_word+136}
> [   59.713317]        <ffffffff80257c84>{pci_bus_read_config_byte+116} <ffffffff8811555d>{:ehci_hcd:ehci_port_power+157}
> [   59.775028]        <ffffffff8811590d>{:ehci_hcd:ehci_pci_reinit+909} <ffffffff88117724>{:ehci_hcd:ehci_pci_reset+1156}
> [   59.837778]        <ffffffff8030af1f>{pci_conf1_read+223} <ffffffff88008ee5>{:usbcore:usb_add_hcd+117}
> [   59.896527]        <ffffffff8030a9ce>{pcibios_set_master+30} <ffffffff88012a4d>{:usbcore:usb_hcd_pci_probe+653}
> [   59.958237]        <ffffffff8025c639>{pci_device_probe+89} <ffffffff802b867d>{driver_probe_device+77}
> [   60.017091]        <ffffffff802b8760>{__driver_attach+0} <ffffffff802b87a0>{__driver_attach+64}
> [   60.074566]        <ffffffff802b8760>{__driver_attach+0} <ffffffff802b7a49>{bus_for_each_dev+73}
> [   60.132538]        <ffffffff802b7f80>{bus_add_driver+128} <ffffffff8025c130>{__pci_register_driver+160}
> [   60.192379]        <ffffffff80150a22>{sys_init_module+258} <ffffffff8010dcee>{system_call+126}

I think so.  Can people test the following patch to make sure it fixes
the issue for them, before I send it to Linus?

thanks,

greg k-h
------------------


From: David Brownell <david-b@pacbell.net>
Subject: USB: ehci fixups

Rename the EHCI "reset" routine so it better matches what it does (setup);
and move the one-time data structure setup earlier, before doing anything
that implicitly relies on it having been completed already.

From: David Brownell <david-b@pacbell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/ehci-pci.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/usb/host/ehci-pci.c
+++ gregkh-2.6/drivers/usb/host/ehci-pci.c
@@ -121,8 +121,8 @@ static int ehci_pci_reinit(struct ehci_h
 	return 0;
 }
 
-/* called by khubd or root hub (re)init threads; leaves HC in halt state */
-static int ehci_pci_reset(struct usb_hcd *hcd)
+/* called during probe() after chip reset completes */
+static int ehci_pci_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
@@ -141,6 +141,11 @@ static int ehci_pci_reset(struct usb_hcd
 	if (retval)
 		return retval;
 
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
 	/* NOTE:  only the parts below this line are PCI-specific */
 
 	switch (pdev->vendor) {
@@ -154,7 +159,8 @@ static int ehci_pci_reset(struct usb_hcd
 		/* AMD8111 EHCI doesn't work, according to AMD errata */
 		if (pdev->device == 0x7463) {
 			ehci_info(ehci, "ignoring AMD8111 (errata)\n");
-			return -EIO;
+			retval = -EIO;
+			goto done;
 		}
 		break;
 	case PCI_VENDOR_ID_NVIDIA:
@@ -207,9 +213,8 @@ static int ehci_pci_reset(struct usb_hcd
 	/* REVISIT:  per-port wake capability (PCI 0x62) currently unused */
 
 	retval = ehci_pci_reinit(ehci, pdev);
-
-	/* finish init */
-	return ehci_init(hcd);
+done:
+	return retval;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -344,7 +349,7 @@ static const struct hc_driver ehci_pci_h
 	/*
 	 * basic lifecycle operations
 	 */
-	.reset =		ehci_pci_reset,
+	.reset =		ehci_pci_setup,
 	.start =		ehci_run,
 #ifdef	CONFIG_PM
 	.suspend =		ehci_pci_suspend,
