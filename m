Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268784AbRHBFwc>; Thu, 2 Aug 2001 01:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268790AbRHBFwW>; Thu, 2 Aug 2001 01:52:22 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:35456 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268784AbRHBFwM>; Thu, 2 Aug 2001 01:52:12 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roger Abrahamsson <hyperion@gnyrf.net>
Date: Thu, 2 Aug 2001 15:52:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15208.60042.84240.269386@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: resizing of raid5?
In-Reply-To: message from Roger Abrahamsson on Wednesday August 1
In-Reply-To: <996657922.3b67cb02ba717@stargate.gnyrf.net>
	<15207.63232.611617.37794@notabene.cse.unsw.edu.au>
	<996685021.3b6834dd0829d@stargate.gnyrf.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 1, hyperion@gnyrf.net wrote:
> Quoting Neil Brown <neilb@cse.unsw.edu.au>:
> 
> > 
> > The only way to resize a raid5 array is to back up, rebuild, and
> > re-load.  Any attempt to re-organise the data, or the linkage, to
> > avoid this would be more trouble that it is worth.
> > 
> > NeilBrown
> 
> Well, the problem is that it's not that easy when you want to backup say 200GB
> of data to find anyone that can hold it for the day while you do it. Well, at
> least do it without charge :)
> Having things offline for up to a few days while you do the rebuild is okay for
> my case, but the offloading the data is not. If I have understood md and raid5,
> you create blocks of a fixed size, and calculate the checksum on each "stripe".
> To rebuild this looks a bit like disk defragmentation to me, or am I totally
> wrong here?

Hmm.  Your backup strategy is ????

Yes, you could it.  It would probably be slower that writting to tape
and restoring, but if you don't have a tape......

You would find it very difficult to maintain safety in the event of
failure during the re-org process, but if you are willing to risk that
you could certainly write a fairly stright forward program to do it.

Suppose you are reconfiguring from a N drive array to an M drive
array, and both the old and the new array use a chunk size of C.

Then choose a number X such that the staging area that you have
(either RAM or some other drive) can contain (N-1)*(M-1)*C*X.

e.g. 64K chunks, 7 to 8 drives, 10 Gig disc space:

 X = floor (10240/6/7/64) = 3

If you don't have enough space to stage N*M*C you can still do it but
it will be much more fiddly.

Then read X*N*M*C of the drive using the N drive layout into the
staging area.  Then write it back out using the M drive layout.
Repeat until done.
You don't need to worry about calculating parity when writing out as
you can get the raid5 module to do that automatically when you tell it
about the new array.

If you (or anyone else) would like to try writting code to do this, I
would be happy to review, comment, and test.  You could probably even
do it reasonably well in perl...

NeilBrown
