Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTAHQuV>; Wed, 8 Jan 2003 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTAHQuU>; Wed, 8 Jan 2003 11:50:20 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:26377 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267602AbTAHQuT>; Wed, 8 Jan 2003 11:50:19 -0500
Date: Wed, 8 Jan 2003 19:55:32 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@cup.hp.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030108195532.B15896@jurassic.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 07, 2003 at 09:44:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 09:44:53AM -0800, Linus Torvalds wrote:
> Because of legacy USB handling by the SMM BIOS, USB really ends up being a
> special case. There may be other special cases, of course, but the whole 
> point of the fixups is exactly to handle special cases.

Ok, the 2-pass thing is almost done, seems to work on my
alpha and i386 boxes.

Now I have in pci_read_bases():

	if (dev->skip_probe)
		return;

	/* Disable I/O & memory decoding while we size the BARs. */
	pci_read_config_word(dev, PCI_COMMAND, &cmd);
	pci_write_config_word(dev, PCI_COMMAND,
			      cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));

	for(pos=0; pos<howmany; pos = next) {
	...

The "skip_probe" (single-bit field) can be set in the phase #1.
It's intended for stuff like pmac combo I/O ASIC, which probably
shouldn't be disabled even for a short time.

If it looks ok, I'll have a complete patch tomorrow, including
updates for all architectures and hotplug drivers.

Ivan.
