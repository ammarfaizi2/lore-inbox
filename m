Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWCaQfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWCaQfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWCaQfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:35:44 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:27056 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751054AbWCaQfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:35:43 -0500
Date: Fri, 31 Mar 2006 11:35:42 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331163542.GC9207@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <20060331144951.GA9207@ti64.telemetry-investments.com> <20060331145726.GL9811@unthought.net> <20060331150453.GB9207@ti64.telemetry-investments.com> <20060331152401.GM9811@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331152401.GM9811@unthought.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 05:24:01PM +0200, Jakob Oestergaard wrote:
> With a local export/mount I see very few reads running the test  :/
> 
> Could this be a timing issue?  That pages in the cache are invalidated
> after maybe less than 100 microseconds which is roughly the round-trip
> time on the gigabit network connecting my server and client?

I don't see any problem over loopback either.  Perhaps I'll try increasing
delays with tc netem.  That will have to wait until later.

In any case, I tried on our NetApp FAS-250, and I see the same problem:
Mount options are:
netapp:/home /nfs/netapp/home nfs rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,addr=netapp 0 0

I don't have stat zeroing, so I rolled some scripts.   Sorry, these are
not vanilla kernels; if you don't nail this today, I'll try and find time
for git bisection over the weekend.

	-Bill

== 

My production FC1 2.6.10 kernel:

ti64: rm -f testfile ; uname -a ; ( /tmp/nfsstat.sh ; time /tmp/nfsbench ; /tmp/nfsstat.sh ) | /tmp/nfsstatdiff.awk 
Linux ti64 2.6.10-0.ti.4.fc1smp #1 SMP Wed Jan 19 12:15:34 EST 2005 i686 athlon i386 GNU/Linux

real    0m0.215s
user    0m0.000s
sys     0m0.093s
null: 0 getattr: 2 setattr: 0 lookup: 1 access: 0 readlink: 0 read: 1 write: 321 create: 1 mkdir: 0 symlink: 0 mknod: 0 remove: 0 rmdir: 0 rename: 0 link: 0 readdir: 0 readdirplus: 0 fsstat: 0 fsinfo: 0 pathconf: 0 commit: 0 

===

DaveJ's FC4 2.6.15.3-based errata kernel, mounted:

ti63: rm -f testfile ; uname -a ; ( /tmp/nfsstat.sh ; time /tmp/nfsbench ; /tmp/nfsstat.sh ) | /tmp/nfsstatdiff.awk 
Linux ti63 2.6.15-1.1831_FC4smp #1 SMP Tue Feb 7 13:48:31 EST 2006 i686 athlon i386 GNU/Linux

real    0m3.242s
user    0m0.000s
sys     0m0.360s
null: 0 getattr: 2561 setattr: 0 lookup: 1 access: 1 readlink: 0 read: 7040 write: 3200 create: 1 mkdir: 0 symlink: 0 mknod: 0 remove: 0 rmdir: 0 rename: 0 link: 0 readdir: 0 readdirplus: 0 fsstat: 0 fsinfo: 0 pathconf: 0 commit: 0 


	-Bill
