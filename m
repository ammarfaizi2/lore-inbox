Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbRE3HZv>; Wed, 30 May 2001 03:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbRE3HZl>; Wed, 30 May 2001 03:25:41 -0400
Received: from pat.uio.no ([129.240.130.16]:39907 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261357AbRE3HZh>;
	Wed, 30 May 2001 03:25:37 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Gergely Tamas <dice@mfa.kfki.hu>, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: OOPS with 2.4.5 [kernel BUG at inode.c:486]
In-Reply-To: <Pine.GSO.4.21.0105291327120.10843-100000@weyl.math.psu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 30 May 2001 09:25:26 +0200
In-Reply-To: Alexander Viro's message of "Tue, 29 May 2001 13:30:11 -0400 (EDT)"
Message-ID: <shssnhn47tl.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > On Tue, 29 May 2001, Gergely Tamas wrote:
 
    >> Warning (compare_maps): mismatch on symbol partition_name ,
    >> ksyms_base says c01c4020, System.map says c0154160.  Ignoring
    >> ksyms_base entry kernel BUG at inode.c:486!

     > [snip]

     > _Lovely_. NFS, apparently on revalidate path, doesn't care to
     > hold on the unhashed inode until its pages are gone.

     > Trond?

My guess is that is a result of the 'magic nfs path' in iput. It
appears to be calling clear_inode() without truncating the pages
first.

The reason we haven't seen this before is that we had 'force_delete'
that would always set i_nlink = 0. Unfortunately force_delete is toxic
to mmap(), as it will discard any dirty pages rather than flushing
them to storage, so it was removed in the 2.4.5-pre series...

Al: Is there any reason why the cases

  if (!inode->i_nlink)

and the 'magic nfs path' should be treated differently? Personally,
I'd rather prefer to merge the 2.

The unhashing of the inode is after all only done in NFS when we
believe the inode to be stale and hence we want to throw it out of the
cache ASAP (= same as setting i_nlink to zero but without races).

Cheers,
   Trond
