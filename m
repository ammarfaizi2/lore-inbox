Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316478AbSEOUDn>; Wed, 15 May 2002 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316479AbSEOUDm>; Wed, 15 May 2002 16:03:42 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:11279 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S316478AbSEOUDm>;
	Wed, 15 May 2002 16:03:42 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205151943.UAA22346@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: guk.ukuu.org.uk@it.uc3m.es
Date: Wed, 15 May 2002 20:43:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com, kumbera@yahoo.com,
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200205151743.g4FHh2922978@oboe.it.uc3m.es> from "Peter T. Breuer" at May 15, 2002 07:43:02 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the info. I'm starting to form some ideas of what the problem
with nbd might be. Here is my initial idea of what might be going on:

 1. Something happens which starts lots of I/O (e.g. the ext3/xfs journal
    flush that Xiangping says usually triggers the problem)
 2. One of the threads doing the writes blocks running the device I/O
    queue and causing nbd_send_req(), nbd_xmit() to block in the 
    sendmsg() call (trying to allocate memory GFP_NOIO). I think we
    only need to have each memory zones free pages just below pages_min
    at the right time to trigger this.
 3. Since bdflush will most likely be running it waits for the dirty
    blocks its submitted to finish being written back to the
    nbd device to finish.

So something to try is this, in nbd_send_req() add the lines:

	if (current->flags & PF_MEMALLOC == 0) {
		current->flags |= PF_MEMALLOC;
		we_set_memalloc = 1;
	}

before the first nbd_xmit() call and

	if (we_set_memalloc)
		current->flags &= ~PF_MEMALLOC;

at the end just before the return; rememebring to declare the variable:

int we_set_memalloc = 0;

at the top of the function. We know that since the box stays responsive to
pings that there must be some free memory, so I suspect some kind of
"priority inversion" is at work here.

Another interesting idea... if we changed the icmp receive function so that
it leaked all echo request packets rather than recycling them we could
measure the free memory after the box has hung by seeing how many times
we can ping it before it stops replying. An interesting way to
measure free memory, but probably quite effective :-)

It looks like adding the line:

	if (icmph->type == ICMP_ECHO) return;

just after (icmp_pointers[icmph->type].handler)(skb); in icmp.c:icmp_rcv()
should do the trick in this case.

Those are my current thoughts. Let me know if you are sure that some of
what I've said is right/wrong, otherwise I'll have a go tomorrow at
trying to prove some of it on my test system here,

Steve.

