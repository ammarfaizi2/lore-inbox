Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270669AbRHJWxk>; Fri, 10 Aug 2001 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270671AbRHJWxa>; Fri, 10 Aug 2001 18:53:30 -0400
Received: from mail.mesatop.com ([208.164.122.9]:43787 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S270669AbRHJWxL>;
	Fri, 10 Aug 2001 18:53:11 -0400
Message-Id: <200108102253.f7AMrCe31622@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Some dbench 32 results for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7
Date: Fri, 10 Aug 2001 16:51:00 -0600
X-Mailer: KMail [version 1.2.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108100933240.1869-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108100933240.1869-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 August 2001 10:45, Linus Torvalds wrote:
> On Fri, 10 Aug 2001, Steven Cole wrote:
> > Linus Torvalds wrote:
> > >Does the numbers change if you do something like
> > >
> > >	killall -STOP kupdated
> > >	echo 80 64 64 256 500 6000 90 > /proc/sys/vm/bdflush
> > >
> > >In particular, the dirty balancing worked really badly before, and was
> > >just fixed.  I suspect that the bdflush numbers were tuned with the
> > >badly-working case, and they might be a bit too aggressive for dbench
> > >these days..
> >
> > Sorry Linus for the late reply, but I went to bed just before your
> > message. I re-ran dbench 32 with the settings above.  Here are the
> > results:
>
> [ Good, looks more like it ]
>
> Now, the problem with dbench is that no way in hell should you optimize
> for dbench in general, because it is a sucky kind of benchmark.
>
> For example, waiting until the last possible minute for writeouts is
> definitely the best setting for dbench, but it's a pretty horrible setting
> for usability.
>
> I suspect that for optimal dbench performance we'll always have to let teh
> system admin do the above kind of horrible tweaking stuff, but at the same
> time I personally absolutely detest the need for tweaks in general, and I
> would like the default behaviour to be reasonable.
>
> Killing kupdated, for example, is not really "reasonable". But I also
> suspect that now that dirty balancing works sanely, the "start writeout at
> 30% full" is a bit early too.
>
> So instead of the 30/60% split (the first number is "when do we start
> writing things out", and the second number is "when do we start actively
> waiting for it"), a 50/75% setup might be more reasonable for regular
> loads, while making dbench at least a bit happier.
>
> Are you (or others) willing to play around with the numbers a bit and look
> at both dbench performance and at interactive feel?
>
> In general
>
> 	echo x 64 64 256 500 3000 y > /proc/sys/vm/bdflush
>
> will set the "start writeout" to 'x'%, and the "start synchronous wait" to
> 'y'% (and restart kupdated with "killall -CONT kupdated"). It would be
> interesting to hear where the sweet spot is.
>
> 		Linus
>

I ran dbench 32 twenty-eight times, with the results below.
The units are MB/sec throughput as reported by dbench.
The rows are the first number, "start write out";
the columns are the second number, "start synchronous wait".
For example, the lower left hand entry was obtained after
echo 30 64 64 256 500 6000 60 > /proc/sys/vm/bdflush
 
        60              70              80              90
 
90      8.693           8.690           8.853           8.875
80      8.822           8.724           8.703           8.910
70      8.558           8.557           8.785           8.420
60      8.194           8.141           8.006           7.847
50      6.662           6.738           6.904           6.892
40      6.347           6.252           6.380           6.274
30      5.687           5.802           6.209           5.898
 
I don't have a good quantifiable set of results for "interactive feel",
other than it's never very good under heavy load.  I'll try to get some
useable results for interactive feel while running dbench again this
weekend, looking for that elusive sweet spot.

Steven
