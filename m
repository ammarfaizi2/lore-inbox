Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUJRWsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUJRWsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUJRWs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:48:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:3601 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S267679AbUJRWsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:48:06 -0400
Date: Mon, 18 Oct 2004 18:48:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Nils Rennebarth <Nils.Rennebarth@web.de>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Fw: X is killed when trying to suspend with
 USB Mouse plugged in
In-Reply-To: <20041018142745.60208c5b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0410181842000.16460-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Andrew Morton wrote:

> Begin forwarded message:
> 
> Date: Mon, 18 Oct 2004 20:55:16 +0200
> From: Nils Rennebarth <Nils.Rennebarth@web.de>
> To: linux-kernel@vger.kernel.org
> Cc: Suspend development list <softwaresuspend-devel@lists.berlios.de>
> Subject: X is killed when trying to suspend with USB Mouse plugged in
> 
> 
> Hi,
> 
> When I try to suspend 2.6.9-rc[1-4] when X is runnning and my USB Mouse 
> is plugged in, I get an Ooops. X is killed and the suspend as well.
> 
> Attached is the oops with 2.6.9-rc4
> The oops comes at the moment, that uhci_hcd is removed. If I do not 
> remove that module, suspend does work but the laptop hangs hard during 
> resume.
> 
> That only happens if I use /dev/input/mouse1 as input device for the 
> mouse. With /dev/input/mice I can suspend and resume successfully.
> 
> So is using /dev/input/mouse1 something I shouldn't have done in the 
> first place (came from some experimentation when trying to use the 
> synaptics driver for my alps touchpad) or does it point to a bug in the 
> uhci driver? Or a bug in X?

I don't know about /dev/input/mouse1.  But the oops isn't a bug... it's a 
weakness in the way Linux implements loadable kernel modules.

What your log showed was that some program was still using a USB device at
the time uhci-hcd was unloaded.  There's nothing illegal or wrong about
that, but the unload procedure doesn't wait for the reference count to
drop to zero -- the module is unloaded from memory right away.  Then some
time later on, when that other program finished using the device and the
reference count did go to zero, the system tried to call a release routine
in the unloaded module.  The result was an oops, as you saw.

Alan Stern


