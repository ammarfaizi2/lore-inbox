Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272063AbTHDSBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272072AbTHDSBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:01:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272063AbTHDSBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:01:37 -0400
Date: Mon, 4 Aug 2003 19:01:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
Cc: linux-kernel@vger.kernel.org, breed@users.sourceforge.net
Subject: Re: PROBLEM: Problem with wireless PCMCIA card insertion on 2.6.0-test2
Message-ID: <20030804190133.D25847@flint.arm.linux.org.uk>
Mail-Followup-To: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>,
	linux-kernel@vger.kernel.org, breed@users.sourceforge.net
References: <20030804171858.GA3215@UnderGrid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030804171858.GA3215@UnderGrid.net>; from Jeremy.Bouse@UnderGrid.net on Mon, Aug 04, 2003 at 10:18:59AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 10:18:59AM -0700, Jeremy T. Bouse wrote:
> [1.]
> Problem with Wireless PCMCIA card insertion.

PCMCIA or CardBus?

> [5.]
> Jul 28 18:02:10 vaio kernel: airo:  Probing for PCI adapters
> Jul 28 18:02:10 vaio kernel: kobject_register failed for airo (-17)

This looks like an error in airo.  For starters, it doesn't unregister
its PCI driver structure when the module removed, so when it is
inserted the next time, you get this complaint.

(You can only have one driver called "airo" registered with the device
model.)

> Jul 28 18:09:25 vaio kernel: bad: scheduling while atomic!
> Jul 28 18:09:25 vaio kernel: Call Trace:
> Jul 28 18:09:25 vaio kernel:  [schedule+951/960] schedule+0x3b7/0x3c0
> Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2038071/2456049] 
> sendcommand+0xaa/0xe0 [airo]
> Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2037849/2456049] 
> issuecommand+0x5c/0x90 [airo]
> Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2039319/2456049] 
> PC4500_accessrid+0x4a/0x90 [airo]
> Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2039486/2456049] 
> PC4500_readrid+0x61/0x130 [airo]
> Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2028126/2456049] 
> readStatsRid+0x31/0x50 [airo]
> Jul 28 18:09:25 vaio kernel:  [__crc_snd_card_proc_new+2029844/2456049] 
> airo_read_stats+0x67/0x150 [airo]
> Jul 28 18:09:25 vaio kernel:  [update_wall_time+22/64] 
> update_wall_time+0x16/0x40
> Jul 28 18:09:25 vaio kernel:  [do_timer+224/240] do_timer+0xe0/0xf0

Oops, it seems to be scheduling from timer context.  That's pretty bad.
I guess this is the culpret:

static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
...
                if (!in_interrupt() && (max_tries & 255) == 0)
                        schedule();
...
}

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

