Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUJKEYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUJKEYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUJKEYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:24:54 -0400
Received: from ozlabs.org ([203.10.76.45]:44726 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268682AbUJKEYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:24:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
Date: Mon, 11 Oct 2004 14:24:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>
	<Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
	<16746.299.189583.506818@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> And they are unbroken again (well, at least they work for me again).  
> Partly by the PM_ renumbering under discussion.

Interesting.  I find that with suspend-to-ram, USB keyboards don't
work after resume, and that the system will hang on resume if you
remove a USB device during sleep.

Are you using suspend-to-ram or suspend-to-disk?

> > The problem I have at the moment is that PCI drivers get asked to go
> > to D3 for both suspend-to-ram and suspend-to-disk.  In particular the
> > radeonfb driver wants to do different things in these two cases.
> 
> Hey, I don't disagree. But I pointed out why it's done the way it is done. 
> I even told you what can be done about it - so please argue _those_ points 
> instead of just ignoring them.

OK, how about we pass a struct that contains both the target system
power state and the target device power state?  That would fit in 32
bits.

For now (i.e. 2.6.9), could we have the following patch?  It only
affects suspend-to-disk, and it tells the drivers that we are going to
D3cold (4) when we are doing suspend-to-disk.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/pci/pci-driver.c pmac-2.5/drivers/pci/pci-driver.c
--- linux-2.5/drivers/pci/pci-driver.c	2004-10-04 13:31:01.000000000 +1000
+++ pmac-2.5/drivers/pci/pci-driver.c	2004-10-11 14:15:27.986286792 +1000
@@ -307,7 +307,7 @@
 		[PM_SUSPEND_ON] = 0,
 		[PM_SUSPEND_STANDBY] = 1,
 		[PM_SUSPEND_MEM] = 3,
-		[PM_SUSPEND_DISK] = 3,
+		[PM_SUSPEND_DISK] = 4,
 	};
 
 	if (state >= sizeof(state_conversion) / sizeof(state_conversion[1]))
