Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVIKQIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVIKQIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVIKQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:08:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964845AbVIKQIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:08:45 -0400
Date: Sun, 11 Sep 2005 09:08:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miguel <frankpoole@terra.es>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PCI bug in 2.6.13
In-Reply-To: <20050911161058.481d1a75.frankpoole@terra.es>
Message-ID: <Pine.LNX.4.58.0509110903050.4912@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
 <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es>
 <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org> <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
 <20050911030814.08cbe74c.frankpoole@terra.es> <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
 <20050911161058.481d1a75.frankpoole@terra.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Miguel wrote:
> 
> After applying this patch I don't see anything new so I have added the
> same WARN_ON in pci_write_config_byte and pci_write_config_word and now
> dmesg shows this:

Thanks. Nobody should ever do a byte write to that offset, but clearly 
something does.

And yes, that's what I missed even though I quoted it from the hpt366
driver (heh, and nobody else noticed either):

        /* FIXME: Not portable */
        if (dev->resource[PCI_ROM_RESOURCE].start)
                pci_write_config_byte(dev, PCI_ROM_ADDRESS,
                        dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);

I wonder how long that has been like that.

Change the pci_write_config_byte() into a pci_write_config_dword(), and I 
bet it works. 

However, I _also_ suspect it works if you remove those lines entirely. I 
don't see why it tries to enable the ROM in the first place - it doesn't 
seem to be _using_ it.

		Linus
