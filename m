Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132020AbQLNNkv>; Thu, 14 Dec 2000 08:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQLNNkl>; Thu, 14 Dec 2000 08:40:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29963 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131353AbQLNNkd>;
	Thu, 14 Dec 2000 08:40:33 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141303.eBED34106174@flint.arm.linux.org.uk>
Subject: Re: test12 oops with NF+ping -s 1500
To: devik@server.cdi.cz (Devik)
Date: Thu, 14 Dec 2000 13:03:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.10.10012131543350.16650-300000@luxik.cdi.cz> from "Devik" at Dec 13, 2000 03:56:42 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devik writes:
> I just tried to narrow problem with DFE530 card and found
> another (rather fatal) bug in 2.4.0-test12.
> I attached both my config and ksymoops output. It seems
> that ip_defrag is called with skb where skb->dev is NULL.
> It then crashes in ip_queue_frag.
> I can trigger it regulary by ping -s 1500 some_ip (to
> ping thru ethernet iff) on two computers.
> Please cc me in replies to devik@cdi.cz.

Linus,

How about we kill these recursive oopsen by changing the
printk("Aiee, killing interrupt handler") to a panic?  If we're
entering do_exit() from an interrupt, we will eventually enter
schedule(), again as an interrupt, which will BUG(), and then
we'll repeat ad-infinitum.

panic() is better since we break this fatal recursive oops loop,
and we also get the additional advantage that a machine with
"panic=60" set will recover.

Currently, you hit this recursive oops problem, and its game over
until reset (unless you have a hardware watchdog).
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
