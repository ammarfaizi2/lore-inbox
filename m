Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUATUDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUATUDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:03:21 -0500
Received: from us02smtp1.synopsys.com ([198.182.60.75]:64401 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S265788AbUATUDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:03:14 -0500
Message-ID: <400D897C.A5439DFE@synopsys.com>
Date: Tue, 20 Jan 2004 15:03:08 -0500
From: Chris Petersen <Chris.Petersen@synopsys.com>
Reply-To: Chris.Petersen@synopsys.com
Organization: Synopsys, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org,
       Chris.Petersen@synopsys.COM
Subject: Re: Awful NFS performance with attached test program
References: <20040119211649.GA20200@ncsu.edu>
		 <1074549226.1560.59.camel@nidelv.trondhjem.org>
		 <20040120132803.GA2830@ncsu.edu> <1074607946.1871.37.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> jlnance@unity.ncsu.edu:
> > I must admit that I am.  I could see that it would take somewhat longer
> > because a logicial way for the kernel to implement this would be as a
> > read-modify-write operation.  So a 2X slowdown would not supprise me.
> > But the slowdown is more than 10X, and that does.
> 
> No... Do the math: your program is literally writing to
> 5000*4096/PAGE_SIZE times as many pages in the fseek()+fwrite() case.

Sorry.  I believe it may be you who needs to check their math.

    Case 1:  for(i=0; i<100*1024; i++) {
               fwrite(buff, 4096, 1, fp);
             }

    Case 2:  /* sizeof(buff) = 4096.  sizeof(i) = 4 */
             for(i=0; i<100*1024*sizeof(buff); i += 5000) {
               fseek(fp, i, SEEK_SET);
               fwrite(&i, sizeof(i), 1, fp);
             }

In the first case, he's writing 102,400 chunks of 4096 bytes each (for a
grand total of 419,430,400 bytes...or 400MB).

In the second case, he's performing 83,886 seeks and writing 83,886
4-byte ints (only 1 int per seek), OVER THE SAME 400MB REGION.  As such,
he cannot be writing to "more" ("times as many") pages in the second case
as he does in the first.  In fact, due to the spacing of the seeks, he
can occasionally skip over some pages.  He's simply writing over the
same region in a more sparse, incremental-but-non-contiguous, manner.

> You are creating 5000 times as many non-contiguous NFS write requests
> that need to be flushed out somehow.

Based on the previous logic, he is actually creating 83,886 non-contiguous
write requests(!).  :^)

> > Also, for what its worth, Solaris performs like this:
> >
> >     flame> ./a.out
> >     Creating file: 3.886 seconds
> >     Updating file: 1.259 seconds
> >
> > While Linux performs like this:
> >
> >     jesse> ./a.out
> >     Creating file: 43.042 seconds
> >     Updating file: 555.796 seconds

A-HA!  Now we're getting somewhere.  This is the crux of the issue.
The bottom line question is, to put it bluntly:

    Why does Solaris perform so well, and Linux suck so bad?

Why does Solaris take only 1.3 seconds to do what Linux takes ~10 minutes
to do?!?

Ironically, the "update file" section on Solaris takes LESS time than it
does to create it...which in some ways makes sense:  The app is only writing
335,544 bytes in the second phase compared to 400M in the first (creation)
phase.

> > Both machines are writing to the same directory (not at the same time) on
> > an x86_64 Linux server running a kernel which identifies itself as
> > 2.4.21-4.ELsmp.  The network connection between the Solaris machine and
> > the NFS server actually seems to be slightly slower than that between
> > the Linux machine and the NFS server:
> 
> Oh. It's an x86_64? You didn't say originally, so I assumed an ia32. OK,
> I believe my modified math above is correct.

To clarify:  The test program (a.out) is NOT running on x86_64, rather the
remote file server is x86_64 in both (flame and jesse) testcases.  The
testfile created by code (from a previous post) resides on a remote
machine (sledge).  'sledge' is x86_64; 'flame' is sparc64; and 'jesse' is
ia32.

-chris

-----------------------------------------------------------------
Chris M. Petersen                                cmp@synopsys.com
Sr. R&D Engineer

Synopsys, Inc.                                    o: 919.425.7342
1101 Slater Road, Suite 300                       c: 919.349.6393
Durham, NC  27703                                 f: 919.425.7320
-----------------------------------------------------------------
