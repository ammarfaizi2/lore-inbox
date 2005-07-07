Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVGGCOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVGGCOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVGGCNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 22:13:05 -0400
Received: from mx1.netapp.com ([216.240.18.38]:25424 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S262574AbVGGCLa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 22:11:30 -0400
X-IronPort-AV: i="3.93,267,1115017200"; 
   d="scan'208"; a="209500225:sNHT18168676"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NFS] [PATCH] NFS: fix client hang due to race condition
Date: Wed, 6 Jul 2005 19:11:25 -0700
Message-ID: <482A3FA0050D21419C269D13989C611308539D6E@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] [PATCH] NFS: fix client hang due to race condition
Thread-Index: AcWCcVXwccYG6joBQgm3H7MHsBjRIQAJ1gYg
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Nick Wilson" <njw@osdl.org>, <trond.myklebust@fys.uio.no>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <nfs@lists.sourceforge.net>
X-OriginalArrivalTime: 07 Jul 2005 02:11:25.0924 (UTC) FILETIME=[2DC24240:01C58299]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The flags field in struct nfs_inode is protected by the BKL.  The
> following two code paths (there may be more, but my test program only
> hits these two) modify the flags without obtaining the lock:
> 
>     nfs_end_data_update
>     nfs_release
>     nfs_file_release
>     __fput
>     fput
>     filp_close
>     sys_close
>     syscall_call
> 
>     nfs_revalidate_mapping
>     nfs_file_write
>     do_sync_write
>     vfs_write
>     sys_write
>     syscall_call
> 
> Running multiple instances of a simple program [1] that opens, writes
> to, and closes NFS mounted files eventually results in the programs
> hanging on an SMP system (see kernel .config [3]).
> 
> I've been testing this with 100 instances of the program:
>     $ ./breaknfs 100 &
> 
> Usually within 10 minutes, all instances of breaknfs will hang.  They
> disappear from the output of 'top' and there is no NFS 
> activity between
> the client and server.

[ sysrq output snipped... ]

> I've reproduced this bug on 2.6.11.10, 2.6.12-mm2, and 2.6.13-rc2.
> 
> With my patch against 2.6.13-rc2 below, I ran 100 instances 
> of breaknfs
> with this patch for 14 hours and I was unable to get the 
> client to hang.

i agree this is a problem.

but instead of using heavyweight synchronization, why not convert the
NFS_INO flags into atomic bitops?  i have a patch that does that; would
need to be ported to the latest kernels and tested to see if it
addresses the problem.

nick, are you interested in trying it out?
