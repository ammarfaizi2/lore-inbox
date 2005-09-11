Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVIKIwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVIKIwv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVIKIwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:52:51 -0400
Received: from styx.suse.cz ([82.119.242.94]:22987 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932453AbVIKIwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:52:50 -0400
Date: Sun, 11 Sep 2005 10:53:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miguel <frankpoole@terra.es>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI bug in 2.6.13
Message-ID: <20050911085312.GA13732@midnight.suse.cz>
References: <20050909180405.3e356c2a.frankpoole@terra.es> <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es> <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org> <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org> <20050911030814.08cbe74c.frankpoole@terra.es> <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
X-Bounce-Cookie: It's a lemmon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 06:41:01PM -0700, Linus Torvalds wrote:

> It looks like your HPT controller.
> 
> 	 00:0b.0 Mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372/372N (rev 04)
> 	 ...
> 	-30: 01 00 00 40 60 00 00 00 00 00 00 00 0b 01 08 08
> 	+30: 01 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08
> 
> That's a _really_ bad value. It's "enabled" (low bit set) but at address 
> zero in the bad case. 
> 
> My problem is that I don't see what writes that invalid enable bit. The 
> patch that broke things for you explicitly avoids writing any value at 
> _all_, much less one with the rom enabled bit set (in fact, if the enabled 
> bit had been set, the patch wouldn't have made any difference at all for 
> you).
> 
> The HPT driver does some strange things:
> 
>         /* FIXME: Not portable */
>         if (dev->resource[PCI_ROM_RESOURCE].start)
>                 pci_write_config_byte(dev, PCI_ROM_ADDRESS,
>                         dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> 
> but that one too _explicitly_ only does so for non-zero resource start
> values. But something clearly wrote 00000001 to your ROM address..

This is interesting. The 0x00000001 means that it's supposed to be an
unassigned I/O (!) space resource ... which obviously fools the if()
statement.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
