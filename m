Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSFUB4G>; Thu, 20 Jun 2002 21:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSFUB4F>; Thu, 20 Jun 2002 21:56:05 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:61128 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316167AbSFUB4E>; Thu, 20 Jun 2002 21:56:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?ISO-8859-1?Q?Micha=B3?= =?ISO-8859-1?Q?Cie=B6lakiewicz?= 
	<Michal.Cieslakiewicz@comarch.pl>
Date: Fri, 21 Jun 2002 11:54:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15634.34628.841757.197117@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: [2.2.21] nfsd crash & workaround
In-Reply-To: message from =?ISO-8859-1?Q?Micha=B3?= =?ISO-8859-1?Q?Cie=B6lakiewicz?= on Thursday June 20
References: <20020620111209.0b55c5a4.Michal.Cieslakiewicz@comarch.pl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday June 20, Michal.Cieslakiewicz@comarch.pl wrote:
> Hi all!
> 
> When accessing NFS (server on a Linux box running 2.2.21, client on Solaris 8) I've encountered a following problem: attempt to copy a not-so-small file (around 150MB) from cdrom leads to nfsd crash after some time (depends on transport and network load) with file being only partially copied. The crash occurs regardless of either of NFS version (v2,v3) or transport (UDP,TCP).
> Cause this problem never happened to me on 2.2.20, I spent some time to eventually find a 'solution' which is as simple as using mm/vmscan.c from 2.2.20 (changing the position of a call to shrink_dcache_memory() in fact). I'm not a kernel hacker (not yet :) ) but looks like VM issue rather than NFS to me.
> Below I post a standard lk bug report (assumig NFS v2 over UDP when not stated otherwise).
> 

This surpised me a little but not a lot.

If you are exporting a CDROM, then I assume it is an ISOfs filesystem.

The current ISOfs code doesn't support lookup("..") properly (it
appears to try, but it is all wrong) so if something falls out of
cache, you can loose.

If you aren't already, try exporting with "no_subtree_check".  This
will be more reliable as it doesn't bother with the ".." lookups as
much. 

The reason that it surprised me as little, rather than not-at-all is
that you get an oops, and you getan oops which seems to be miles from
the filesystem or NFS code.  Possibly the current code for ".."
actually corrupts memory and that only hits later.

I have no plans to "fix" ISOfs.  If someone else wants to I can be
more specific about the problem, the requirements, and the approach.

Your VM hack presumably leaves things in cache for longer and so you
don't actually hit the problem.

NeilBrown
