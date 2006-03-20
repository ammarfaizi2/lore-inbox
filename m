Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWCTVIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWCTVIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWCTVIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:08:31 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:31621 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1030387AbWCTVI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:08:29 -0500
Date: Mon, 20 Mar 2006 23:08:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060320210828.GG3927@mea-ext.zmailer.org>
References: <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk> <20060320130950.GA9334@thunk.org> <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com> <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:36:51PM -0500, Xin Zhao wrote:
> 
> OK. Now I have more experimental results.
> 
> After excluding the cost of reading file list and do stat(), the
> insertion rate becomes 587/sec, instead of 300/sec. The query rate is
> 2137/sec. I am runing mysql 4.1.11. FC4, 2.8G CPU and 1G mem.
> 
> 2137/sec seems to be good enough to handle pathname to inode
> resolving.  Anyone has some statistics how many file open in a busy
> file system?
> 
> Xin

What is wrong in here, I think, is your pre-set assumption, that
using proper modern database things will be faster.   Yes, perhaps
they will, under some specific conditions.

Like Gene Amdahl so long ago did point out, optimizing something
that forms 1% of the load will speed things up at most that 1%.

Could you instrument directory management primitive operations 
accounting ?  How many directory inserts/removes/lookups per
mounted filesystem (or entire system), including  dnames -cache
operations (they are already instrumented, I think) are used in
normal system operations ?

If your system behaviour shows more than 1% of other than lookups,
try to find out _why_ is that.

So far Linux optimizes filesystem directory reads to maximum.



Long ago I had a problem, where I needed insertion into an application
specific database from data origination system -- I needed also fast
batch replication from one dataset copy to another.  Doing hash keying
made insert _slow_.  Doing btree indexing and inserting in key-order
made things fast.   Not flushing database at every insert made it almost
linearly faster by the flush interval.  Not flushing the database except
at batch end made it maximally fast -- around 100 000 inserts per second,
but it had to be pre-sorted data.  (This was single SCSI-disk back in
1996.)  We had requirement to do batch insert as fast as possible,
similarly for batch replication that was used for maintenance, and
a ten-thousand-fold speedup was well worth the added complexities
in the software.

That database had also about 4 sigma "read-only" property.


 /Matti Aarnio
