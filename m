Return-Path: <linux-kernel-owner+w=401wt.eu-S1161100AbXAEOI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbXAEOI1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbXAEOI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:08:27 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:37882 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161100AbXAEOIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:08:25 -0500
Date: Fri, 5 Jan 2007 15:08:24 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz>
References: <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
 <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
 <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
 <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
 <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Well, sort of.  Samefile without keeping fds open doesn't have any
>>> protection against the tree changing underneath between first
>>> registering a file and later opening it.  The inode number is more
>>
>> You only need to keep one-file-per-hardlink-group open during final
>> verification, checking that inode hashing produced reasonable results.
>
> What final verification?  I wasn't just talking about 'tar' but all
> cases where st_ino might be used to check the identity of two files at
> possibly different points in time.
>
> Time A:    remember identity of file X
> Time B:    check if identity of file Y matches that of file X
>
> With samefile() if you open X at A, and keep it open till B, you can
> accumulate large numbers of open files and the application can fail.
>
> If you don't keep an open file, just remember the path, then renaming
> X will foil the later identity check.  Changing the file at this path
> between A and B can even give you a false positive.  This applies to
> 'tar' as well as the other uses.

And does it matter? If you rename a file, tar might skip it no matter of 
hardlink detection (if readdir races with rename, you can read none of the 
names of file, one or both --- all these are possible).

If you have "dir1/a" hardlinked to "dir1/b" and while tar runs you delete 
both "a" and "b" and create totally new files "dir2/c" linked to "dir2/d", 
tar might hardlink both "c" and "d" to "a" and "b".

No one guarantees you sane result of tar or cp -a while changing the tree. 
I don't see how is_samefile() could make it worse.

Mikulas

> Miklos
>
