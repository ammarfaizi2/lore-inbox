Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUATVuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUATVuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:50:52 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:10645
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265799AbUATVus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:50:48 -0500
Subject: Re: Awful NFS performance with attached test program
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris.Petersen@synopsys.com
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <400D897C.A5439DFE@synopsys.com>
References: <20040119211649.GA20200@ncsu.edu>
	 <1074549226.1560.59.camel@nidelv.trondhjem.org>
	 <20040120132803.GA2830@ncsu.edu>
	 <1074607946.1871.37.camel@nidelv.trondhjem.org>
	 <400D897C.A5439DFE@synopsys.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074635444.5368.286.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 16:50:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 20/01/2004 klokka 15:03, skreiv Chris Petersen:
> In the second case, he's performing 83,886 seeks and writing 83,886
> 4-byte ints (only 1 int per seek), OVER THE SAME 400MB REGION.  As such,
> he cannot be writing to "more" ("times as many") pages in the second case
> as he does in the first.  In fact, due to the spacing of the seeks, he
> can occasionally skip over some pages.  He's simply writing over the
> same region in a more sparse, incremental-but-non-contiguous, manner.

Duh... You're right. Sorry...

> Why does Solaris take only 1.3 seconds to do what Linux takes ~10 minutes
> to do?!?
> Ironically, the "update file" section on Solaris takes LESS time than it
> does to create it...which in some ways makes sense:  The app is only writing
> 335,544 bytes in the second phase compared to 400M in the first (creation)
> phase.

2 comments:

  1) your testcase is missing an fflush() call before the gettimeofday()
in case 2

  2) In any case, fflush() does not actually ensure the data has been
written out to disk: it just schedules the writes (man 3 fflush). If you
actually want to measure write performance, you need to add fsync()
after the fflush().

So here's the difference:


-------------------------
On a Solaris machine:

Without fflush+fsync:
bash-2.05$ ./a.out
Creating file: 9.933 seconds
Updating file: 4.382 seconds

With fflush, but no fsync:
bash-2.05$ ./a.out
Creating file: 9.852 seconds
Updating file: 1.459 seconds

With fflush+fsync:
bash-2.05$ ./a.out
Creating file: 9.915 seconds
Updating file: 10.639 seconds
------------------------
Now on Linux 2.6.1-mm3:

Without fflush+fsync:
[trondmy@hammerfest gnurr]$ ./a.out
Creating file: 3.475 seconds
Updating file: 0.561 seconds

With fflush, but no fsync:
[trondmy@hammerfest gnurr]$ ./a.out
Creating file: 3.275 seconds
Updating file: 1.642 seconds

With fflush+fsync:
[trondmy@hammerfest gnurr]$ ./a.out
Creating file: 3.780 seconds
Updating file: 4.618 seconds
-----------------------------

Surprise! Linux and Solaris show exactly the same behaviour.

As I said before in 2.4.x we have a hard limit of 256 outstanding
requests before we have to wait on requests to complete. Remove that
limit, and all is well...

Cheers,
  Trond
