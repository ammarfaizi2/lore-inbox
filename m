Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTKJTc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTKJTc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:32:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51408
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264089AbTKJTcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:32:23 -0500
Date: Mon, 10 Nov 2003 20:31:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110193101.GF6834@x30.random>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFE22B.3030108@zytor.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:08:27AM -0800, H. Peter Anvin wrote:
> Andrea Arcangeli wrote:
> > 
> > you must pick file2 before file1:
> > 
> > 	you:
> > 
> > 	do
> > 		get file2
> > 		get repo-file1-j
> > 		get file1
> > 	while file2 != file1 && sleep 10
> >
> 
> Okay... I'm starting to think the sequencing requirements on these files
> may be hard to maintain across multiple levels of rsync... but perhaps
> I'm wrong, in particular if 'file2' sorts hierachially-lexically last
> and 'file1' first...

we've to start rsync three times to get them in order, 3 tcp
connections, there's no way to specify the order in the rsync command
line, infact those two sequence files can be as well outside the tree
and we can fetch temporarily in a /tmp/ directory or similar. However we
can probably hack the rsync client to be able to specify the two
sequence numbers on the command line.

It maybe also cleaner to use a slightly more complicated but more
compact algorithm, this would make a potential new rsync command line
option cleaner since only 1 sequence file would need to be specified:

	do {
		seq = fetch(sequence-file);
		if (seq & 1)
			break;
		rsync
		if (seq != fetch(sequence-file))
			seq = 1;
	} while (seq & 1 && sleep 10 /* ideally exponential backoff */)

this way only 1 sequence-file is needed for each repository that we want
to checkout. the server side only has to increase twice the same file
before and after each update of the repository, so the server side is
even simpler (with the only additional requirement that the sequence
number has to start "even"), only the client side is a bit more complicated.
