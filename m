Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266111AbTLIVMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbTLIVMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:12:55 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:26497
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S266111AbTLIVMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:12:53 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 22:12:51 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0312091037070.1033-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312091037070.1033-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092212.51627.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > EIP is at hcd_pci_release+0x19/0x20 [usbcore]

> I don't understand this stack dump.  The EIP address is _after the end_ of
> hcd_pci_release, as you can see from the fact that the following code is
> nothing but a long string of NOPs.

Hi Alan, I'm not sure what you mean.  0x19/0x20 seems to be inside the code
to me :)  On my machine, this is what it corresponds to:

static void hcd_pci_release(struct usb_bus *bus)
{
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 ec 04                sub    $0x4,%esp
        struct usb_hcd *hcd = bus->hcpriv;
   6:   8b 45 08                mov    0x8(%ebp),%eax
   9:   8b 50 30                mov    0x30(%eax),%edx

        if (hcd)
   c:   85 d2                   test   %edx,%edx
   e:   74 0c                   je     1c <hcd_pci_release+0x1c>
                hcd->driver->hcd_free(hcd);
  10:   8b 82 38 01 00 00       mov    0x138(%edx),%eax
  16:   89 14 24                mov    %edx,(%esp,1)
  19:   ff 50 28                call   *0x28(%eax)      <= HERE
}
  1c:   c9                      leave
  1d:   c3                      ret
  1e:   89 f6                   mov    %esi,%esi

So if Vince's disassembly is the same, the problem is that
hcd->driver or hcd->driver->hcd_free is stuffed.

> Also, I don't understand the cause of
> the oops.  What does the PREEMPT mean?  There's no indication that a null
> pointer was dereferenced.  None of the registers contains 0.

I guess PREEMPT means it's a kernel with preempt support.  There is
indeed no indication that a NULL pointer was dereferenced.  Maybe it
is use-after-free.

> But if you think that's the problem, try adding a printk to
> hcd_pci_release to display the values of bus, hcd->driver, and
> hcd->driver->hcd_free.  Knowing which one is NULL ought to help your
> analysis.

I will send Vince a patch.

Ciao,

Duncan.
