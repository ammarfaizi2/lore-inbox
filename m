Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbUKRTSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbUKRTSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbUKRTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:16:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61363 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262903AbUKRTPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:15:54 -0500
In-Reply-To: <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
MIME-Version: 1.0
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFFF27FA67.0439D04D-ON88256F50.006793AA-88256F50.00699D3A@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 18 Nov 2004 11:12:41 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M2_07222004 Beta 2|July
 22, 2004) at 11/18/2004 14:15:52,
	Serialize complete at 11/18/2004 14:15:52
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> A normal write is a VFS write() call, I assume.  While they're going 
>> through the page cache, the pages are dirty, right?  Is it possible 
that 
>> FUSE needs more real memory after dirtying those pages in order to 
finish 
>> cleaning them?
>
>It's possible, but I don't see why that's a problem.  If it can get
>more memory it's OK.  If allocation fails, then the write() will fail
>with ENOMEM, if OOM killer get's to work and kills the FUSE process,
>then write will return with ENOTCONN or something like that.

The "allocation" is a fetch or store instruction by the FUSE process, 
which generates a page fault.  To satisfy that, the kernel has to allocate 
some real memory.  A fetch or store instruction doesn't fail when there's 
no real memory available.  It just waits for the kernel to make some 
available.  The kernel does that by picking some less deserving page and 
evicting it.  That eviction may require a pageout.  If the guy who's doing 
the fetch or store is the guy who's supposed to do that pageout, you have 
a deadlock.

I don't see where in this path the write() has a chance to fail.

Furthermore, it's not right for the write() to fail or for any process to 
be killed by the OOM Killer.  The system has the resources to complete the 
job.  It just hasn't scheduled them correctly and thus backed itself into 
a corner.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
