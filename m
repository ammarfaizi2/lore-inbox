Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278337AbRJMRzb>; Sat, 13 Oct 2001 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278336AbRJMRzV>; Sat, 13 Oct 2001 13:55:21 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:16577
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S278338AbRJMRzN>; Sat, 13 Oct 2001 13:55:13 -0400
Date: Sat, 13 Oct 2001 13:55:25 -0400
From: Chris Mason <mason@suse.com>
To: Ricardo Galli <gallir@m3d.uib.es>, linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.12-ac1 dies (seems reiserfs)
Message-ID: <1998710000.1002995725@tiny>
In-Reply-To: <Pine.LNX.4.33.0110122323460.7693-100000@m3d.uib.es>
In-Reply-To: <Pine.LNX.4.33.0110122323460.7693-100000@m3d.uib.es>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, October 12, 2001 11:29:46 PM +0200 Ricardo Galli
<gallir@m3d.uib.es> wrote:

> This time linux has died when un-installing a debian package from a remote
> ssh terminal, so it might be related to ReiserFS.
> 
> There is no logs, sysrq didn't work neither.
> 
> Several files are corrupted:
> 
> linux:/var/log# dpkg -i "kernel-source*"
> dpkg: error processing kernel-source* (--install):
>  cannot access archive: No such file or directory
> Errors were encountered while processing:
>  kernel-source*
> 
> 
> (i tried to remove kernel-source-2.4.7 when the machine hung).

2.4.12-ac1 has a bug in the reiserfs writepage func.  It was actually
introduced (by us) back in 2.4.10-ac by a patch that merged in changes from
the pure linux kernel.  Anyway, check your logs for warnings from brelse.
If you've got apps running that hit writepage at all (vmware, staroffice,
some databases), you've probably hit this bug.

In ac1, alan dropped all the reiserfs patches he's been including to get
the -ac and the linus reiserfs code bases closer together, so there should
not be any other problems.  My test machine is tied up right now though, so
I haven't hammered on -ac yet.

I'd suggest grabbing reiserfsck 3.x.0k-pre10 and checking the FS.  I'd aslo
apply this (or wait for ac2).

Note, alan might fix this by merging the put_bh change in
end_buffer_io_async, in which case this patch will apply cleanly but be
completely wrong.  Check -ac2 carefully to see if it is still required
before using it there.  This is -ac specific, don't apply to pure linus
kernels.

-chris

--- linux-2412ac1/fs/reisefs/inode.c.orig        Wed Oct 10 13:33:24 2001
+++ linux-2412ac1/fs/reiser/fs/inode.c     Wed Oct 10 13:33:40 2001
@@ -2002,6 +2002,7 @@
     for(i = 0 ; i < nr ; i++) {
         bh = bhp[i] ;
        lock_buffer(bh) ;
+       get_bh(bh) ;
        set_buffer_async_io(bh) ;
        /* submit_bh doesn't care if the buffer is dirty, but nobody
        ** later on in the call chain will be cleaning it.  So, we






