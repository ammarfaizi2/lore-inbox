Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWCaNVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWCaNVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWCaNVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:21:32 -0500
Received: from unthought.net ([212.97.129.88]:26893 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S932119AbWCaNVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:21:32 -0500
Date: Fri, 31 Mar 2006 15:21:31 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331132131.GI9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net> <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143810392.8096.11.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 08:06:32AM -0500, Trond Myklebust wrote:
> On Fri, 2006-03-31 at 14:45 +0200, Jakob Oestergaard wrote:
> > On Fri, Mar 31, 2006 at 07:22:50AM -0500, Trond Myklebust wrote:
> > ...
> > > 
> > > Some nfsstat output comparing the good and bad cases would help.
> > 
> > Clean boot on 2.6.15 and 2.6.14.7, one run of nfsbench with
> > LEADING_EMPTY_SPACE=1.  I've skipped the NFS v2 stats because they're
> > all 0.
> 
> Why all the GETATTR calls?

That's the $1000 question I guess :)

> Are you running with 'noac' set?

I didn't set it, that's for sure :)  I got the option lines from
/proc/mounts, if there is any way I can get more/other information
please advise.

2.6.14.7:
 rw,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=...

2.6.15:
 rw,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=udp,addr=...

Except for some formatting (proto=udp insted of udp) I fail to see any
difference.

The way I see it, it seems like caching on the client side fails
completely if the read requests are not aligned (to some
buffer/block/page/whatever).

> I don't have a 2.6.15 kernel to run with, but on a recent git pull, I
> get a total of 6 GETATTR calls when I run your nfsbench program.

The performance regression is present on 2.6.16.1 too.

Do you have a released kernel you can test with (2.6.1[56].*), or can I
somehow get the kernel you're testing with, just so that we test on the
same kernel?

> The number of READ calls is 1, and the number of WRITE calls is 161 (I'm
> running with 64k wsize).

I can't set 64k wsize:

puffin:~# mount -o rw,wsize=65536,udp sparrow:/exported/joe /mnt
puffin:~# cat /proc/mounts 
...
sparrow:/exported/joe /mnt nfs rw,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=udp,addr=sparrow 0 0
puffin:~#

Server is running a patched 2.6.11.11 kernel - could that be what's
preventing me from 64k wsize?

What happens if you run with 32k rsize/wsize?

-- 

 / jakob

