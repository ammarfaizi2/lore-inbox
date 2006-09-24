Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWIXAFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWIXAFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 20:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWIXAFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 20:05:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31213
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751721AbWIXAFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 20:05:33 -0400
Date: Sat, 23 Sep 2006 17:05:31 -0700 (PDT)
Message-Id: <20060923.170531.104035087.davem@davemloft.net>
To: mikpe@it.uu.se, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, simoneau@ele.uri.edu,
       sparclinux@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
From: David Miller <davem@davemloft.net>
In-Reply-To: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
References: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sat, 23 Sep 2006 00:15:41 +0200 (MEST)

[ Greg, USB bug, synopsis: rh_call_control() needs to declare the
  'tbuf' local variable with correct alignment or else implementations
  of ->hub_control() get unaligned traps because they assume the
  passed-in buffer is at least 4-byte aligned which is not necessarily
  true if tbuf is simply declared as 'u8' as it is now. ]

> On Thu, 21 Sep 2006 13:51:21 -0700 (PDT), David Miller wrote:
> >> I don't think it's harmless. My Ultra5 has an add-on PCI USB controller
> >> card (Belkin). A 2.6.18-rc kernel compiled with gcc-4.1.1 will throw a few
> >> unaligned accesses when I initialise USB by inserting a USB memory stick.
> >> Removing the memory stick then results in PCI errors and other breakage.
> >> 
> >> The same kernel compiled with gcc-3.4.6 has no problems at all, so I've
> >> been assuming it's a gcc-4 issue and not a kernel issue.
> >
> >Compiled with gcc-4.0.x I get the same ehci_hub_control unaligned
> >accesses, and putting the correct {get,put}_unaligned() in that
> >function makes them go away.
> >
> >It's a pure mystery if gcc-3.4.x somehow avoids those, as by the
> >way the code is written those unaligned accesses are to be expected.
> 
> I rechecked with 2.6.18 final, and the behaviour is as I described:
> gcc-4.1.1 causes the alignment exceptions, while gcc-3.4.6 does not.
> I didn't get any PCI errors now, but I'm sure I did get them in the
> 2.6.17 or early 2.6.18-rc kernels.
> 
> Here's a dmesg diff to show what happens, between the gcc-4.1.1
> and gcc-3.4.6 compiled kernels. The first part is from kernel
> bootup + user-space modprobe of the USB EHCI etc modules:

I've determined that it's actually not a compiler bug or problem,
but rather the code in the call chain is buggy.

Gcc-4.x is just optimizing the packing of the on-stack variables more
aggressively, and it is doing so in a legitimate way.

The next to last argument to the ->hub_control() method is a buffer,
and this comes on-stack from rh_call_control().  This 'tbuf'
variable is declared like this:

	u8		tbuf [sizeof (struct usb_hub_descriptor)];

which only guarentees byte alignment.  I've verified in the assembly
on sparc64 that with gcc-4.x 'tbuf' is placed at an odd-byte offet on
the local stack.

Yet the implementations of ->hub_control() derefernce this area as if
it were at least 4-byte aligned, for example in this code snippet in
ehci_hub_control(), which is what is being triggered on sparc64, we
have:

		// we "know" this alignment is good, caller used kmalloc()...
		*((__le32 *) buf) = cpu_to_le32 (status);

That comment is also extremely bogus :-)

My original idea to fix this was to turn "tbuf" into a union comprised
of the byte array and a "struct usb_hub_descriptor" in order to get
the necessary alignment.  That doesn't work because usb_hub_descriptor
is declared as "packed".  So I suggest the following patch to fix this
bug.

Greg, please apply, thanks.

[USB]: Fix alignment of buffer passed down to ->hub_control()

Implementations assume the buffer is at least 4 byte aligned.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index fb4d058..7766d7b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -344,7 +344,8 @@ static int rh_call_control (struct usb_h
 	struct usb_ctrlrequest *cmd;
  	u16		typeReq, wValue, wIndex, wLength;
 	u8		*ubuf = urb->transfer_buffer;
-	u8		tbuf [sizeof (struct usb_hub_descriptor)];
+	u8		tbuf [sizeof (struct usb_hub_descriptor)]
+		__attribute__((aligned(4)));
 	const u8	*bufp = tbuf;
 	int		len = 0;
 	int		patch_wakeup = 0;
