Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136113AbREJMAl>; Thu, 10 May 2001 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136050AbREJMAb>; Thu, 10 May 2001 08:00:31 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136087AbREJMAU>;
	Thu, 10 May 2001 08:00:20 -0400
MIME-Version: 1.0
Message-ID: <15098.26967.99796.538394@charged.uio.no>
Date: Thu, 10 May 2001 12:11:35 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <Pine.LNX.4.21.0105092045410.15984-100000@freak.distro.conectiva>
In-Reply-To: <20010510031652.G2506@athlon.random>
	<Pine.LNX.4.21.0105092045410.15984-100000@freak.distro.conectiva>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

     > I suggested the removal of I_DIRTY_PAGES check because the
     > current behaviour of munmap seems to be synchronous (1), so I
     > guess you _always_ want it to be synchronous.

Yes. The NFS concept of close-to-open cache consistency requires you
to flush out all writes upon file close(). In this case, the usual
nfs_wb_file() + error reporting in nfs_release() won't catch anything
that's been put out using writepage(), because the latter can't mark
the requests using the struct file. This means we have to do something
special for mmap...

    >> Another thing (completly unrelated to the above issues) that I
    >> noticed while looking over this nfs code is that the
    >> __sync_one() for example called by generic_file_write(O_SYNC)
    >> will recall fdatasync but no nfs_wb_all is put before the
    >> fdatawait, and I'm not sure that the nfs_sync_page called by
    >> the fdatawait is enough to rapidly flush the writepaged stuff
    >> to the nfs server. nfs_sync_page apparently only cares about
    >> speculative reads, not at all about committing writebacks. It
    >> would look much saner to me if nfs_sync_page also does a
    >> nfs_wb_all() on the inode, so that the ->sync_page callback
    >> gets the same semantics it has for the real filesystems.

     > Looks sane and will probably makes things faster.

This should normally not be needed. Firstly there is logic in the
write code to send off a request as soon as we have scheduled wsize
bytes worth of data. Secondly there is the 'flushd' daemon that exists
in order to time out requests, and to flush them out if the first
logic fails to do so.

That said, the __sync_one() thing is of interest to me. You'll notice
that our lack of a write_inode() means that we don't currently support
the sync() system call. Furthermore, we do O_SYNC through the slower
method of actually making our commit_write() method make a synchronous
call.
I have a patch that implements write_inode() and removes our current
O_SYNC code on

   http://www.fys.uio.no/~trondmy/src/linux-2.4.4-write_inode.dif

It's been running for a month or two on my systems, but I've been wary
of sending it to Linus as it's not, strictly speaking, a bugfix.

Cheers,
   Trond
