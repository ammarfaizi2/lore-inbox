Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288804AbSAEM7u>; Sat, 5 Jan 2002 07:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288805AbSAEM7l>; Sat, 5 Jan 2002 07:59:41 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:42508 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S288804AbSAEM7W>; Sat, 5 Jan 2002 07:59:22 -0500
Date: Sat, 5 Jan 2002 04:59:23 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: Stephan von Krawczynski <skraw@ithnet.com>, <brownfld@irridia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C36BBAA.1010609@athlon.maya.org>
Message-ID: <Pine.LNX.4.33.0201050355300.11089-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Andreas Hartmann wrote:

> I don't like special test-programs. They seldom show up the reality.
> What we need is a kernel that behaves fine in reality - not in
> testcases.  And before starting the test, take care, that most of ram
> is already used for cache or buffers or applications.

OK, here's some pseduo-code for a real-world test case. I haven't had a
chance to code it up, but I'm guessing I know what it's going to do. I'd
*love* to be proved wrong :).

# build and boot a kernel with "Magic SysRq" turned on
# echo  1 > /proc/sys/kernel/sysrq
# fire up "nice --19 top" as "root"
# read "MemTotal" from /proc/meminfo

# now start the next two jobs concurrently

# write a disk file with "MemTotal" data or more in it

# perform a 2D in-place FFT of total size at least "MemTotal/2" but less
# than "MemTotal"

Watch the "top" window like a hawk. "Cached" will grow because of the
disk write and "free" will drop because the page cache is growing and
the 2D FFT is using *its* memory. Eventually the two will start
competing for the last bits of free memory. "kswapd" and "kupdated" will
start working furiously, bringing the system CPU utilization to 99+
percent.  At this point the system will appear highly unresponsive.

Even with the "nice --19" setting, "top" is going to have a hard time
keeping its five-second screen updates going. You will quite possibly
end up going to the console and doing alt-sysrq-m, which dumps the
memory status on the console and into /var/log/messages. Then if you do
alt-sysrq-i, which kills everything but "init", you should be able to
log on again.

I'm going to try this on my 512 MB machine just to see what happens, but
I'd like to see what someone with a larger machine, say 4 GB, gets when
they do this. I think attempting to write a large file and do a 2D FFT
concurrently is a perfectly reasonable thing to expect an image
processing system to do in the real world. A "traditional" UNIX would do
the I/O of the file write and the compute/memory processing of the FFT
together with little or no problem. But because the 2.4 kernel insists
on keeping all those buffers around, the 2D FFT is going to have
difficulty, because it has to have its data in core.

What's worse is if the page cache gets so big that the FFT has to start
swapping. For those who aren't familiar with 2D FFTs, they take two
passes over the data. The first pass will be unit strides -- sequential
addresses. But the second pass will be large strides -- a power of two.
That second pass is going to be brutal if every page it hits has to be
swapped in!

The solution is to limit page cache size to, say, 1/4 of "MemTotal",
which I'm guessing will have a *negligible* impact on the performance of
the file write. I used to work in an image processing lab, which is
where I learned this little trick for bringing a VM to its knees, and
which is probably where the designers of other UNIX systems learned that
the memory used for buffering I/O needs to be limited :). There's
probably a VAX or two out there still that shudders when it remembers
what I did to it. :))

-- 
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

