Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVLOS6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVLOS6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVLOS6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:58:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:32920 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750938AbVLOS6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:58:30 -0500
Date: Thu, 15 Dec 2005 18:58:29 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215185829.GC27946@ftp.linux.org.uk>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151832270.1609@scrub.home> <20051215175536.GA27946@ftp.linux.org.uk> <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be> <20051215181405.GB27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215181405.GB27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 06:14:05PM +0000, Al Viro wrote:
> >From my reading of the code it's a way for mac/misc.c to send a packet that
> starts with CUDA_PACKET or PMU_PACKET instead of ADB_PACKET, but otherwise
> is the same as normal adb_request() ones...
> 
> Used for access to timer, nvram, etc. - looks like that puppy used to
> use the same protocol for more than just ADB and the first byte of packet
> really selects the destination...

After reading some more...  Is there any reason why mac/misc.c can't
simply use cuda_request() and pmu_request() instead?  At least for
read/write for time and nvram we end up with identical sequence of
operations anyway - if you expand the calls in
        adb_request((struct adb_request *) &req, NULL,
                        ADBREQ_RAW|ADBREQ_SYNC,
                        2, CUDA_PACKET, CUDA_GET_TIME);
[m68k]
and
        if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
		/* bail out */
        while (!req.complete)
                cuda_poll();
[ppc]
until you get to call of cuda_write(), you'll see the same code.  Come
to think of that...  Shouldn't the ifdefs for CONFIG_ADB_PMU in there be for
CONFIG_ADB_PMU68?  The former depends on PMAC_PPC, so it's not particulary
useful thing to check on m68k...
