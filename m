Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284296AbRLEMMS>; Wed, 5 Dec 2001 07:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284290AbRLEMMI>; Wed, 5 Dec 2001 07:12:08 -0500
Received: from mons.uio.no ([129.240.130.14]:6888 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284300AbRLEMMC>;
	Wed, 5 Dec 2001 07:12:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NFS Performance on Linux 2.2.19 (RedHat version) -- lstat64() ?
In-Reply-To: <OFEE87D44A.D1899606-ON85256B19.00026956@ma.lycos.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 05 Dec 2001 13:11:58 +0100
In-Reply-To: <OFEE87D44A.D1899606-ON85256B19.00026956@ma.lycos.com>
Message-ID: <shsk7w1hnn5.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Joe Pranevich <Joe.Pranevich@corp.terralycos.com> writes:

     > but not in a precise testing environment. Where my confusion
     > comes in is that a simple "ls" against a directory with a
     > couple files takes approximately 4-5 times as long under Linux
     > as on Solaris. Doing a "strace -c" on the ls process shows that
     > nearly all of the time is being spent in lstat64(). (And yes, I
     > was using "ls --color=none" :) ) (Our application does a lot of
     > similar operations, so this is a valid test.)

Hi,

  Solaris is currently more efficient than we are when it comes to
filehandle and attribute caching, but together with Chuck Lever, we
worked hard over the summer to even the odds.

  My main suspect for your report is the NFSv3 operation
READDIRPLUS. Whereas ordinary NFSv2/v3 READDIR returns only the
filename + inode number for each directory entry, READDIRPLUS also
returns the NFS filehandle and full file attributes. With proper
caching, this is sufficient to save an entire LOOKUP RPC call per file
when you get to the stat() calls...

  I do have patches that you can test, though unfortunately only for
the 2.4. series. A backport to the 2.2.x series should be possible if
you're able and willing, but my own schedule unfortunately won't
permit it.
As far as I know, the 2.4 patches can be considered `production
quality' (meaning that I haven't seen any bugs reported over the last
couple of months), and I've been using them in production on our own
machines.

If you are interested, please first apply the attribute cache
improvements in

  http://www.fys.uio.no/~trondmy/src/2.4.16/linux-2.4.15-cto.dif

and then the readdirplus implementation in

  http://www.fys.uio.no/~trondmy/src/2.4.16/linux-2.4.15-rdplus.dif

Cheers,
   Trond
