Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130569AbQK3IeZ>; Thu, 30 Nov 2000 03:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130895AbQK3IeP>; Thu, 30 Nov 2000 03:34:15 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:37897 "EHLO mx1.eskimo.com")
        by vger.kernel.org with ESMTP id <S130569AbQK3IeC>;
        Thu, 30 Nov 2000 03:34:02 -0500
Date: Thu, 30 Nov 2000 00:03:31 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: tulip log (2.2.17-2.2.18pre23 http-induced kernel deadlock)
Message-ID: <Pine.SUN.3.96.1001129234052.24017A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm posting this to the kernel list because I'm still not convinced
that the deadlock results from a problem with a specific ethernet
driver.)

I enabled debuggin in tulip.c with #define TULIP_DEBUG 7 and directed
klogd to save all kernel messages to a file. After initialization
(seems to work, since subsequent large ftp transfers have no problem),
the verbose debugging log from the tulip driver starts out like this:

# nothing happening on the network
Nov 29 12:44:26 turpin kernel: eth0: 21143 negotiation status 000000c6, MII.
Nov 29 12:44:26 turpin kernel: eth0: MII status 782d, Link partner report 4481.
Nov 29 12:46:26 turpin kernel: klogd 1.4-0, log source = /proc/kmsg started.
Nov 29 12:46:26 turpin kernel: eth0: 21143 negotiation status 000000c6, MII.
Nov 29 12:46:26 turpin kernel: eth0: MII status 782d, Link partner report 4481.
Nov 29 12:47:26 turpin kernel: eth0: 21143 negotiation status 000000c6, MII.
Nov 29 12:47:26 turpin kernel: eth0: MII status 782d, Link partner report 4481.
Nov 29 12:48:26 turpin kernel: eth0: 21143 negotiation status 000000c6, MII.
Nov 29 12:48:26 turpin kernel: eth0: MII status 782d, Link partner report 4481.
Nov 29 12:49:26 turpin kernel: eth0: 21143 negotiation status 000000c6, MII.
Nov 29 12:49:26 turpin kernel: eth0: MII status 7829, Link partner report 4481.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0670040 new csr5=0xf0660000.
# a connect request
Nov 29 12:49:53 turpin kernel:  In tulip_rx(), entry 0 00400720.
Nov 29 12:49:53 turpin kernel: eth0: In tulip_rx(), entry 0 00400720.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0660000 new csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel: eth0: exiting interrupt, csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0670004 new csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0670040 new csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel:  In tulip_rx(), entry 1 00420320.
Nov 29 12:49:53 turpin kernel: eth0: In tulip_rx(), entry 1 00420320.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0660000 new csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel: eth0: exiting interrupt, csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0670004 new csr5=0xf0660000.
Nov 29 12:49:53 turpin kernel: eth0: interrupt  csr5=0xf0670040 new csr5=0xf0660000.

So I get 500k of that, and the log ends like this after the kernel
deadlock:

Nov 29 12:54:29 turpin kernel:  In tulip_rx(), entry 27 00400320.
Nov 29 12:54:29 turpin kernel: eth0: In tulip_rx(), entry 27 00400320.
Nov 29 12:54:29 turpin kernel: eth0: interrupt  csr5=0xf0660000 new csr5=0xf0660000.
Nov 29 12:54:29 turpin kernel: eth0: exiting interrupt, csr5=0xf0660000.
Nov 29 12:54:29 turpin kernel: eth0: interrupt  csr5=0xf0670040 new csr5=0xf0660000.
Nov 29 12:54:29 turpin kernel:  In tulip_rx(), entry 28 00400320.

It simply stops (because the kernel stopped). In that 500k of reporting
interrupts and anything else of interest, there are no "... error ...",
no "... warning ...", no "... stopped ...", no ring buffer address
mismatches, no reconfigurations, no "interrupt called from interrupt
handler", nothing beyond routine interrupt service reports.

Whatever the problem is, tulip.c doesn't notice it in full debug mode.

(Think about it: the changes between the working .90 in 2.0.38 and
provisionally suspect .91g in 2.2.15+ with respect to a DS21143 are
miniscule, while the changes to the rest of the device, networking, and
network-related vm layer between 2.0.38 and 2.2.17-2.2.18pre23 are
gigantic. What would you suspect? An overlooked lock that needs to be
there? You bet. It could be a lock that the 2.2.x tulip driver needs to
set and does not, but that is not a given, and if so it is odd that the
maintainer and the people that have hacked the tulip driver to do
experimental hardware flow control, etc, haven't noticed it by now.)

imho,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
