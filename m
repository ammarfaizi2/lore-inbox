Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSGMNYC>; Sat, 13 Jul 2002 09:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSGMNYB>; Sat, 13 Jul 2002 09:24:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24302 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312938AbSGMNYB>; Sat, 13 Jul 2002 09:24:01 -0400
Subject: Re: Removal of pci_find_* in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Matt_Domsch@Dell.com, greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <3D2FAF94.7070100@mandrakesoft.com>
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com> 
	<3D2FAF94.7070100@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 15:35:39 +0100
Message-Id: <1026570939.9958.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 05:41, Jeff Garzik wrote:
> ordering, is simply hard-coding something that should really be in 
> userspace.  Depending on pci_find_device logic / link order to 
> still-boot-the-system after adding new hardware sounds like an 
> incredibly fragile hope, not a reliable system users can trust.

For hot plugging obvious. At system boot time however the ordering and
seeing the ordering is rather important because in many cases the
ordering is what tells you about things like IDE controller pairing. It
tells you what order to assign many scsi devices because the ordering is
defined by their BIOS ROM.

One way to handle this generically would be to use pci_register_device,
but in the register function for such wacky devices during boot up we
merely keep track of what we have to look into. 

That requires a way for drivers to register an init function that will
be called after the boot time PCI device registration is done. At that
point its as easy as

	Register
	Collect list of devices

[Kernel does pci enumerations]

	Sort list in BIOS specific ordering
	Feed list to registration code
	Flip registration function pointer to be the immediate register
	handler

[Watch all the glue vanish into __init oblivion]

Which seems preferable to keeping the old API around for registrations,
although its still used for probing for things (which has locking
concerns). Refcounting pci_ might sort those out

