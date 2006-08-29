Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWH2LJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWH2LJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWH2LJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:09:26 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:46140 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932282AbWH2LJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:09:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zoh+U2wPWPbd7n6Z9r1DIjnMqHVP2eDvamYfGRerNADA79uj7A1Tun6owQI3jlkxdqiq+UplQzngxGs0sR4dTNkg3suSCOkXRsgPBORsNAYcHt+I3D+OFa16GeZNnChymHqdRMpBpQ4MeAR8qFmFO6xzUgdw6qryKMnrU6hHtaM=
Message-ID: <2c0942db0608290409j570c9f43jf9cd555e83bed73f@mail.gmail.com>
Date: Tue, 29 Aug 2006 04:09:24 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Nigel Cunningham" <ncunningham@linuxmail.org>
Subject: Re: Reiser4 und LZO compression
Cc: "David Masover" <ninja@slaphack.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Edward Shishkin" <edward@namesys.com>,
       "Stefan Traby" <stefan@hello-penguin.com>,
       "Hans Reiser" <reiser@namesys.com>,
       "Alexey Dobriyan" <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1156845465.3790.38.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	 <44F322A6.9020200@namesys.com>
	 <20060828173721.GA11332@hello-penguin.com>
	 <44F332D6.6040209@namesys.com>
	 <1156801705.2969.6.camel@nigel.suspend2.net>
	 <Pine.LNX.4.61.0608290603330.8045@yvahk01.tjqt.qr>
	 <1156830102.3790.15.camel@nigel.suspend2.net>
	 <44F3F993.3000907@slaphack.com>
	 <1156845465.3790.38.camel@nigel.suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> Hi.
> On Tue, 2006-08-29 at 03:23 -0500, David Masover wrote:
> > Nigel Cunningham wrote:
> > > We used gzip when we first implemented compression support, and found it
> > > to be far too slow. Even with the fastest compression options, we were
> > > only getting a few megabytes per second. Perhaps I did something wrong
> > > in configuring it, but there's not that many things to get wrong!
> >
> > All that comes to mind is the speed/quality setting -- the number from 1
> > to 9.  Recently, I backed up someone's hard drive using -1, and I
> > believe I was still able to saturate... the _network_.  Definitely try
> > again if you haven't changed this, but I can't imagine I'm the first
> > persson to think of it.
> >
> >  From what I remember, gzip -1 wasn't faster than the disk.  But at
> > least for (very) repetitive data, I was wrong:
> >
> > eve:~ sanity$ time bash -c 'dd if=/dev/zero of=test bs=10m count=10; sync'
> > 10+0 records in
> > 10+0 records out
> > 104857600 bytes transferred in 3.261990 secs (32145287 bytes/sec)
> >
> > real    0m3.746s
> > user    0m0.005s
> > sys     0m0.627s
> > eve:~ sanity$ time bash -c 'dd if=/dev/zero bs=10m count=10 | gzip -v1 >
> > test; sync'
> > 10+0 records in
> > 10+0 records out
> > 104857600 bytes transferred in 2.404093 secs (43616282 bytes/sec)
> >   99.5%
> >
> > real    0m2.558s
> > user    0m1.554s
> > sys     0m0.680s
> > eve:~ sanity$
> >
> >
> >
> > This was on OS X, but I think it's still valid -- this is a slightly
> > older Powerbook, with a 5400 RPM drive, 1.6 ghz G4.
> >
> > -1 is still worlds better than nothing.  The backup was over 15 gigs,
> > down to about 6 -- loads of repetitive data, I'm sure, but that's where
> > you win with compression anyway.
>
> Wow. That's a lot better; I guess I did get something wrong in trying to
> tune deflate. That was pre-cryptoapi though; looking at
> cryptoapi/deflate.c, I don't see any way of controlling the compression
> level. Am I missing anything?

Compressing /dev/zero isn't a great test. The timings are really data-dependant:

ray@phoenix:~$ time bash -c 'sudo dd if=/dev/zero bs=8M count=64 |
gzip -v1 >/dev/null'
64+0 records in
64+0 records out
536870912 bytes (537 MB) copied, 7.60817 seconds, 70.6 MB/s
 99.6%

real    0m7.652s
user    0m6.581s
sys     0m0.701s
ray@phoenix:~$ time bash -c 'sudo dd if=/dev/mem bs=8M count=64 | gzip
-v1 >/dev/null'
64+0 records in
64+0 records out
536870912 bytes (537 MB) copied, 21.5863 seconds, 24.9 MB/s
 70.4%

real    0m21.626s
user    0m18.763s
sys     0m1.762s

This is on an AMD64 laptop.

Ray
