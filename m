Return-Path: <linux-kernel-owner+w=401wt.eu-S1751469AbXAOU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXAOU3I (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbXAOU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:29:08 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:39966 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbXAOU3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:29:06 -0500
X-Greylist: delayed 3636 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 15:29:06 EST
Date: Mon, 15 Jan 2007 19:27:56 +0000
From: David Hollis <dhollis@davehollis.com>
Subject: Re: 2.6.20-rc4-mm1 USB (asix) problem
In-reply-to: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <1168889276.19899.105.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-13 at 15:31 -0500, Eric Buddington wrote:
> The following problem occured on an Athlon64 X2 under 2.6.20-rc4-mm1,
> but not 2.6.20-rc3-mm1.
> 
> I'm using two D-Link DUB-E100 USB ethernet adapters, using the 'asix'
> driver. When I upgraded to 2.6.20-rc4-mm1, they were still recognized,
> but various ifconfig operations on them (up/down, changing IP) caused
> a system freeze (including caps lock/num lock lights) for many seconds.
> I do not believe there was anything new in dmesg when the system
> resumed. USB debugging was not turned on at the time, though the
> problem is repeatable.
> 
> Also, no packets actually made it out of the adapters (watching from
> other systems on the network).
> 
> Since this is a system we need running and networked, I can't do
> extensive testing on it, but I might be to bring it down for a few
> quick tests if that would help.

Do you happen to have a Rev. B1 DLink adapter?  If so, the only change
that was put in (PHY Select fix) should actually make these devices
work.  Can you check the top of the ax88772_bind() call in your file and
see if it has this bit:

        if ((ret = asix_write_cmd(dev, AX_CMD_SW_PHY_SELECT,
                                1, 0, 0, buf)) < 0) {
                dbg("Select PHY #1 failed: %d", ret);
                goto out2;
        }


That '1' after the AX_CMD_SW_PHY_SELECT was the key to that patch.  If
yours is 1, you could try setting it to 0, though that should make
things not work.  I'd very interested if it made things work for you.
BTW, the ramifications of this bug were similar to what you describe:
the interface would come up, look fine but just wouldn't send or receive
any packets. The hard lock-ups and such are likely from something else.

-- 
David Hollis <dhollis@davehollis.com>

