Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSASRuQ>; Sat, 19 Jan 2002 12:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSASRuH>; Sat, 19 Jan 2002 12:50:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44620 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286339AbSASRt4>; Sat, 19 Jan 2002 12:49:56 -0500
Date: Sat, 19 Jan 2002 18:50:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Ken Brownfield <brownfld@irridia.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM 11c (RMAP IS A WINNER!)
Message-ID: <20020119185016.F21279@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0201171721230.32617-100000@imladris.surriel.com> <012d01c19fb7$ba1cb680$02c8a8c0@kroptech.com> <20020118182837.D31076@asooo.flowerfire.com> <02f801c1a0a7$5643a1a0$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <02f801c1a0a7$5643a1a0$02c8a8c0@kroptech.com>; from akropel1@rochester.rr.com on Sat, Jan 19, 2002 at 12:08:30AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 12:08:30AM -0500, Adam Kropelin wrote:
> Ken Brownfield:
> 
> > Do you get more even throughput with this:
> >
> > /bin/echo "10 0 0 0 500 3000 10 0 0" > /proc/sys/vm/bdflush
> >
> > It seems to help significantly for me under heavy sustained I/O load.
> 
> With a little modification, Ken's suggestion makes -rmap11c a winner on my test
> case.
> 
> /bin/echo "10 0 0 0 500 3000 30 0 0" > /proc/sys/vm/bdflush
				  ^
> 
> Switching to synchronous bdflush a little later than Ken did brings performance
> up to ~2000 blocks/sec, which is similar to older -ac kernels. This writeout
> rate is very consistent (even more so than -ac) and seems to be the top end in
> all large writes to the RAID (tried FTP, samba, and local balls-to-the-wall "cat
> /dev/zero >..."), which helps show that this is not a network driver or protocol
> interaction.
> 
> The same bdflush tuning (leaving aa's additional parameters at their defaults)

you cannot set the underlined one to zero (way too low, insane) or to
left it to its default (20) in -aa, or it will be misconfigured setup
that can lead to anything. the rule is:

	nfract_stop_bdflush <= nfract <= nfract_sync

you set:

	nfract = 10
	nfract_sync = 30

so nfract_stop_bdflush cannot be 20.

Furthmore you set ndirty to 0, that also is an invalid setup.

With -aa something sane along the above lines is:

	/bin/echo "10 2000 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush

this set nfract to 2000 (so you will write around 2 mbyte at every go
with a 1k fs like I bet you have, not 500k as the default), plus nfract
= 10%, nfract_sync = 30% and nfract_stop_bdflush = 5%
(nfract_stop_bdflush is available only in -aa). Of course nfract should
be in function at least of bytes, not of blocksize, but oh well...

now it would be interesting to know how it performs this way with -aa.
The fact you setup the stop bdflush either to 0 or to 20 in -aa can very
well explain regression in async-flushing performance with your previous
test on top of -aa.

Andrea
