Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUAGEHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 23:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUAGEHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 23:07:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:63961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266124AbUAGEHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 23:07:12 -0500
Date: Tue, 6 Jan 2004 20:06:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Belay <ambx1@neo.rr.com>
cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040106222959.GA3188@neo.rr.com>
Message-ID: <Pine.LNX.4.58.0401062000490.12602@home.osdl.org>
References: <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
 <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
 <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
 <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de>
 <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Adam Belay wrote:
>
> 5.) Look into other ways of finding out if the PnPBIOS might be buggy,
> currently we only have DMI.
> 
> Any others?

We could use the exception mechanism, and try to fix up any BIOS errors. 
That would require:

 - make the BIOS calls save all important registers just before entry (esp 
   in particular, and the "after-call EIP") and set a flag saying "fix me 
   up". Do this per-CPU. Clear the flags after exit.

 - add magic knowledge to "fixup_exception()" path that looks at the 
   per-cpu fix-me-up flag, and if it is set, restore all the segments 
   (which the BIOS may have crapped on), %esp and %eip to the magic fixup 
   values.

 - test it with a bogus trap (on purpose) which has reset all the x86 
   registers, including an offset %esp.

This could make us recover from some (most?) BIOS bugs and at least 
dynamically notice when the BIOS does bad bad things.

		Linus
