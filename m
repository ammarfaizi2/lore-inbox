Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbRADVyM>; Thu, 4 Jan 2001 16:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRADVyD>; Thu, 4 Jan 2001 16:54:03 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:61190 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131161AbRADVxu>; Thu, 4 Jan 2001 16:53:50 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "otto meier" <gf435@gmx.net>
Date: Fri, 5 Jan 2001 08:53:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14932.61665.942269.385569@notabene.cse.unsw.edu.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze on 2.4.0.prerelease (smp,raid5)
In-Reply-To: message from Otto Meier on Wednesday January 3
In-Reply-To: <200101031105.f03B5Nx00953@gate2.private.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 3, gf435@gmx.net wrote:
> On Tue, 02 Jan 2001 18:19:41 +0100, Otto Meier wrote:
> 
> >>Dual Celeron (SMP,raid5)
> >> As stated in my first mail I run actually my raid5 devices in degrated mode
> >> and as I remenber there has been some raid5 stuff changed between 
> >> test13p3 and newer kernels.
> 
> >So tell us, why do you run your raid5 devices in degraded mode?? I
> >cannot be good for performance, and certainly isn't good for
> >redundancy!!! But I'm not complaining as you found a bug...
> 
> I am actually in the middle of the conversion process to raid5 but it takes a while
> I am to lazy :-) to get the next drive free to get raid5 into the
> fully running mode.  

If "necessity is the mother of invention", then I think laziness is
the father :-)

> 
> btw what does this message in boot.msg mean?
> 
> <4>raid5: switching cache buffer size, 4096 --> 1024
> <4>raid5: switching cache buffer size, 1024 --> 4096

The raid5 module maintains a stripe cache. The width of this cache
needs to be the same as the size of requests that are received.
The initial default size if 4096.
When you mkfs or fsck, the I/O requests that arrive are 1024 bytes
long, so the cache is flushed and rebuilt with a different size.
After you mount a filesystem, requests start coming at filesystem
blocksize, which is typically 4096 bytes.
If you happen to use LVM to partition a raid5 device, and have a
1K-block filesystem in one partition and a 4k-block filesystem in
another, then requests of different sizes will arrived mixed together
and the stripe cache will constantly be flushed and rebuilt and you
will gets lots of these messages together with a performance hit as
lots of requests will get serialised by the cache flushing.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
