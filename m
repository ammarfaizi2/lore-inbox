Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUEFTsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUEFTsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUEFTsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:48:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60805 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262837AbUEFTsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:48:10 -0400
Date: Thu, 6 May 2004 15:50:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Alec H. Peterson" <ahp@hilander.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci_request_regions() failure
In-Reply-To: <85E9D28402CA2A4C4E8093BE@[192.168.0.100]>
Message-ID: <Pine.LNX.4.53.0405061527590.19721@chaos>
References: <01D138A0E5F192A9DBDB9432@[192.168.0.100]>
 <85E9D28402CA2A4C4E8093BE@[192.168.0.100]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Alec H. Peterson wrote:

> Greetings again,
>
> It seems that this is actually an alignment problem.  The region of memory
> that should be used (in this case ec107000-ec108fff) is not 8k aligned.
> Does anybody have any suggestions about how I can force aligned memory
> blocks?
>
> Thanks!
>
> Alec
>

The BIOS should have aligned everything correctly.
0xec108fff - 0xec107000 = 0x1fff (0x2000 bytes)

0xec107000 / 0x2000 = 0x76083, * 0x2000 = 0xec106000
(where it should have been). Check to see if that region is
clear and if it is, write that address to the PCI
BAR. If it isn't, check the next higher address
(ex106000 + 0x2000), etc.

It would be instructional to find out if the bad
address was as a result of the BIOS or Linux re-writing
the BARs because it didn't like them.

Upon startup, the BIOS, knowing where RAM stops, is supposed
to put an address into each BAR based upon the rule
that if it allocates X-bytes of address-space, it must be
X-bytes aligned. Sometimes, where you have all the address-
space used by RAM (4 Gb), the BIOS may be using some
untested buggy software to allocate address-space. You
see, if you have used up all the address-space for RAM,
some of this address space needs to be "overloaded" with
PCI BARs (subtracting from available RAM). Under these
conditions, the buggy BIOS may attempt to allocate "backwards"
with some buggy code.

If you have 4Gb or RAM, just pull one stick and see if that
"fixes" the address problem. If it does, try to find a BIOS
upgrade for your board and, if none is available at least
report the problem.

In any event, you can write any unused, properly aligned,
address to that BAR (then allocate it and remap it).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


