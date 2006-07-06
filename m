Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWGFIZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWGFIZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWGFIZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:25:51 -0400
Received: from 1wt.eu ([62.212.114.60]:54793 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964994AbWGFIZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:25:50 -0400
Date: Thu, 6 Jul 2006 10:25:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Linux 2.4.33-rc2
Message-ID: <20060706082539.GA28233@1wt.eu>
References: <20060621192756.GB13559@dmt> <20060703220736.GA272@1wt.eu> <0e6ma2961ro2evtrnacgmla7j52j738q76@4ax.com> <20060705205137.GA25913@1wt.eu> <dhdpa2pat94ssieedvjaj2m1n8265t19at@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhdpa2pat94ssieedvjaj2m1n8265t19at@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Thu, Jul 06, 2006 at 05:42:17PM +1000, Grant Coady wrote:
> On Wed, 5 Jul 2006 22:51:37 +0200, Willy Tarreau <w@1wt.eu> wrote:
(...)
> >after a full day of stress-test of multiple parallel tar xUf, and ffsb at
> >full CPU load, I could not reproduce the problem on the exact same kernel
> >I first saw it on. So I think I had bad luck and the problem is not related
> >to the vfs_unlink() patch, so unless anyone else reports a problem or tells
> >us why it is right or wrong, it would seem reasonable to keep it as it is
> >in -rc2.
> 
> Hi Willy,
> 
> Got this with unpatched -rc2, tosh is NFS server, niner is client:
> 
> grant@niner:/home/nfstest$ ls -l
> total 228474
> drwxr-xr-x  19 grant wheel       680 2006-03-20 16:53 linux-2.6.16/
> -rw-r--r--   1 grant wheel 233953280 2006-07-05 18:27 linux-2.6.16.tar
> drwxr-xr-x  19 grant wheel       680 2006-03-20 16:53 linux-2.6.16b/
> grant@niner:/home/nfstest$ x=0; while [ ! $(diff -rq linux-2.6.16 linux-2.6.16b) ]; do ((x++)); echo "trial $x"; rm -rf linux-2.6.16b; mv linux-2.6.16 linux-2.6.16b; tar xf linux-2.6.16.tar; done
> trial 1
> ...
> trial 29
> rm: cannot remove directory `linux-2.6.16b/drivers/cdrom': Directory not empty
> -bash: [: too many arguments
> grant@niner:/home/nfstest$ ls -l
> total 228474
> drwxr-xr-x  19 grant wheel       680 2006-03-20 16:53 linux-2.6.16/
> -rw-r--r--   1 grant wheel 233953280 2006-07-05 18:27 linux-2.6.16.tar
> drwxr-xr-x   4 grant wheel       104 2006-07-06 11:01 linux-2.6.16b/
> grant@niner:/home/nfstest$ rm -rf linux-2.6.16b/
> 
> The 'rm -rf linux-2.6.16b' completed okay, a mystery?  

you might have had a '.nfs0000*' file inthe directory which prevented rmmod
from working, but it was finally removed by the rm -rf.

> This is with two slow (500MHz) boxen with -rc2.
> Only idea I get from logs is during the test:
> 
> Jul  5 19:01:19 niner kernel: nfs: server tosh not responding, still trying
> Jul  5 19:01:19 niner kernel: nfs: server tosh OK
> 
> ... about one pair each 2 to 5 mins
> 
> Jul  6 11:16:08 niner kernel: nfs: server tosh not responding, still trying
> Jul  6 11:16:08 niner kernel: nfs: server tosh OK
> Jul  6 11:26:57 niner -- MARK --
> Jul  6 11:46:57 niner -- MARK --

I get this if the server spends too much time writing data back to the disks.
Doing this on the server fixed the problem for me :

# echo 50 25000 0 0 100 100 60 45 0 >/proc/sys/vm/bdflush

> Other pair of boxen with patched -rc2 completed 146 trials overnight along 
> with compiling 2.4 kernel over NFS as well since morning, 64 completed. 
> No 'server not responding messages' logged.

Was it on the same server and while other clients saw the server disappear ?

> I'll change the two running boxen to straight -rc2 and see if catch 
> anything.  

OK, similarly, it might be interesting to apply your patch to niner to see
if the rmmod error happens again.

> Grant.

Thanks for your tests,
Willy

