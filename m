Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSHCWtj>; Sat, 3 Aug 2002 18:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318034AbSHCWtj>; Sat, 3 Aug 2002 18:49:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25860 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318008AbSHCWti>; Sat, 3 Aug 2002 18:49:38 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: large file IO starving ls -l
Date: Sat, 3 Aug 2002 22:53:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aihmso$2m2$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0208032253260.23040-100000@pc40.e18.physik.tu-muenchen.de>
X-Trace: palladium.transmeta.com 1028415166 11818 127.0.0.1 (3 Aug 2002 22:52:46 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Aug 2002 22:52:46 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0208032253260.23040-100000@pc40.e18.physik.tu-muenchen.de>,
Roland Kuhn  <rkuhn@e18.physik.tu-muenchen.de> wrote:
>
>Now the question is: who keeps ls from returning? The command never hits 
>the disk (reads in above histogram do not increase), but stays for many 
>seconds (up to one minute) in state D.

ext2 used to have similar issues with the superblock lock - where things
like block allocation (very much in the write path) would grab the
superblock lock, and completely destroy interactive feel even for
processes that didn't need to do IO, because the superblock lock was
often grabbed even if the data was actually cached (sb locking needed
just to _look_up_ the physical block so that you could look up the
cached data in the buffer cache). 

Al Viro largely fixed in for ext2, which now uses lock_super() a lot
less. But a lot of filesystems are based on the old ext2 locking, and
may have inherited some of the worst parts..

		Linus
