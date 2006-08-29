Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWH2J6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWH2J6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWH2J6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:58:18 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:48051 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S964856AbWH2J6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:58:17 -0400
Subject: Re: Reiser4 und LZO compression
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: David Masover <ninja@slaphack.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Edward Shishkin <edward@namesys.com>,
       Stefan Traby <stefan@hello-penguin.com>,
       Hans Reiser <reiser@namesys.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44F3F993.3000907@slaphack.com>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	 <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>
	 <44F332D6.6040209@namesys.com> <1156801705.2969.6.camel@nigel.suspend2.net>
	 <Pine.LNX.4.61.0608290603330.8045@yvahk01.tjqt.qr>
	 <1156830102.3790.15.camel@nigel.suspend2.net>
	 <44F3F993.3000907@slaphack.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 19:57:45 +1000
Message-Id: <1156845465.3790.38.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-08-29 at 03:23 -0500, David Masover wrote:
> Nigel Cunningham wrote:
> > Hi.
> > 
> > On Tue, 2006-08-29 at 06:05 +0200, Jan Engelhardt wrote:
> >>>>>> Hmm.  LZO is the best compression algorithm for the task as measured by
> >>>>>> the objectives of good compression effectiveness while still having very
> >>>>>> low CPU usage (the best of those written and GPL'd, there is a slightly
> >>>>>> better one which is proprietary and uses more CPU, LZRW if I remember
> >>>>>> right.  The gzip code base uses too much CPU, though I think Edward made
> >>>>> I don't think that LZO beats LZF in both speed and compression ratio.
> >>>>>
> >>>>> LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
> >>>>> of LZO for the next generation suspend-to-disk code of the Linux kernel.
> >>>>>
> >>>>> see: http://www.goof.com/pcg/marc/liblzf.html
> >>>> thanks for the info, we will compare them
> >>> For Suspend2, we ended up converting the LZF support to a cryptoapi
> >>> plugin. Is there any chance that you could use cryptoapi modules? We
> >>> could then have a hope of sharing the support.
> >> I am throwing in gzip: would it be meaningful to use that instead? The 
> >> decoder (inflate.c) is already there.
> >>
> >> 06:04 shanghai:~/liblzf-1.6 > l configure*
> >> -rwxr-xr-x  1 jengelh users 154894 Mar  3  2005 configure
> >> -rwxr-xr-x  1 jengelh users  26810 Mar  3  2005 configure.bz2
> >> -rw-r--r--  1 jengelh users  30611 Aug 28 20:32 configure.gz-z9
> >> -rw-r--r--  1 jengelh users  30693 Aug 28 20:32 configure.gz-z6
> >> -rw-r--r--  1 jengelh users  53077 Aug 28 20:32 configure.lzf
> > 
> > We used gzip when we first implemented compression support, and found it
> > to be far too slow. Even with the fastest compression options, we were
> > only getting a few megabytes per second. Perhaps I did something wrong
> > in configuring it, but there's not that many things to get wrong!
> 
> All that comes to mind is the speed/quality setting -- the number from 1 
> to 9.  Recently, I backed up someone's hard drive using -1, and I 
> believe I was still able to saturate... the _network_.  Definitely try 
> again if you haven't changed this, but I can't imagine I'm the first 
> persson to think of it.
> 
>  From what I remember, gzip -1 wasn't faster than the disk.  But at 
> least for (very) repetitive data, I was wrong:
> 
> eve:~ sanity$ time bash -c 'dd if=/dev/zero of=test bs=10m count=10; sync'
> 10+0 records in
> 10+0 records out
> 104857600 bytes transferred in 3.261990 secs (32145287 bytes/sec)
> 
> real    0m3.746s
> user    0m0.005s
> sys     0m0.627s
> eve:~ sanity$ time bash -c 'dd if=/dev/zero bs=10m count=10 | gzip -v1 > 
> test; sync'
> 10+0 records in
> 10+0 records out
> 104857600 bytes transferred in 2.404093 secs (43616282 bytes/sec)
>   99.5%
> 
> real    0m2.558s
> user    0m1.554s
> sys     0m0.680s
> eve:~ sanity$
> 
> 
> 
> This was on OS X, but I think it's still valid -- this is a slightly 
> older Powerbook, with a 5400 RPM drive, 1.6 ghz G4.
> 
> -1 is still worlds better than nothing.  The backup was over 15 gigs, 
> down to about 6 -- loads of repetitive data, I'm sure, but that's where 
> you win with compression anyway.

Wow. That's a lot better; I guess I did get something wrong in trying to
tune deflate. That was pre-cryptoapi though; looking at
cryptoapi/deflate.c, I don't see any way of controlling the compression
level. Am I missing anything?

> Well, you use cryptoapi anyway, so it should be easy to just let the 
> user pick a plugin, right?

Right. They can already pick deflate if they want to.

Regards,

Nigel

