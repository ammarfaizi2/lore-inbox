Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVCNLwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVCNLwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVCNLwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:52:16 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:29278 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261383AbVCNLwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:52:06 -0500
Message-ID: <42357AE0.4050805@tls.msk.ru>
Date: Mon, 14 Mar 2005 14:52:00 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
References: <4235683E.1020403@tls.msk.ru>
In-Reply-To: <4235683E.1020403@tls.msk.ru>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
[]
> 2.6.10 almost works, but sometimes, the whole input
> subsystem just "hungs", ie, both keyboard and mouse
> just stops working.  Plugging in USB keyboard and
> loading usbhid module solves the problem - both
> keyboards and the mouse works after that, and I
> didn't yet notice the problem repeats after usbhid
> and usb keyboard is loaded.  I wasn't able to
> determine when the problem occurs, for me it seems
> it hangs at some "random" point - sometimes after
> 5 minutes after boot, sometimes after a hour or
> so.

Got another such "hung" and tried to debug it somehow.
Did a task dump (echo t > /proc/sysrq-trigger when logged
from network) -- nothing interesting; kseriod trace looks
a bit weird but it is as weird in normal mode too:

kseriod       S 00000000     0   196      1           361   122 (L-TLB)
c11f9f94 00000046 00000000 00000000 c11f9000 c11f9000 c77d09e0 000024de
        6b1f3a71 00000004 c11f06bc c11f9fc0 c11f9000 c11f9fd4 fffff000 c01c4d4e
        c11f9000 00000000 c11f0560 c0127c20 c11f9fcc c11f9fcc c11f0560 c77c7f60
Call Trace:
  [<c01c4d4e>] serio_thread+0xbe/0x110
  [<c0127c20>] autoremove_wake_function+0x0/0x30
  [<c0102c06>] ret_from_fork+0x6/0x20
  [<c0127c20>] autoremove_wake_function+0x0/0x30
  [<c01c4c90>] serio_thread+0x0/0x110
  [<c0101265>] kernel_thread_helper+0x5/0x10

Everything on the system is sleeping.

After plugging in USB keyboard and loading uhci-hcd and
usbhid, the keyboard un-freeze, but mouse still didn't
work.  So I tried re-loading psmouse module, and
surprizingly, mouse started working again, but now dmesg
says:

  input: PS2++ Logitech Wheel Mouse on isa0060/serio1

(normally it's
  input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
)

and the mouse is moving very fast now.  Previously
I either didn't able to make it work at all after such
freeze, or it worked automatically after loading usbhid.

BTW, it's 2.6.10, I can't made it work with 2.6.11 at all.

/mjt
