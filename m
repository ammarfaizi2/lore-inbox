Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUIKSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUIKSzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268284AbUIKSzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:55:35 -0400
Received: from scrye.com ([216.17.180.1]:50859 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S268283AbUIKSzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:55:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Sep 2004 12:55:12 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: FYI: my current bigdiff
X-Draft-From: ("scrye.linux.kernel" 66891)
References: <20040909134421.GA12204@elf.ucw.cz>
	<20040910041320.DF700E7504@voldemort.scrye.com>
	<200409101646.01558.bjorn.helgaas@hp.com> <41432AD4.2090003@suse.de>
Message-Id: <20040911185514.D4C524E016@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Stefan" == Stefan Seyfried <seife@suse.de> writes:

Stefan> Bjorn Helgaas wrote:

>> I'm completely ignorant about how swsusp works; I guess this is my
>> chance to learn.  "pci=routeirq" just causes us to do all the PCI
>> ACPI IRQ routing at boot-time, before the drivers start up.  This
>> happens in pci_acpi_init(), which is a subsys_initcall that is run
>> at initial boot-time, but (I assume) not during a resume.

Stefan> a resume is basically a fresh boot, including hardware
Stefan> initialization by the compiled-in drivers (but not modules)
Stefan> but before starting init / entering initrd, the old system
Stefan> state is read from swap, copied back and somehow we continue
Stefan> where we left off at suspend time. Now the resume methods of
Stefan> all device drivers are called, processes are restarted and we
Stefan> are back in the game. (At least this is how i understood it
Stefan> all :-)

Stefan> I can easily imagine that a driver with a slightly broken
Stefan> suspend / resume method may fail without pci=routeirq if it
Stefan> does not do the irq routing correctly during resume. It may
Stefan> work with pci=routeirq since then everything is prepared for
Stefan> it before the resume actually happens.

Yeah, that seems to be the case... the prism54 and usb-hcd drivers
might expect the irq to already be allocated, and when it's not on
resume they freak out. 

Stefan> Kevin may get away with unloading the usb host controller and
Stefan> the prism54 drivers before suspend and reloading them after
Stefan> resume.

alas, no. 

Unloading and reloading doesn't help. 
It looks like they don't re-allocate their irq resources on reload, so
they freak out. 

See the dmesg output I just posted showing the issue. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBQ0oS3imCezTjY0ERAsMoAJ0dtIycXmMd82WZNMNlHzbDj8/mDwCbBALz
USBJwZfMKB9W+GA3sVZQHgk=
=j0ZJ
-----END PGP SIGNATURE-----
