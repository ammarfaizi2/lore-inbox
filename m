Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVIJAfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVIJAfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVIJAfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:35:23 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:20124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932652AbVIJAfW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:35:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qscwdq+CXEYrN0pC3GqNDPj42aEDy9m1a2WkP8O2HXhxcabGAuvNl8eaOvLgrb0qolgtZT4qGYQ7twPrTzCeij0Xc7gx0eenmdql0OcxCDWRndjZFTsBRJ+OAcZXW1VDVNjlCcE4nxJAO+6+4MJK/I/QeUpb68xriKEkTzY/xyM=
Message-ID: <5c49b0ed0509091735436260bb@mail.gmail.com>
Date: Fri, 9 Sep 2005 17:35:20 -0700
From: Nate Diller <nate.diller@gmail.com>
Reply-To: nate.diller@gmail.com
To: awesley@acquerra.com.au
Subject: Re: kernel 2.6.13 buffer strangeness
Cc: Roger Heflin <rheflin@atipa.com>, linux-kernel@vger.kernel.org
In-Reply-To: <432225E0.9030606@acquerra.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432151B0.7030603@acquerra.com.au>
	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
	 <5c49b0ed05090914394dba42bf@mail.gmail.com>
	 <432225E0.9030606@acquerra.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Anthony Wesley <awesley@acquerra.com.au> wrote:
> Hi Nate and Roger,
> 
> First off, thanks fo taking some time to answer my call for help :-)
> 
> I've already spent some time fiddling with dirty_ratio before I posted my
> question - yes, I can make different things happen by increasing or
> decreasing it, but overall I still have the same problem - my video
> streaming runs out of steam after at most 50 seconds instead of the 3
> minutes that I think it should take.
> 
> Setting dirty_ratio and dirty_background_ratio to 15/10 respectively makes
> things worse, I hit the wall after only about 25 seconds.
> 
not surprising

> Setting dirty_ratio and dirty_background_ratio to 85/80 makes things worse -
> disk writes start after about 15 seconds and I hit the wall after about 35
> seconds.
> 
so dirty_background_ratio is working, that's why it took a long time
to start writing anything out

> Setting dirty_ratio and dirty_background_ratio to 90/10 puts me back at
> around 50 seconds, i.e. where I started.
> 
this setting should do the trick, so there's something going on here
that isn't expected.

> So as far as I can see there is *no way* to get 3 minutes worth of buffering
> by adjusting these parameters.
> 
> Just to remind everyone - I have video data coming in at 25MBytes/sec and I
> am writing it out to a usb2 hard disk that can sustain 17MBytes/sec. I want
> my video capture to run at full speed as long as possible by having the
> 7MBytes/sec deficit slowly eat up the available RAM in the machine. I have
> 1.5Gb of RAM, 1.3Gb available for buffers, so this should take 3 minutes to
> consume at 7MBytes/sec.
> 
> So, I've tried all the combinations on dirty_ratio and
> dirty_background_ratio and they *do not help*.
> 
dirty_ratio is the tubable you want, if it's not working correctly,
either there's a problem with your setup, or a bug

> Can anyone suggest something else that I might try? The goal is to have
> 25MBytes/sec streaming video for about 3 minutes. 
> 
how sure are you that you're getting 17MB/s during this test?  can you
run "vmstat 1" while this is running to verify?  which FS and
scheduler?

just for interest, what's the raw disk bandwidth (use hdparm, or run a
dd, or something)?  it would obviously be much better to sustain
25MB/s to disk

> Or is this simply not possible with the current kernel I/O setup? Do I have
> to do something elaborate myself, like build a big RAM buffer, mount the
> disk synchronous, do the buffering myself in userland...??
> 
this should be possible, although it could be considered a bit risky WRT OOM.

NATE

> regards, Anthony
> 
> Nate Diller wrote:
> 
> > On 9/9/05, Roger Heflin <rheflin@atipa.com> wrote:
> > 
> >>I saw it mentioned before that the kernel only allows a certain
> >>percentage of total memory to be dirty, I thought the number was
> >>around 40%, and I have seen machines with large amounts of ram,
> >>hit the 40% and then put the writing application into disk wait
> >>until certain amounts of things are written out, and then take
> >>it out of disk wait, and repeat when it again hits 40%, given your
> >>rate different it would be close to 40% in 50seconds.
> >>
> > 
> > yes, on 2.6 there are two tunables which are important here. 
> > dirty_background_ratio is the threshold where the kernel will begin
> > flushing dirty buffers, so it should change how soon the disk becomes
> > active.  dirty_ratio changes when the write-throttling code kicks in,
> > which is what Anthony is seeing.  The purpose of the write throttling
> > code is to limit the dirtying process to disk bandwidth, so that is a
> > Feature.  Anthony, try *increasing* dirty_ratio, you can go up to 100,
> > but you could trigger an OOM if you let it get too high, so maybe try
> > setting it at 85 or so.  This should effectively disable the write
> > throttling and give you the bandwidth you want.
> > 
> > NATE
> > 
> > 
> >>And I think that you mean MB(yte) not Mb(it).
> >>
> >>                           Roger
> >>
> >>
> >>>-----Original Message-----
> >>>From: linux-kernel-owner@vger.kernel.org 
> >>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> >>>Anthony Wesley
> >>>Sent: Friday, September 09, 2005 4:11 AM
> >>>To: linux-kernel@vger.kernel.org
> >>>Subject: Re: kernel 2.6.13 buffer strangeness
> >>>
> >>>Thanks David, but if you read my original post in full you'll 
> >>>see that I've tried that, and while I can start the write out 
> >>>sooner by lowering /proc/sys/vm/dirty_ratio , it makes no 
> >>>difference to the results that I am getting. I still seem to 
> >>>run out of steam after only 50 seconds where it should take 
> >>>about 3 minutes.
> >>>
> >>>regards, Anthony
> >>>
> >>>--
> >>>Anthony Wesley
> >>>Director and IT/Network Consultant
> >>>Smart Networks Pty Ltd
> >>>Acquerra Pty Ltd
> >>>
> >>>Anthony.Wesley@acquerra.com.au
> >>>Phone: (02) 62595404 or 0419409836
> >>>
> >>>-
> >>>To unsubscribe from this list: send the line "unsubscribe 
> >>>linux-kernel" in the body of a message to 
> >>>majordomo@vger.kernel.org More majordomo info at  
> >>>http://vger.kernel.org/majordomo-info.html
> >>>Please read the FAQ at  http://www.tux.org/lkml/
> >>>
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> > 
> > 
> 
> -- 
> Anthony Wesley
> Director and IT/Network Consultant
> Smart Networks Pty Ltd
> Acquerra Pty Ltd
> 
> Anthony.Wesley@acquerra.com.au
> Phone: (02) 62595404 or 0419409836
>
