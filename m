Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUD3Xmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUD3Xmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 19:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUD3Xmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 19:42:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27126 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261857AbUD3Xmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 19:42:50 -0400
Date: Fri, 30 Apr 2004 18:42:22 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>, jrsantos@austin.ibm.com,
       linux-kernel@vger.kernel.org, anton@samba.org, dheger@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040430234222.GO14271@rx8.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com> <20040430131832.45be6956.akpm@osdl.org> <20040430205701.GG14271@rx8.ibm.com> <20040430213324.GK14271@rx8.ibm.com> <20040430150256.25735762.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040430150256.25735762.akpm@osdl.org> (from akpm@osdl.org on Fri, Apr 30, 2004 at 17:02:56 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/04 17:02:56, Andrew Morton wrote:
> Does this mean you need to redo the instrumentation and benchmarking?  If
> so, please do that and send the numbers along?  There's no particular
> urgency on that, but we should do it.

No, the screw up was made we I created the patch on a clean source
tree.  This patch represents the actual data gather on those graphs.
 
> Also, I'd be interested in understanding what the input to the hashing
> functions looked like in this testing.  It could be that the new hash just
> happens to work well with one particular test's dataset.  Please convince
> us otherwise ;)

hehehe...  I knew it could't be that easy. :)

For the dentry hash function, some of my other coorkers had put this
hash function through various testing and have concluded that the 
hash function was equal or better than the default hash function.
These runs were done with a (hopefully to be Open Source soon)
benchmark called FFSB which can simulate various io patters across
many filesystems and variable file sizes.

SpecSFS fileset is basically a lot of small file which varies 
depending on the size of the run.  For a not so big SMP system
the number of file is in the +20 Million files range.  Of those
20 million files only 10% are access randomly by the client.  The 
purpose of this is that the benchmark tries to stress not only
the NFS layer but, VM and Filesystems layers as well.  The filesets
are also hundreds of gigabytes in size in order to promote disk 
head movement by guaranteeing cache misses in memory.  SFS 27% of 
the workload are lookups __d_lookup has showing high in my 
profiles.

For the inode hash the problem that I see is that when running 
a benchmark with this huge fileset we end up trying to free a
lot of inode entries during the run while trying to put new 
entries in cache.  We end up calling ifind_fast() which calls
find_inodes_fast() held under inode_lock.  In order to avoid 
holding the inode_lock we needed to avoid having long chains 
in that hash function.

When I took a look at the original hash function, I found it 
to be a bit to simple for any workload.  My solution (which I 
took advantage of Dominique's work) was to create a hash 
that function that could generate completely different hashes
depending on the hashval and the superblock in order to have 
the hash scale as we added more filesystems to the machine.

Both of these problems can be somewhat tuned out by increasing
the number of buckets of both d and i cache but it got to a 
point were I had 256MB of inode and 128MB in dentry hash buckets 
on a not so large SMP.  With the hash changes I have been able 
to reduce the number of buckets to 128MB for inode cache and to 
32MB for dentry cache and still get better performance.

If it help my case...  I haven't been running this benchmark 
for long, so I haven't been able to find a way to cheat.  I 
need to come up with generic solutions until I can find a
cheat for the benchmark. :) 


-JRS
