Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbTGZTCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbTGZTCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:02:15 -0400
Received: from hera.kernel.org ([63.209.29.2]:7619 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267317AbTGZTCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:02:13 -0400
To: linux-kernel@vger.kernel.org
From: OSDL <torvalds@osdl.org>
Subject: Re: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad value compared to 2.4
Date: Sat, 26 Jul 2003 12:17:01 -0700
Organization: OSDL
Message-ID: <bfuk3d$llp$1@build.pdx.osdl.net>
References: <1059244318.3400.17.camel@localhost>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1059247021 22201 172.20.1.2 (26 Jul 2003 19:17:01 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Sat, 26 Jul 2003 19:17:01 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jones wrote:
>
> I added
> 
> printk(KERN_DEBUG "yenta_get_status: status=%04x\n",state);
> 
> after the call
> u32 state = cb_readl(socket, CB_SOCKET_STATE);
> in
> static int yenta_get_status(struct pcmcia_socket *sock, unsigned int
> *value)
> in drivers/pcmcia/yenta_socket.c
> 
> in both 2.4.21 and 2.6.0-test1
> 
> 2.6.0-test1 gives: 30000411
> 2.4.21 gives:      30000419
> 
> I wonder why the values are different, and yet fairly close. It is
> enough to give hard lockups ( I debugged this one with printk's and
> commenting out code )
> 
> I have added
> 
> state |= CB_CBCARD;

The difference between 2.4 and 2.6 is not CB_CBCARD (0x0020), but
CB_PWRCYCLE (0x0008).

For some reason 2.6.x hasn't powered up the 16-bit card.

However, the whole CB_POWERCYCLE thing is ignored for 16-bit cards,
and what you end up doing by marking the card as a 32-bit cardbus card
(that's what the CB_CBCARD define means) is to basically force the
wrong code to be run, at which point the 32-bit code decides that
the card isn't powered.

The real question is why the card isn't powered up. Also, it sounds
like the 16-bit status (from I365_STATUS) doesn't agree with the 32-bit
status (from CB_SOCKET_STATE), so when you _do_ force trusting of the
32-bit status, then things work.

Which is interesting in itself. It's entirely possible that we should
just ignore the 16-bit status when it comes to the SS_POWERON logic.

Does the card actually _work_ when you do your hack? Or does it just
stop the hang?

                Linus
