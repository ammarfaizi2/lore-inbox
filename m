Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272192AbRHWKcr>; Thu, 23 Aug 2001 06:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272229AbRHWKch>; Thu, 23 Aug 2001 06:32:37 -0400
Received: from mailrelay.inpharmatica.co.uk ([193.115.214.5]:32526 "EHLO
	gallions-reach.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S272192AbRHWKcS>; Thu, 23 Aug 2001 06:32:18 -0400
Message-ID: <3B84DB4A.5050707@purplet.demon.co.uk>
Date: Thu, 23 Aug 2001 11:30:34 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() says closed socket readable
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAECLDGAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

[assumptions deleted]

> 	Of course, this isn't so much of a benefit that it's worth violating a
> standard like POSIX. But it could be considered enough of a benefit that
> it's worth not being compatable outside the bounds of such a standard.

Let's think about the _facts_ for a second. In the case where select on
an unconnected socket succeeds (because a read would not block) a
process that does this would not sleep in select. If the select does
not succeed (because the socket is not ready to read) then the process
sleeps.

In the first case the process either eats CPU time or gets an error
when it reads the socket. But does it handle the error? Does it even
do the read - why should it read the unconnected socket at all?

In the second case the process either hangs or behaves as expected.
It may even recover gracefully if the socket is subsequently connected.

Case 1 leads to spin-or-die and case 2 leads to block-and-work.

Case 1 assumes that selecting for read on an unconnected socket is
an error. Case 2 doesn't - an unconnected socket is simply never
"ready to read".

Other systems use the "ready to read" interpretation. The Single
UNIX Spec states "ready to read". The Linux man page uses "ready
to read" but adds a parenthetical "read will not block" to allow
EOF. Linux itself implements "will not block".

I can find nothing that even suggests that selecting on an unconnected
socket is an error.

Linux is wrong. Patch follows.

				Mike

