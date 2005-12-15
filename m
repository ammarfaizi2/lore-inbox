Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVLOUFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVLOUFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVLOUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:05:24 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:50704
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1750789AbVLOUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:05:23 -0500
Date: Thu, 15 Dec 2005 12:05:21 -0800
From: Brad Boyer <flar@allandria.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215200521.GA18346@pants.nu>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151832270.1609@scrub.home> <20051215175536.GA27946@ftp.linux.org.uk> <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be> <20051215181405.GB27946@ftp.linux.org.uk> <20051215185829.GC27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215185829.GC27946@ftp.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 06:58:29PM +0000, Al Viro wrote:
> On Thu, Dec 15, 2005 at 06:14:05PM +0000, Al Viro wrote:
> > >From my reading of the code it's a way for mac/misc.c to send a packet that
> > starts with CUDA_PACKET or PMU_PACKET instead of ADB_PACKET, but otherwise
> > is the same as normal adb_request() ones...
> > 
> > Used for access to timer, nvram, etc. - looks like that puppy used to
> > use the same protocol for more than just ADB and the first byte of packet
> > really selects the destination...
> 
> After reading some more...  Is there any reason why mac/misc.c can't
> simply use cuda_request() and pmu_request() instead?  At least for
> read/write for time and nvram we end up with identical sequence of
> operations anyway - if you expand the calls in
>         adb_request((struct adb_request *) &req, NULL,
>                         ADBREQ_RAW|ADBREQ_SYNC,
>                         2, CUDA_PACKET, CUDA_GET_TIME);
> [m68k]
> and
>         if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
> 		/* bail out */
>         while (!req.complete)
>                 cuda_poll();
> [ppc]
> until you get to call of cuda_write(), you'll see the same code.  Come
> to think of that...  Shouldn't the ifdefs for CONFIG_ADB_PMU in there be for
> CONFIG_ADB_PMU68?  The former depends on PMAC_PPC, so it's not particulary
> useful thing to check on m68k...

Honestly, the RTC/PRAM code is completely broken in 2.6 for mac68k anyway.
We definitely shouldn't be using CONFIG_ADB_PMU in the m68k code. I suspect
that wasn't found due to the fact that the pmu68k driver has never been
reliable enough to use, so everyone blames that for stuff breaking. Changing
that use of CONFIG_ADB_PMU to CONFIG_ADB_PMU68K seems like the correct
thing to do in this case.

I would like to stop using adb_request in mac/misc.c as well, but it's not
as simple as just changing it to use cuda_request and pmu_request. That
should do it for the cuda and pmu based models, but the egret (Mac IIsi
and friends) based models get left out by that fix. If noone else looks
at it before me, I'll check this out after I fix some other stuff related
to m68k mac support.

	Brad Boyer
	flar@allandria.com

