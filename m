Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbTCNTyy>; Fri, 14 Mar 2003 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263456AbTCNTyy>; Fri, 14 Mar 2003 14:54:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:10114 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263344AbTCNTyv>;
	Fri, 14 Mar 2003 14:54:51 -0500
Date: Fri, 14 Mar 2003 12:05:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030314120537.715e5bf0.akpm@digeo.com>
In-Reply-To: <20030314133126.GB2679@ncsu.edu>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org>
	<20030313113448.595c6119.akpm@digeo.com>
	<1047611104.14782.5410.camel@spc1.mesatop.com>
	<20030313192809.17301709.akpm@digeo.com>
	<20030314133126.GB2679@ncsu.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 20:05:34.0380 (UTC) FILETIME=[128FB6C0:01C2EA65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
>
> On Thu, Mar 13, 2003 at 07:28:09PM -0800, Andrew Morton wrote:
> 
> > One subtlety: the linker (ld) lays files out very poorly.  So the prefaulting
> > trick will not help much when run against an executable which was written by
> > ld.  But if you've copied it into /bin (make install) then it will work well.
> > That's something to watch out for.
> 
> Andrew,
>     I am not sure what you mean by this.  Are you saying that the way ld
> accesses files causes the blocks on the disk to be layed out poorly?
> That is the only thing I can think of that would get fixed by copying.
> 

Exactly that.  ld seeks all over the file when adding new blocks to it, so
with ext2 and ext3 (at least) there is poor correspondence between file
offset and block indices.

I recently compiled distccd:

mnm:/usr/src/distcc-1.1> 0 bmap distccd
0-0: 4544516-4544516 (1)
1-1: 4544519-4544519 (1)
2-2: 4544525-4544525 (1)
3-3: 4544531-4544531 (1)
4-4: 4544536-4544536 (1)
5-5: 4544540-4544540 (1)
6-6: 4544520-4544520 (1)
7-7: 4544528-4544528 (1)
8-8: 4544539-4544539 (1)
9-9: 4544521-4544521 (1)
10-10: 4544524-4544524 (1)
11-12: 4544526-4544527 (2)
13-14: 4544529-4544530 (2)
15-18: 4544532-4544535 (4)
19-20: 4544537-4544538 (2)
21-26: 4544541-4544546 (6)
27-40: 4544549-4544562 (14)
41-42: 4544522-4544523 (2)
43-43: 4544518-4544518 (1)
44-45: 4544547-4544548 (2)

And then I copied it:

mnm:/usr/src/distcc-1.1> 0 bmap /usr/local/bin/distccd
0-11: 3913857-3913868 (12)
12-45: 3913870-3913903 (34)

