Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVDUUGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVDUUGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVDUUGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:06:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42462 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261846AbVDUUGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:06:07 -0400
Subject: a few dbench datapoints across various filesystems
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1114131840.6616.19.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2005 20:04:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran some quick tests with dbench to see the effects of various
performance improvements, and found the results interesting. Although
dbench is too write oriented, and not particularly favorable to a few
filesystems (who are otherwise good performers), dbench can still can be
useful.

System was a Pentium 4 2.40 GHz, uni, IDE drive, 1GB RAM
Kernel was mainline: 2.6.12-rc2. dbench version 3.03 from samba.org 


Unfortunately the two target partitions were not the exact same size
(the small partition size may skew some ext3 results somewhat higher,
but it saved time to avoid reformatting my development machine). 
partition sizes were 16.5 GB vs JFS 2 GB EXT3

Network filesystems tests (nfs v3, cifs, smbfs) were mounted over
localhost to minimize the effects of network adapter differences.
The cifs code was using the current version of cifs.ko (version 1.33)
newer than what is in mainline.

JFS Throughput 52.6572 MB/sec 20 procs
ext3 Throughput 179.726 MB/sec 20 procs
ext3 (2nd run) Throughput 180.409 MB/sec 20 procs
cifs mounted to samba/JFS 9.67401 Throughput MB/sec 20 procs
cifs mounted to samba/ext3 Throughput 12.2919 MB/sec 20 procs
nfs mounted to JFS Throughput 16.3588 MB/sec 20 procs
nfs mounted to ext3 Throughput 13.5945 MB/sec 20 procs
nfs mounted to ext3 (2nd run) Throughput 12.4307 MB/sec 20 procs

Then using newer JFS code with the faster JFS code from current mm tree
for the following five:
JFS Throughput 58.3836 MB/sec 20 procs
nfs mount to jfs Throughput 16.562 MB/sec 20 procs
smbfs mount to Samba/jfs Throughput 16.4742 MB/sec 20 procs
cifs larger mempool (40 buffers) (to Samba/jfs) 
	Throughput 12.8196 MB/sec 20 procs
cifs larger mempool (40 buffers), mount with directio mount option 
	(to Samba/JFS)
	Throughput 14.1643 MB/sec 20 procs

The cifs numbers are much improved, and should be pretty easy to get to
another 20 or 30% faster, which I will look at doing once we finishing
testing cifs version 1.33

Interesting that JFS was slower than ext3 for the local test, but faster
than ext3 when mounting via NFS to the same system, same filesystem. 
The JFS performance guys are apparently close to improving the local
dbench numbers since dbench shows a performance issue with writing
synchr. to the journal where other fs are able to do it faster (JFS does
well apparently on most of the other benchmarks, and my informal tests
showed that JFS was faster on various simple perf tests as well).

