Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269545AbRHCSfp>; Fri, 3 Aug 2001 14:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269547AbRHCSff>; Fri, 3 Aug 2001 14:35:35 -0400
Received: from [63.209.4.196] ([63.209.4.196]:52489 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269545AbRHCSfX>; Fri, 3 Aug 2001 14:35:23 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Date: Fri, 3 Aug 2001 18:34:14 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9keqr6$egl$1@penguin.transmeta.com>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu>
X-Trace: palladium.transmeta.com 996863687 14171 127.0.0.1 (3 Aug 2001 18:34:47 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Aug 2001 18:34:47 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>
>
>On Fri, 3 Aug 2001, Daniel Phillips wrote:
>
>> Are you saying that there may not be a ".." some of the time?  Or just 
>> that it may spontaneously be relinked?  If it does spontaneously change 
>> it doesn't matter, you have still made sure there is access by at least 
>> one path.
>> 
>> The trouble with doing this in userland is, the locked chain of dcache 
>> entries isn't there.
>
>There is no _locked_ chain. And if you want to grab the locks on all
>ancestors - think again. It means sorting the inodes by address _and_
>relocking if any of them had been moved while you were locking the
>previous ones. I absolutely refuse to add such crap to the tree and I
>seriously suspect that Linus and Alan will do the same.

Note that while there is no "absoilutely correct" thing here, I think
the right thing to do (as in "do what the user _expects_ you to do")
would be fairly simple to implement with a simple

	fsync(int fd)
	{
		dentry = fdget(fd);
		do_fsync(dentry);
		for (;;) {
			tmp = dentry;
			dentry = dentry->d_parent;
			if (dentry == tmp)
				break;
			do_fdatasync(dentry);
		}
	}

Add dcount increments as needed (and they _are_ needed, to make sure
that we don't hold on to a dentry while the child has been moved
somewhere else and the dentry now has a zero count). And we only need to
sync up to the closest mount-point, not the global root.

Does this guarantee that we fsync the whole path in the presense of
concurrent renames? No. That's a user problem, why should we care? He
should fsync his other renames too, he didn't ask us to fsync them.

And we don't care about any other paths that the file may have. We're
syncing the path that the user opened, and no others. Again, if the user
opened another path, he should have synced _that_ one.

		Linus
