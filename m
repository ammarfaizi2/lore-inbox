Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTLIV6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTLIV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:58:24 -0500
Received: from ida.rowland.org ([192.131.102.52]:32516 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262251AbTLIV6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:58:22 -0500
Date: Tue, 9 Dec 2003 16:58:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312092212.51627.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Duncan Sands wrote:

> > > EIP is at hcd_pci_release+0x19/0x20 [usbcore]
> 
> > I don't understand this stack dump.  The EIP address is _after the end_ of
> > hcd_pci_release, as you can see from the fact that the following code is
> > nothing but a long string of NOPs.
> 
> Hi Alan, I'm not sure what you mean.  0x19/0x20 seems to be inside the code
> to me :)  On my machine, this is what it corresponds to:
> 
> static void hcd_pci_release(struct usb_bus *bus)
> {
>    0:   55                      push   %ebp
>    1:   89 e5                   mov    %esp,%ebp
>    3:   83 ec 04                sub    $0x4,%esp
>         struct usb_hcd *hcd = bus->hcpriv;
>    6:   8b 45 08                mov    0x8(%ebp),%eax
>    9:   8b 50 30                mov    0x30(%eax),%edx
> 
>         if (hcd)
>    c:   85 d2                   test   %edx,%edx
>    e:   74 0c                   je     1c <hcd_pci_release+0x1c>
>                 hcd->driver->hcd_free(hcd);
>   10:   8b 82 38 01 00 00       mov    0x138(%edx),%eax
>   16:   89 14 24                mov    %edx,(%esp,1)
>   19:   ff 50 28                call   *0x28(%eax)      <= HERE
> }
>   1c:   c9                      leave
>   1d:   c3                      ret
>   1e:   89 f6                   mov    %esi,%esi
> 
> So if Vince's disassembly is the same, the problem is that
> hcd->driver or hcd->driver->hcd_free is stuffed.

Clearly that compiler is different from mine.  On my machine the "ret"  
opcode is at offset 0x16, not 0x1d.  Also, I guess the display of the code
bytes in stack dumps got changed at some point; now it shows values both
before and after the EIP location (it used to show just the values after
EIP).  Okay, that clears that up.

The oops occurring where it did means that hcd->driver->hcd_free is not a
valid function pointer, even though hcd->driver appears to point to actual
data.  So it's not a data access through a null pointer; it's a call to an
unmapped (possibly null) location.

It's not at all clear how that could happen.  Those pointers are located
in static data in the HCD modules.  It doesn't seem likely that the
pointer was overwritten.  The only other possibility I can think of is
that the module was already unloaded.  But that's not possible since you
were holding a reference to a device on that bus.

Maybe the answer is that hcd->driver is messed up but for some reason 
still points to actual data.  I can't imagine why that would happen 
either.

Alan Stern

