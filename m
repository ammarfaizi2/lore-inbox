Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRAaKRb>; Wed, 31 Jan 2001 05:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAaKRV>; Wed, 31 Jan 2001 05:17:21 -0500
Received: from [195.71.115.196] ([195.71.115.196]:2851 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129274AbRAaKRL>; Wed, 31 Jan 2001 05:17:11 -0500
Date: Wed, 31 Jan 2001 11:18:26 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Robert Siemer <siemer@panorama.hadiko.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0 (updated patch)
In-Reply-To: <20010130020746C.siemer@panorama.hadiko.de>
Message-ID: <Pine.LNX.4.21.0101310119420.2065-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Robert Siemer wrote:

> > Below is the updated patch. It should handle both (0x01/0x41
> > like) mappings. I can (and did) only test the 0x01 case.
> > USBIRQ routing (0x62) supported, IDE/ACPI/DAQ untouched.
> 
> I don't really understand your note above, but your patch alone does
> not fix my problem. - Linus diff over pci-irq.c does.

Yes, I know - in fact it couldn't, because your BIOS' irq routing is not
only subject to the 0x01/0x41 ambiguity but also wrong wrt. to the USBIRQ,
which gets routed using link value 0x62 in any other case but yours.

Your routing table is:

00:0c slot=01 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:04/1eb8
00:0b slot=02 0:02/1eb8 1:03/1eb8 2:04/1eb8 3:01/1eb8
00:0a slot=03 0:03/1eb8 1:04/1eb8 2:01/1eb8 3:02/1eb8
00:09 slot=04 0:04/1eb8 1:01/1eb8 2:02/1eb8 3:03/1eb8
00:01 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:04/1eb8 >>> no 0x62 here!
00:13 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:04/1eb8

suggesting the ISA-bridge (00:01) would be routed exactly like a normal
PCI device, namely your SCSI-HA in slot 1. Since the ISA-bridge provides
both IDE und USB function and they pretend to use pin A, all the kernel
can do is believe the BIOS and so these 3 devices end up unseparable from
each other on link/pirq 0x01 - which we assign to some IRQ when needed.
Your USB however *is* already routed by the BIOS to IRQ 9 using link/pirq
value 0x62, which makes the BIOS provided routing table really crap:

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
60: ff 80 49 00 88 00 00 02 00 80 80 00 20 19 00 00
          ^^
Linus' patch helps you, because it makes us trusting the device's config
space over the routing table. Probably a good idea as long as BIOS'es
wouldn't start to set wrong values in config space too...

So, unless you get a working BIOS update there is no way to get it right.

Another solution might be to put your NIC into slot 1 and configure your
BIOS to share the NIC's IRQ with USB. This way you would set up the
system exactly the same way, your BIOS is cheating the kernel.

> The kernel still does not think what the bios states; it's like the
> vanilla 2.4.0 in this regard. (--> on my box: kernel panic after

in fact vanilla 2.4.0 did believe what the bios states, namely the broken
routing table. It didn't believe however what the devices config space
reports - which turned out to be correct.

You should be happy with 2.4.1 which contains both Linus' and the
0x01/0x41 fix.

Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
