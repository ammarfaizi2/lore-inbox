Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272489AbRIKPsy>; Tue, 11 Sep 2001 11:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272493AbRIKPso>; Tue, 11 Sep 2001 11:48:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272489AbRIKPsi>; Tue, 11 Sep 2001 11:48:38 -0400
Date: Tue, 11 Sep 2001 08:48:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010911153729Z16241-1367+14@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Sep 2001, Daniel Phillips wrote:
>
> But see my post in this thread where I created a simple test to show that,
> even when we pre-read *all* the inodes in a directory, there is no great
> performance win.

Note that I suspect that because the inode tree _is_ fairly dense, you
don't actually need to do much read-ahead in most cases. Simply because
you automatically do read-ahead _always_: when somebody reads a 128-byte
inode, you (whether you like it or not) always "read-ahead" the 31 inodes
around it on a 4kB filesystem.

So we _already_ do read-ahead by a "factor of 31". Whether we can improve
that or not by increasing it to 63 inodes, who knows?

I actually think that the "start read-ahead for inode blocks when you do
readdir" might be a bigger win, because that would be a _new_ kind of
read-ahead that we haven't done before, and might improve performance for
things like "ls -l" in the cold-cache situation..

(Although again, because the inode is relatively small to the IO cache
size, it's probably fairly _hard_ to get a fully cold-cache inode case. So
I'm not sure even that kind of read-ahead would actually make any
difference at all).

		Linus

