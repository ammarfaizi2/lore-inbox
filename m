Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUCIQsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUCIQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:48:38 -0500
Received: from smtp.freestart.hu ([213.197.64.6]:32516 "EHLO
	relay.freestart.hu") by vger.kernel.org with ESMTP id S262062AbUCIQsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:48:23 -0500
Date: Tue, 9 Mar 2004 17:46:18 +0100 (CET)
From: "Peter S. Mazinger" <ps.m@gmx.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.25-rc1: attempt to access beyond end of device, alsoIbm Serveraid
In-Reply-To: <Pine.LNX.4.44.0403011935270.9653-100000@lnx.bridge.intra>
Message-ID: <Pine.LNX.4.44.0403091738460.18861-100000@lnx.bridge.intra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-freestart-banner: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Peter S. Mazinger wrote:

> On Fri, 27 Feb 2004, Marcelo Tosatti wrote:
> 
> > 
> > Peter,
> > 
> > Can you try to revert (apply with -R) and see if it happens again, please?
> 
> Yes, it happens again (the problem appeared at 2.4.25-pre4 time, but that 
> patch is to huge for me to find the problematic part)

I have tried both patches proposed by Chuck Lever

--- mm/filemap.c.mps	Tue Mar  9 16:53:01 2004
+++ mm/filemap.c	Tue Mar  9 16:55:07 2004
@@ -1348,7 +1348,7 @@
 	while (ahead < max_ahead) {
 		unsigned long ra_index = raend + ahead + 1;
 
-		if (ra_index > end_index)
+		if (ra_index >= end_index)
 			break;
 		if (page_cache_read(filp, ra_index) < 0)
 			break;

this one corrects the error

--- mm/filemap.c.mps	Tue Mar  9 14:33:17 2004
+++ mm/filemap.c	Tue Mar  9 14:35:01 2004
@@ -1286,6 +1286,8 @@
 	int max_readahead = get_max_readahead(inode);
 
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	end_index = ((inode->i_size + ~PAGE_CACHE_MASK) >>
+						PAGE_CACHE_SHIFT) - 1;
 
 	raend = filp->f_raend;
 	max_ahead = 0;

this one does not correct the error

my ATA controller is ICH5 (built into the kernel), so add it too to the 
list of problematic drivers.

Peter

> 
> > 
> > 
> > On Fri, 6 Feb 2004, Peter S. Mazinger wrote:
> > 
> > > Hello!
> > >
> > > my hardware:
> > > x86
> > > ide controller (builtin driver)
> > > ext3 partitions (as modules loaded from initrd)
> > >
> > > if I shutdown -h now the computer, I get as last messages:
> > > attempt to access beyond end of device
> > > 03:03 rw=0, want=1044228, limit=1044225
> > > (3 times, 03:03/want/limit with other numbers), for all mounted
> > > (remounted ro) partitions
> > >
> > > distro: RedHat 7.3 (with all updates up to december)
> > > kernel is pristine: only 2.4.25-rc1 applied (EXPERIMENTAL code disabled)
> > > util-linux: 2.11n-12.7.3 (used umount, if it matters)
> > >
> > > Peter
> > >
> > > --
> > > Peter S. Mazinger <ps dot m at gmx dot net>           ID: 0xA5F059F2
> > > Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 59F2
> > >
> > >
> > > ____________________________________________________________________
> > > Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a FreeStarttol.
> > > Probald ki most! http://www.freestart.hu
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> 
> 

-- 
Peter S. Mazinger <ps dot m at gmx dot net>           ID: 0xA5F059F2
Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 59F2



____________________________________________________________________
Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a FreeStarttol.
Probald ki most! http://www.freestart.hu
