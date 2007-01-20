Return-Path: <linux-kernel-owner+w=401wt.eu-S965366AbXATU2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbXATU2u (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbXATU2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:28:50 -0500
Received: from 1wt.eu ([62.212.114.60]:2094 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965366AbXATU2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:28:49 -0500
Date: Sat, 20 Jan 2007 21:28:21 +0100
From: Willy Tarreau <w@1wt.eu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120202821.GD25307@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu> <200701201952.54714.ismail@pardus.org.tr> <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Sat, Jan 20, 2007 at 09:10:22PM +0100, Tim Schmielau wrote:
> On Sat, 20 Jan 2007, Ismail Dönmez wrote:
> 
> > 20 Oca 2007 Cts 19:45 tarihinde ??unlar?? yazm????t??n??z:
> > [...]
> > > > vaio cartman # hdparm -tT /dev/hda
> > > >
> > > > /dev/hda:
> > > >  Timing cached reads:   1576 MB in  2.00 seconds = 788.18 MB/sec
> > > >  Timing buffered disk reads:   74 MB in  3.01 seconds =  24.55 MB/sec
> > > >
> > > >
> > > > [~]> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> > > > 1024+0 records in
> > > > 1024+0 records out
> > > > 1073741824 bytes (1,1 GB) copied, 77,2809 s, 13,9 MB/s
> > > >
> > > > real    1m17.482s
> > > > user    0m0.003s
> > > > sys     0m2.350s
> > >
> > > That's not bad at all ! I suspect that if your system becomes unresponsive,
> > > it's because real writes start when the cache is full. And if you fill
> > > 512 MB of RAM with data that you then need to flush on disk at 14 MB/s, it
> > > can take about 40 seconds during which it might be difficult to do
> > > anything.
> > >
> > > Try lowering the cache flush starting point to about 10 MB if you want
> > > (2% of 512 MB) :
> > >
> > > # echo 2 >/proc/sys/vm/dirty_ratio
> > > # echo 2 >/proc/sys/vm/dirty_background_ratio
> > 
> > After that I get,
> > 
> > [~]>  time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> > 1024+0 records in
> > 1024+0 records out
> > 1073741824 bytes (1,1 GB) copied, 41,7005 s, 25,7 MB/s
> > 
> > real    0m41.926s
> > user    0m0.007s
> > sys     0m2.500s
> > 
> > 
> > not bad! thanks :)
> 
> Note that these dd "benchmarks" are completely bogus, because the data 
> doesn't actually get written to disk in that time. For some enlightening 
> data, try
> 
>   time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time sync
> 
> The dd returns as soon as all data could be buffered in RAM. Only sync 
> will show how long it takes to actually write out the data to disk.

While I 100% agree with you on this, I'd like to note that I don't agree
with the following statement :

> also explains why you see better results is writeout starts earlier.

The results should be better when writeout starts later since most of
the transfer will have been performed at RAM speed. That's what happens
with the user above with 2 GB RAM. But in case of the VAIO with 512 MB,
there's really something strange IMHO. I suspect it has two RAM areas,
one fast and one slow (probably one two large non-cacheable area for a
shared video or such a crap, which can be avoided when reducing the
cache size).

Best regards,
Willy

