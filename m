Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282993AbRK0X4y>; Tue, 27 Nov 2001 18:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282984AbRK0X4p>; Tue, 27 Nov 2001 18:56:45 -0500
Received: from air-1.osdl.org ([65.201.151.5]:13830 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S282993AbRK0X4b>;
	Tue, 27 Nov 2001 18:56:31 -0500
Message-ID: <3C042785.211C76BE@osdl.org>
Date: Tue, 27 Nov 2001 15:53:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luben Tuikov <ltuikov@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.16, usb/HID stuff
In-Reply-To: <20011127233958.33562.qmail@web12808.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------669949F938119C7199A0D87C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------669949F938119C7199A0D87C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Luben Tuikov wrote:
> 
> 2.4.16, kgcc (gcc version egcs-2.91.66 19990314/Linux
> (egcs-1.1.2 release)), dell dimension 8100, HID(usb) mouse
> and kbd.
> 
> Could it be that hid is invalid in hid-core.c:1231?
> 
> Here is the relevant info:
> ----cut-here-----
> hub.c: USB new device connect on bus1/1, assigned device
> number 2
> hub.c: USB hub found
> hub.c: 3 ports detected
> hub.c: USB new device connect on bus1/2, assigned device
> number 3
> input0: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse
> M-BA47] on usb1:3.0
> hub.c: USB new device connect on bus1/1/1, assigned device
> number 4
> input1: USB HID v1.00 Keyboard [NMB Dell USB 7HK Keyboard]
> on usb1:4.0
> input2<1>Unable to handle kernel paging request at virtual
> address ffffffff
>  printing eip:
> c02bba40
> *pde = 00001063
> *pte = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c02bba40>]    Not tainted
> EFLAGS: 00010097
> eax: ffffffff   ebx: ffffffff   ecx: ffffffff   edx:
> fffffffe
> esi: c03986d0   edi: ffffffff   ebp: 00000000   esp:
> dfe83e6c
> ds: 0018   es: 0018   ss: 0018
> Process khubd (pid: 10, stackpage=dfe83000)
> Stack: 00000000 dfbd2000 00000246 00000002 c0307354
> 00002392 00000246 0000238c
>        00002392 c01163bb 0000238c 00002392 0000004e
> 00000000 c0398abf 0000000a
>        c0116563 c03986c0 00000400 c0307354 dfe83ee4
> 00000000 dfbd2000 ffffffff
> Call Trace: [<c01163bb>] [<c0116563>] [<c024660b>]
> [<c02387e5>] [<c02388c9>]
>    [<c023a78c>] [<c023bc60>] [<c023be00>] [<c023bfb5>]
> [<c0105000>] [<c01056a3>]
> 
> Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 c7 f7 c5
> 10 00
> ----cut-here-----

Hi-

What kinds of hid devices do you have?
Can you post 'lsusb' output (from usb.in.tum.de/download/usbutils/
if you don't already have it)?

I suspect that the hid_types array index is invalid, but you
could be right -- maybe the hid ptr is invalid.

Please try the attached patch and let us know if it helps/works.

Since I was just looking at this, I am familiar with this oops.
However, normally you should run Oops messages thru ksymoops
so that we can read them. :)

~Randy
--------------669949F938119C7199A0D87C
Content-Type: text/plain; charset=us-ascii;
 name="hid-safe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hid-safe.patch"

--- linux/drivers/usb/hid-core.c.org	Sun Sep 16 11:07:43 2001
+++ linux/drivers/usb/hid-core.c	Tue Nov 27 15:30:12 2001
@@ -1237,7 +1237,8 @@
 	c = "Device";
 	for (i = 0; i < hid->maxapplication; i++)
 		if (IS_INPUT_APPLICATION(hid->application[i])) {
-			c = hid_types[hid->application[i] & 0xffff];
+			if ((hid->application[i] & 0xffff) < ARRAY_SIZE(hid_types))
+				c = hid_types[hid->application[i] & 0xffff];
 			break;
 		}
 

--------------669949F938119C7199A0D87C--

