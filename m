Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSIFJaD>; Fri, 6 Sep 2002 05:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSIFJaD>; Fri, 6 Sep 2002 05:30:03 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39441 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318428AbSIFJaB>; Fri, 6 Sep 2002 05:30:01 -0400
Message-ID: <3D7876DB.4C0BBF1@aitel.hist.no>
Date: Fri, 06 Sep 2002 11:35:23 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Chuck Lever <cel@citi.umich.edu>, trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever wrote:
> 
> On Thu, 5 Sep 2002, Andrew Morton wrote:
> 
> > That all assumes SMP/preempt.  If you're seeing these problems on
> > uniproc/non-preempt then something fishy may be happening.
> 
> sorry, forgot to mention:  the system is UP, non-preemptible, high mem.
> 
> invalidate_inode_pages isn't freeing these pages because the page count is
> two.  perhaps the page count semantics of one of the page cache helper
> functions has changed slightly.  i'm still diagnosing.
> 
> fortunately the problem is deterministically reproducible.  basic test6,
> the readdir test, of 2002 connectathon test suite, fails -- either a
> duplicate file entry or a missing file entry appears after some standard
> file creation and removal processing in that directory.  the incorrect
> entries occur because the NFS client zaps the directory's page cache to
> force the next reader to re-read the directory from the server.  but
> invalidate_inode_pages decides to leave the pages in the cache, so the
> next reader gets stale cached data instead.

Perhaps this explains my nfs problem. (2.5.32/33 UP, preempt, no
highmem)
Soemtimes, when editing a file on nfs, the file disappears
from the server.  The client believes it is there 
until an umount+mount sequence.  It doesn't happen
for all files, but it is 100% reproducible for those affected.

Editing changes the directory when the editor makes a backup
copy, the old directory is kept around wrongly, and so the
save into the existing file silently fails because
wrong directory information from cache is used?

Helge Hafting
