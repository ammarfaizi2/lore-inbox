Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSFQTot>; Mon, 17 Jun 2002 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSFQTos>; Mon, 17 Jun 2002 15:44:48 -0400
Received: from palrel12.hp.com ([156.153.255.237]:48084 "HELO palrel12.hp.com")
	by vger.kernel.org with SMTP id <S316960AbSFQTor>;
	Mon, 17 Jun 2002 15:44:47 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0C35DF85@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'andrea@suse.de'" <andrea@suse.de>, "'lord@sgi.com'" <lord@sgi.com>,
       "'akpm@zip.com.au'" <akpm@zip.com.au>,
       "'neilb@cse.unsw.edu.au'" <neilb@cse.unsw.edu.au>
Subject: poor nfs server performance with 2.4.19-preX kernels vs. 2.4.17. 
	 Due to XFS and VM?
Date: Mon, 17 Jun 2002 12:44:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I'm working on improving NFS server performance.  I've been able to get
satisfactory performance with the 2.4.17 kernel, NFSD BKL removal code, and
3GB kernel address space patches.  However, when I try to migrate to the
2.4.19-preX kernels, I get nothing but pain and suffering.  I'm not allowed
to post SPEC numbers, so I'm showing percentages versus my highest
performing test run.  I haven't had the opportunity to watch every test as
it runs, but have seen the 2.4.19-preX kernel tests spend a lot of time in
shrink_cache schedule() call right before the tests timeout.

All of the tests were run on the following hardware:

4 PIII Xeon processors
6GB RAM
SPEC SFS NFS test v3.0
2 Gigabit network connections to SPEC clients
many Fiber channel hard drives

I tested the following kernels:

2.4.17
2.4.19-pre9
2.4.19-pre10
2.4.19-pre10aa2 (config'd to use 3GB kernel address space)

I patch the kernel with a collection of the following patches:

- nfsd_bkl_removal 022702:
http://marc.theaimsgroup.com/?l=linux-nfs&m=101485118003322&w=2 (remove the
BKL from the nfsd code, add TCP support to nfsd, clean up the RPC stack
code)

- nfsd_bkl_removal 020702:
http://marc.theaimsgroup.com/?l=linux-nfs&m=100888008825015&w=2  (same
intention as nfsd_bkl_removal 022702, but doesn't include the NFSD TCP code
or RPC stack cleanup code)

- 3GB kernel address space:
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre7
aa2/00_3.5G-address-space-4
   http://www.linuxhq.com/kernel/v2.4/unofficial/patch200202/89.html (give
the kernel 3GB of the virtual address space)

- akpm_nuke_buffers:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102226904021069&w=2 (hunt
down buffer_heads and kill them)

- XFS taken from the XFS CVS tree
(http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/) on Feb 7 2002, June 3
2002, and June 11 2002.  2.4.19-pre10aa2 already includes XFS, but I don't
know its vintage.

The only modifications to any /proc tunables were to increase the UDP stack
size (/proc/sys/net/core/rmem_[default|max]  to 512K


And here are the results:

2.4.17 nfsd_bkl_removal 022702, 3GB kernel address space, XFS 020702
- baseline

2.4.17 nfsd_bkl_removal 022702, XFS 020702
- 50% of baseline

2.4.19-pre9 nfsd_bkl_removal 022702, XFS 060302 
- 0% of baseline, would not run

2.4.19-pre10 xfs 020702
- 45% of baseline, probably would have kept running, but I stopped the test
after max throughput was reached so I could try another configuration

2.4.19-pre10 xfs 061102
- 20% of baseline before timeout, lots of processes stuck in shrink_cache
schedule() call

2.4.19-pre10 xfs 061102, akpm_nuke_buffers
- 30% of baseline before timeout

2.4.19-pre10 xfs 061102, nfsd_bkl_removal 020702, akpm_nuke_buffers
- 10% of baseline before timeout

2.4.19-pre10 xfs 061102, nfsd_bkl_removal 020702
- 20% of baseline before timeout

2.4.19-pre10aa2 (3GB kernel address space)
- 10% of baseline before timeout

2.4.19-pre10aa2 (3GB kernel address space), nfsd_bkl_removal 020702
- wouldn't run

Conclusions:
- using the 3GB kernel address space substantially helps 2.4.17 nfsd
performance
- 2.4.19-pre10 with XFS from Feb 7, 2002 was the most stable of the
2.4.19-preX runs

I will be running 2.4.19-pre10 xfs 061102, 3GB kernel address space later
today or tomorrow.

I will try any patches, kernel CONFIG options, or  /proc values anyone might
suggest to get the 2.4.19-preX kernel nfsd performance at or near the 2.4.17
nfsd performance.

Thanks,
Erik
