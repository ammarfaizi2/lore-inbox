Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275772AbRI0FsN>; Thu, 27 Sep 2001 01:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275769AbRI0FsD>; Thu, 27 Sep 2001 01:48:03 -0400
Received: from chiara.elte.hu ([157.181.150.200]:62988 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275768AbRI0Frt>;
	Thu, 27 Sep 2001 01:47:49 -0400
Date: Thu, 27 Sep 2001 07:45:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole - log kernel messages over the network.
 2.4.10.
In-Reply-To: <Pine.GSO.4.30.0109261713500.6825-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0109270738300.1679-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, jamal wrote:

> Is there any reason you are not using dev_queue_xmit()? (side
> benefits, you could hack this into using scatter gather schemes etc)

the reason is latency of messages, and reliability of sends. If we are in
the middle of a *nasty* crash that takes down the system down 10
microseconds later, then i wanted to make 100% sure the message gets out
and the bug can be debugged. The VGA console and the serial logging
console have such properties - messages are instantaneous. Networking is
very asynchron in nature, so a new network driver extension was needed to
achieve this goal.

There are crashes where there are no new IRQs processed after the crash,
so there is no chance for dev_queue_xmit to do any useful send. We must be
able to send packets even if the output interface's hardware queues are
full - and dev_queue_xmit relies on future device interrupts to send
queued packets.

this is not just theory - about 10% of the crashes i experience (during
development...) are such, and the majority of the 'hard to fix' crashes
have such properties, especially on busy remote servers.

	Ingo

