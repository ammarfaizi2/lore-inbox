Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVCZJ2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVCZJ2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 04:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCZJ2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 04:28:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262026AbVCZJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 04:28:35 -0500
Subject: Re: 2.6.12-rc1 breaks dosemu
From: Arjan van de Ven <arjan@infradead.org>
To: Bart Oldeman <bartoldeman@ihug.co.nz>
Cc: Arnd Bergmann <arnd@arndb.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0503262023250.3166@enm-bo-lt.localnet>
References: <20050320021141.GA4449@stusta.de>
	 <200503251952.33558.arnd@arndb.de>
	 <1111778074.6312.87.camel@laptopd505.fenrus.org>
	 <200503252354.53154.arnd@arndb.de>
	 <1111825501.6293.25.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0503262023250.3166@enm-bo-lt.localnet>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 10:28:29 +0100
Message-Id: <1111829310.6293.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is one more improbable thing I can think of: comcom. This is
> dosemu's built-in command.com and uses some very tricky code
> (coopthreads), which certainly does not work any more with address space
> randomization. It's deprecated but was still present in 1.2.2, and Debian
> packages still used it with dosemu 1.2.1. The fix for that one is easy:
> replace your command.com with a real DOS command.com (e.g. FreeDOS
> freecom).



#define STACK_GRAN_SHIFT	17	/* 128K address space granularity */
#define STACK_GRAN		(1U << STACK_GRAN_SHIFT)
#define STACK_TOP		0xc0000000U
#define STACK_BOTTOM		0xa0000000U
#define STACK_TOP_PADDING	STACK_GRAN
#define STACK_SLOTS		((STACK_TOP-STACK_BOTTOM) >> STACK_GRAN_SHIFT)

#define roundup_stacksize(size) ((size + STACK_GRAN - 1) & (-((int)STACK_GRAN)))

that certainly isn't boding well for things....


ok this thing is evil.
It hardcode assumes that the stack goes from 0xc00000 to 0xa0000000, divides it into slots of 128Kb and uses each such slot
for a thread. With the randomisation there may be "slots" above the actual stack that appear free but are just entirely
unmapped. This thing is broken beyond belief! (and it won't work for any other kind of split than 3:1, eg 2:2 or 4:4 or 0.5:3.5,
as well as the 4Gig address space on x86-64 or ia64 in 32 bit emu mode)

I can't think of any reasonable way to work around this behavior other than suggesting to use the setarch
option to disable randomisation for this process... this is just too much weirdness/brokenness to work around.


