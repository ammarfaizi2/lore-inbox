Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281492AbRKTX4k>; Tue, 20 Nov 2001 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281493AbRKTX4a>; Tue, 20 Nov 2001 18:56:30 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21929 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281492AbRKTX4U>; Tue, 20 Nov 2001 18:56:20 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Date: Wed, 21 Nov 2001 10:56:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15354.60821.947156.36802@notabene.cse.unsw.edu.au>
Cc: Andreas Dilger <adilger@turbolabs.com>, Jason Tackaberry <tack@auc.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: File size limit exceeded with mkfs
In-Reply-To: message from Matti Aarnio on Tuesday November 20
In-Reply-To: <1006272138.1263.3.camel@somewhere.auc.ca>
	<20011120113316.R1308@lynx.no>
	<1006288154.1863.0.camel@somewhere.auc.ca>
	<20011120224324.O2682@mea-ext.zmailer.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 20, matti.aarnio@zmailer.org wrote:
> On Tue, Nov 20, 2001 at 03:29:14PM -0500, Jason Tackaberry wrote:
> > Hi Andreas,
> > 
> > On Tue, 2001-11-20 at 13:33, Andreas Dilger wrote:
> ... 
> > > Can you please try some intermediate kernels (2.4.10 would be a good
> > > start, because it had some major changes in this area, and then go
> > > forward and back depending whether it works or not).
> > 
> > 2.4.10 does NOT work.
> > 2.4.9 DOES work.
> 
>    And noting that  mkfs  and  fsck  operate on block DEVICE, no such
> limits should be applied anyway.  Right ?

No.  2.4.10 introduced blkdev-in-pagecache which made blockdev writes
succeptible to maximum file limits. (ulimit -f)

As a concession to backwards compatability, O_LARGEFILE is always used
when opening a block device.
Whoever ulimit still will stop you.

Some versions of libc think the file size limit is signed, so the max
you can set it to is 2^31-1.
But the kernel thinks it is unsigned, and assumes anything less than
2^32-1 is a real limit (2^32-1 is treated as "unlimited").

So if you are under the effect of default resource limits, then it
works.  If some parent process has tried to set the file limit to
"unlimited" it will have inadvertantly had exactly the reverse effect.

On my Debian/potato machines, I find that I hit the limit if I login
on the console, but if I ssh in as root, it works fine.

I think Debian/woody has a new enough libc that this isn't a problem.

NeilBrown

