Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265272AbTLHBYU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 20:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTLHBYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 20:24:20 -0500
Received: from mid-2.inet.it ([213.92.5.19]:1167 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S265272AbTLHBYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 20:24:16 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Greg KH <greg@kroah.com>,
       "Jonathan A. Zdziarski" <jonathan@nuclearelephant.com>
Subject: Re: 2.6 Test 11 Freeze on USB Disconnect
Date: Mon, 8 Dec 2003 02:23:54 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1070825737.2978.7.camel@tantor.nuclearelephant.com> <20031208004742.GB23644@kroah.com>
In-Reply-To: <20031208004742.GB23644@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200312080223.54285.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 01:47, lunedì 08 dicembre 2003, Greg KH ha scritto:
> On Sun, Dec 07, 2003 at 02:35:38PM -0500, Jonathan A. Zdziarski wrote:
> > Greetings,
> >
> > I recently upgraded from 2.4.20-24 to 2.6 Test 11 using a Redhat
> > distribution.  Got everything up and running great, except the entire
> > system appears to freeze (requiring a hardware reset) when I disconnect
> > my bluetooth device.
>
> Is there any way you can see if an oops happened?  Without that it will
> be pretty hard to debug this.

This seems the very same problem that I've got some time ago with test9 and 
never fixed (AFAIK). I'll bet that the SCO support is active.

I've captured with serial console the oops and posted here. This is the Oops 
that happens when I disconnect my USB dongle. (the crash happens only if user 
side processes have been launched, like hcid).

I've got several of them, they differs in EIP and process, but the first item 
in call trace is always [<f897c4b9>] uhci_irq+0x67/0x1ca [uhci_hcd]

Unable to handle kernel paging request at virtual address 80000234
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<f897c3ed>]    Tainted: P
EFLAGS: 00010046
EIP is at uhci_remove_pending_qhs+0x95/0xfa [uhci_hcd]
eax: 80000234   ebx: 00000093   ecx: 80000200   edx: f55aca24
esi: f74d4e0c   edi: f6024000   ebp: f74d4e18   esp: f6025e5c
ds: 007b   es: 007b   ss: 0068
Process hcid (pid: 2434, threadinfo=f6024000 task=f4c25310)
Stack: 00000296 f74d4e0c f74d4c00 00000000 f74d4c00 0000c000 f6025ef8 f897c4b9
       f74d4c00 00000000 f6921780 f74d4c00 00000001 00000000 f6025ef8 c02b9b4e
       f74d4c00 f6025ef8 f7d53c80 04000001 c010b617 00000013 f74d4c00 f6025ef8
Call Trace:
 [<f897c4b9>] uhci_irq+0x67/0x1ca [uhci_hcd]
 [<c02b9b4e>] usb_hcd_irq+0x36/0x5f
 [<c010b617>] handle_IRQ_event+0x3a/0x64
 [<c010b9d8>] do_IRQ+0xb8/0x196
 [<c0109d20>] common_interrupt+0x18/0x20
 [<f8a0e7e1>] hci_sock_release+0x126/0x23e [bluetooth]
 [<c02cd132>] sock_close+0x0/0x4d
 [<c02cc7c4>] sock_release+0x9d/0xfc
 [<c02cd132>] sock_close+0x0/0x4d
 [<c02cd165>] sock_close+0x33/0x4d
 [<c015c957>] __fput+0x12c/0x165
 [<c015ad89>] filp_close+0x59/0x96
 [<c015ae45>] sys_close+0x7f/0xdd
 [<c01093b3>] syscall_call+0x7/0xb

Code: 89 69 34 89 45 04 89 02 89 50 04 8b 54 24 08 c6 82 14 02 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

I've also noticed something strange in hci_usb.c:when the dongle is inserted, 
I get this message on kernel log (BT debug active): (test9-bk24)

Nov 25 21:16:02 kefk kernel: hci_usb_intr_rx_submit: hci0
Nov 25 21:16:02 kefk kernel: hci_usb_bulk_rx_submit: hci0 urb f28f1614
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: len 490 mtu 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 0 offset 0 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 1 offset 49 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 2 offset 98 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 3 offset 147 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 4 offset 196 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 5 offset 245 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 6 offset 294 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 7 offset 343 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 8 offset 392 len 49
Nov 25 21:16:02 kefk kernel: __fill_isoc_desc: desc 9 offset 441 len 49
Nov 25 21:16:02 kefk kernel: hci_usb_isoc_rx_submit: hci0 urb f567e414
Nov 25 21:16:02 kefk kernel: hci_usb_isoc_rx_submit: hci0 isoc rx submit 
failed urb f567e414 err -22
Nov 25 21:16:02 kefk kernel: __hci_request: hci0 start

the interesting message seems to be this:
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb f567e414 err -22
i've checked and it seems that usb_submit_urb: fails here (line 340 of 
hci_usb.c):

        switch (temp) {
        case PIPE_ISOCHRONOUS:
        case PIPE_INTERRUPT:
                /* too small? */
                if (urb->interval <= 0)
                        return -EINVAL;

maybe urb->interval is not set from calling code:
static int hci_usb_isoc_rx_submit(struct hci_usb *husb)
(line 236 of ./drivers/bluetooth/hci_usb.c)
but i don't know if this can cause harm.

If more information or test are needed, please let me know.

Hope This Helps..

Best regards.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

