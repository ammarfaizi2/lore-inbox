Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTKJTnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTKJTnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:43:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8211 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264084AbTKJTnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:43:19 -0500
Message-ID: <3FAFEA34.7090005@zytor.com>
Date: Mon, 10 Nov 2003 11:42:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Davide Libenzi <davidel@xmailserver.org>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random>
In-Reply-To: <20031110193101.GF6834@x30.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> we've to start rsync three times to get them in order, 3 tcp
> connections, there's no way to specify the order in the rsync command
> line, infact those two sequence files can be as well outside the tree
> and we can fetch temporarily in a /tmp/ directory or similar. However we
> can probably hack the rsync client to be able to specify the two
> sequence numbers on the command line.
> 
> It maybe also cleaner to use a slightly more complicated but more
> compact algorithm, this would make a potential new rsync command line
> option cleaner since only 1 sequence file would need to be specified:
> 
> 	do {
> 		seq = fetch(sequence-file);
> 		if (seq & 1)
> 			break;
> 		rsync
> 		if (seq != fetch(sequence-file))
> 			seq = 1;
> 	} while (seq & 1 && sleep 10 /* ideally exponential backoff */)
> 
> this way only 1 sequence-file is needed for each repository that we want
> to checkout. the server side only has to increase twice the same file
> before and after each update of the repository, so the server side is
> even simpler (with the only additional requirement that the sequence
> number has to start "even"), only the client side is a bit more complicated.
>

Good grief.  This is messy as hell, and really interferes rather badly
with the whole kernel.org mirror setup.

I guess the "best" solution is to use LVM atomic snapshots, and only
allow rsync off the atomic snapshot.  That way any particular rsync
session would always be consistent.  That's a *HUGE* amount of work,
though, and still doesn't solve the mirrors issue -- I don't control
what the mirrors run.  On the other hand, I don't know how many mirror
sites actually mirror /pub/scm since it's not a requirement.

	-hpa

