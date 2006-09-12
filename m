Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWILRXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWILRXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWILRXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:23:42 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:3203 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S965037AbWILRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:23:41 -0400
Date: Tue, 12 Sep 2006 19:22:11 +0200
From: Mattia Dongili <malattia@linux.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
Message-ID: <20060912172211.GB6226@inferi.kami.home>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609120008.19714.rjw@sisk.pl> <Pine.LNX.4.44L0.0609121007530.6338-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609121007530.6338-100000@iolanthe.rowland.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 10:28:27AM -0400, Alan Stern wrote:
> On Tue, 12 Sep 2006, Rafael J. Wysocki wrote:
> 
> > Now I have another symtom: during the _second_ suspend the suspending of
> > USB controllers fails with messages like this:
> > 
> > usb_hcd_pci_suspend(): ehci_pci_suspend+0x0/0xab [ehci_hcd]() returns -22
> > pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x16d [usbcore]() returns -22
> > suspend_device(): pci_device_suspend+0x0/0x4b() returns -22
> > Could not suspend device 0000:00:13.2: error -22
> > 
> > Could you please tell me which patches might have caused this, in your opinion?

oh great, I was going to report (almost) the same for S3:

[  224.436000] uhci_hcd 0000:00:1d.2: Root hub isn't suspended!
[  224.436000] usb_hcd_pci_suspend(): uhci_suspend+0x0/0xe0 [uhci_hcd]() returns -16
[  224.436000] pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x1a0 [usbcore]() returns -16
[  224.436000] suspend_device(): pci_device_suspend+0x0/0x70() returns -16
[  224.436000] Could not suspend device 0000:00:1d.2: error -16

I'd also add that the 3rd attempt at suspending will simply hang with
powered down monitor but sysrq is still available.

> It's a little difficult to pin down the blame.  In one form or another
> this problem probably existed all along, although it may not have been 
> very obvious.
> 
> For those interested in the explanation:
> 
> The EHCI USB controller is represented in sysfs by two device structures.  
> The higher one represents the controller's PCI interface (let's call it
> the "PCI-controller") and the lower one represents the USB interface
> (let's call it the "root hub").  Inside the resume() routine for the
> PCI-controller, if the driver finds that power was lost during the suspend
> -- as it would be for suspend-to-disk -- the driver reinitializes the root
> hub but without telling usbcore it has done so.  If the root hub had
> already been suspended at the time of the suspend-to-disk, then
> resume-from-disk would skip calling its resume() method.  So as far as 
> usbcore knows the root hub should still be suspended, but in fact it is 
> awake.
> 
> Consequently during the second suspend-to-disk, usbcore does not pass the
> suspend() call on to the root hub's driver.  Then the suspend() method for
> the PCI-controller fails, because it sees that the child root hub is still
> unsuspended.

I assume this is still true for suspend-to-ram :)
Maybe this is related, I'd like to add also that with previous kernels
(all the 2.6.17*-mm serie until 2.6.18-rc5-mm1) after the first resume I
get those annoying "resets":

[73060.848000] usb 1-2: reset low speed USB device using uhci_hcd and address 3
[73128.332000] usb 1-2: reset low speed USB device using uhci_hcd and address 3
[73586.392000] usb 1-2: reset low speed USB device using uhci_hcd and address 3
[73944.592000] usb 1-2: reset low speed USB device using uhci_hcd and address 3

when the device is reset while typing the char being typed is repeated 4
times. Suspending and resuming again seems to fix that.
Oh, here it is:
Bus 002 Device 001: ID 0000:0000  
Bus 003 Device 003: ID 054c:0056 Sony Corp. 
Bus 003 Device 001: ID 0000:0000  
Bus 001 Device 003: ID 046d:c001 Logitech, Inc. N48/M-BB48 [FirstMouse Plus]
Bus 001 Device 001: ID 0000:0000  

> I was just going to send in a patch to fix the problem.  I haven't had
> much of a chance to try it out yet.  The patch is included below, so you
> can test it right away and let me know if it works for you before I submit 
> it.

going to reboot to test it, hold on.

-- 
mattia
:wq!
