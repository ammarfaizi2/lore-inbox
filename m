Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbVCKPGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbVCKPGW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbVCKPGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:06:22 -0500
Received: from laika.gnusto.com ([207.44.178.75]:53462 "EHLO laika.gnusto.com")
	by vger.kernel.org with ESMTP id S263348AbVCKPGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:06:15 -0500
Message-Id: <200503111506.j2BF6EWh030442@laika.gnusto.com>
To: linux-kernel@vger.kernel.org
From: Ted Phelps <phelps@gnusto.com>
Subject: [PATCH] more reliable system timer for SC1100 CPU
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <30397.1110553142.0@laika.gnusto.com>
Date: Fri, 11 Mar 2005 09:06:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30397.1110553142.1@laika.gnusto.com>

Hello,

The attached patch is an attempt to work around the buggy timestamp
counter on the NatSemi SC1100 CPU by using the on-board 27MHz
high-resolution timer as an alternative time source.  It should,
in theory, work with any of the SCx200 CPUs as well, though I have
been unable to test this.  I have tested it fairly thoroughly with NTP
on an SC1100 and it seems to behave sanely.

That said, there are three things about it that I'm not entirely
comfortable with:

(1) The high-resolution timer is driven by a separate crystal than the
    CPU's timer interrupt, and on the SC1100 I have access to, it's
    consistently slower.  I've found that it is necessary to
    periodically *decrement* the jiffies_64 counter in mark_offset in
    order to make gettimeofday produce anything reasonable.  In
    practice jiffies_64 is incremented again in do_timer before
    anything else reads it, so the net effect is minimal.

(2) The 27MHz timer is accessed via the PCI bus, which is not
    available when the system clock is initialized.  To work around
    this, I've written the init function to always fail so that
    loops_per_jiffy is computed using another timer (the TSC in my
    case).  Once the high-resolution timer is accessible, the kernel
    will switch to using it to compute gettimeofday and the monotonic
    clock, but still use the original timer's delay function.  This
    is somewhat kludgy, but I can't see a cleaner way.

(3) The timer depends on CONFIG_SCx200, which appears later in the
    configuration hierarchy to the timers, and in an entirely
    different part.  For now I've kept its Kconfig with the other
    timers, but I'm not entirely happy with this choice.
    
The patch is against linux-2.6.11-mm2 as it relies on the
'determine-scx200-cb-address-at-run-time.patch' patch which has not
made it into in the mainline.

Please CC me if you reply as I'm not subscribed to LKML.

Cheers,
-Ted


------- =_aaaaaaaaaa0
Content-Type: application/x-gzip
Content-ID: <30397.1110553142.2@laika.gnusto.com>
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="scx200-hr-timer-2.6.11-mm2-5.diff.gz"

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

------- =_aaaaaaaaaa0--
