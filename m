Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbTFVSDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbTFVSDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:03:42 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:11017
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S264843AbTFVSDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:03:41 -0400
Date: Sun, 22 Jun 2003 20:17:42 +0200
From: Santiago Garcia Mantinan <lkml@manty.net>
To: linux-kernel@vger.kernel.org
Subject: Problems going to 2.4.21, it seemed PNP related, it was just the conf
Message-ID: <20030622181742.GA1275@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is not about a real problem, but jus some difficulties I found when
going to 2.4.21, so that if somebody finds them doesn't have to go through
them, also some more verbosity on the PNP driver could help diagnosis.

The problem I'm talking about seemed to be a network card not getting its
interrupts:

NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timed out, lost interrupt? TSR=0x3, ISR=0x2, t=123.

The PNP card was manually configured via echos >/proc/isapnp.

The problem was even more dificult to diagnose because at the same time I
switched kernel I had switched alsa drivers and there seems to be some PNP
related problems on ALSA 0.9.4, at least on Debian right now.

So I started blaming the PNP code from the beginning, as I was thinking I
had not changed my kernel config too much. After some tests I reminded that
in fact I had changed the config quite a lot, as I was forced to include the
ide drivers in the kernel instead of having them as modules (I'd really
would like to see the ide drivers as modules again, I hope 2.4.22 will get
us this back).

So what was happening was that the SB16 PNP card I had on the same machine,
which has an IDE interface, and as I now have the IDE pnp code compiled in
the kernel, it was getting the IRQ I was configuring for the PNP card for
the IDE card. It didn't matter that I was doing a deactivate of the IDE
interface through /proc/isapnp, as it could not release the hardware
resources that the IDE had taken, as the IDE driver continued loaded, even
though it was not being used.

This last condition is not verbosely reported, but can be seen if one look
close to /proc/isapnp, as one can see something like this:

  Logical device 1 'CTL2011:IDE'
    Compatible device PNP0600
    Device is not active
    Active port 0x100,0x300
    Active IRQ 15 [0x2]

The device is not active, but the ports and IRQ are active.

What I did to solve this was to remove the IDE PNP code from the kernel as I
am not using that interface right now, I also tried to mark irq 15 not for
use, but that didn't seem to cause anything, I suppose I was doing something
wrong, and besides I don't know if that would allow me to manually selecting
it afterwards.

Anyway, hope this helps a bit.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
