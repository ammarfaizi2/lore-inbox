Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTHZKLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbTHZKLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:11:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:44215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263608AbTHZKLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:11:30 -0400
Date: Tue, 26 Aug 2003 03:14:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Lord <lord@sgi.com>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com, Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
Message-Id: <20030826031412.72785b15.akpm@osdl.org>
In-Reply-To: <1061852050.25892.195.camel@jen.americas.sgi.com>
References: <20030824171318.4acf1182.akpm@osdl.org>
	<20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
	<20030825124543.413187a5.akpm@osdl.org>
	<1061852050.25892.195.camel@jen.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@sgi.com> wrote:
>
> > > Is this enough information to help find the cause of the bug? If not,
>  > > it might be several days (if I'm unlucky, maybe even a week or two)
>  > > before I have time to do anything more...
>  > > 
>  > 
>  > -mm kernels have O_DIRECT-for-NFS patches in them.  And some versions of
>  > RPM use O_DIRECT.  Whether O_DIRECT makes any difference at the server end
>  > I do not know, but it would be useful if you could repeat the test on stock
>  > 2.6.0-test4.
>  > 
>  > Alternatively, run
>  > 
>  > 	export LD_ASSUME_KERNEL=2.2.5
>  > 
>  > before running RPM.  I think that should tell RPM to not try O_DIRECT.
> 
>  I doubt the NFS client is O_DIRECT capable here, I have run some rpm
>  builds over nfs to 2.6.0-test4 and an xfs filesystem, everything is
>  behaving so far. I will try mm1 tomorrow.
> 
>  Do we know if this NFS V3 or V2 by the way?

OK, sorry for the noise.  It appears that this is due to the AIO patches in
-mm.  fsx-linux fails instantly on nfsv3 to localhost on XFS.  It's OK on
ext2 for some reason.

Binary searching reveals that the offending patch is
O_SYNC-speedup-nolock-fix.patch

testcase:

	mkfs.xfs -f /dev/hda5
	mount /dev/hda5 /mnt/hda5
	chmod a+rw /mnt/hda5
	service nfs start
	mount localhost:/mnt/hda5 /mnt/localhost
	cd /mnt/localhost
	fsx-linux foo


truncating to largest ever: 0x13e76
READ BAD DATA: offset = 0x18f13, size = 0xee06, fname = foo
OFFSET  GOOD    BAD     RANGE
0x26000 0x02eb  0x0000  0x    0
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
0x26001 0xeb02  0x0000  0x    1
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
0x26002 0x0228  0x0000  0x    2
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
