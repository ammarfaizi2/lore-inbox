Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVBSR7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVBSR7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVBSR7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:59:43 -0500
Received: from [83.102.214.158] ([83.102.214.158]:47308 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261753AbVBSR7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:59:01 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com
Subject: [RFC] parallel directory operations
From: Alex Tomas <alex@clusterfs.com>
Organization: ClusterFS Inc.
Date: Sat, 19 Feb 2005 20:57:25 +0300
Message-ID: <m34qg84em2.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day Al and all

could you review couple patches that implement $subj
for vfs and tmpfs. In short the idea is that we can
protect operations taking semaphore related for set
of names. definitely, protection at vfs layer isn't
enough and filesystem will need to protect their own
structures by itself, but in some cases vfs patch is
enough. for example, tmpfs. during some loads one can
see quite high load in /tmp. being mounted as tmpfs
on big smp, we can get high contention on i_sem.

probably someone could try more-less real load?

I wrote simple program that spawn few processes, then
chdir to the given directory, then loops creating and
unlinking file. The test box is dual PIII-1GHz:


run 1: 2 processes create/unlink file on regular tmpfs

[root@bob root]# mount -t tmpfs none /test
[root@bob root]# (cd /test; time  /root/crunl ./f 1000000 2)
#1998: 1000000 iterations, create/unlink ./f-0-1998
#1999: 1000000 iterations, create/unlink ./f-1-1999
#384: done
#384: done
wait for completion ... OK
real    0m36.224s
user    0m0.823s
sys     0m47.994s


run 2: 2 processes create/unlink file on tmpfs + pdirops

[root@bob root]# mount -t tmpfs -o pdirops none /test
[root@bob root]# (cd /test; time  /root/crunl ./f 1000000 2)
#1992: 1000000 iterations, create/unlink ./f-0-1992
#1993: 1000000 iterations, create/unlink ./f-1-1993
#384: done
#384: done
wait for completion ... OK
real    0m15.108s
user    0m0.592s
sys     0m29.406s


run 3: 1 process creates/unlinks file on regular tmpfs

[root@bob root]# mount -t tmpfs none /test
[root@bob root]# (cd /test; time  /root/crunl ./f 1000000 1)
#2004: 1000000 iterations, create/unlink ./f-0-2004
#384: done
wait for completion ... OK
real    0m11.950s
user    0m0.262s
sys     0m7.465s

run 4: 1 process creates/unlinks file on tmpf + pdirops

[root@bob root]# mount -t tmpfs -o pdirops none /test
[root@bob root]# (cd /test; time  /root/crunl ./f 1000000 1)
#2009: 1000000 iterations, create/unlink ./f-0-2009
#384: done
wait for completion ... OK
real    0m8.047s
user    0m0.243s
sys     0m7.646s


2 processes creating/unlinking on regular tmpfs cause ~200K context switches:

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 2  0  0      0 1005760   6616  10928    0    0     0     0 1007 215095  1 64 35
 2  0  0      0 1005760   6616  10928    0    0     0     0 1007 213580  1 67 32
 2  0  0      0 1005760   6616  10928    0    0     0     0 1007 214445  1 63 36
 2  0  0      0 1005760   6616  10928    0    0     0     0 1007 216250  1 63 36


2 processes creating/unlinking on tmpfs + pdirops cause ~44 context switches:

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 2  0  1      0 1001824   6632  10912    0    0     0     0 1008    41  2 98  0
 2  0  2      0 1002144   6632  10912    0    0     0     0 1008    45  2 98  0
 2  0  2      0 1001632   6632  10912    0    0     0     0 1007    47  2 98  0


the next benchmark is rename. two processes generate random name, create file,
generate new name, rename created file in new name and unlink:

run 5: regular tmpfs

[root@bob root]# mount -t tmpfs none /test
[root@bob root]# (cd /test; time  /root/rndrename ./f 1000000 2)
#2036: 1000000 iterations
#2037: 1000000 iterations
wait for completion ... OK
real    1m22.381s
user    0m10.254s
sys     1m50.214s

run 6: tmpfs + pdirops

[root@bob root]# mount -t tmpfs -o pdirops none /test
[root@bob root]# (cd /test; time  /root/rndrename ./f 1000000 2)
#2044: 1000000 iterations
#2045: 1000000 iterations
wait for completion ... OK

real    0m39.403s
user    0m9.411s
sys     1m8.626s


thanks, Alex

