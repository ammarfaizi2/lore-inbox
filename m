Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTJIRiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTJIRiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:38:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:24235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262336AbTJIRiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:38:50 -0400
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20031009111624.GA11549@in.ibm.com>
References: <20031005013326.3c103538.akpm@osdl.org>
	 <1065655095.1842.34.camel@ibm-c.pdx.osdl.net>
	 <20031009111624.GA11549@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065721121.1821.16.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Oct 2003 10:38:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 04:16, Suparna Bhattacharya wrote:
> On Wed, Oct 08, 2003 at 04:18:15PM -0700, Daniel McNeil wrote:
> > I'm been testing AIO on test6-mm4 using a ext3 file system and
> > copying a 88MB file to an already existing preallocated file of 88MB.
> > I been using my aiocp program to copy the file using i/o sizes of
> > 1k to 512k and outstanding aio requests of between 1 and 64 using
> > O_DIRECT, O_SYNC and O_DIRECT & O_SYNC.  Everything works as long
> > as the file is pre-allocated.  When copying the file to a new file
> > (O_CREAT|O_DIRECT), I get the following oops:
> 
> What are the i/o sizes and block sizes for which you get the oops ?
> Is this only for large i/o sizes ?


I've done more testing and it is a little confusing.
I originally got the oops running a shell script which copied 4
88MB files one at a time to a sub-directory:

for i in fff ff1 ff2 ff3
do
        aiocp -b 128k -n 8 -f CREAT -f DIRECT $i junkdir/$i
done
sync

This script would always cause the oops and the machine would lock up.

I ran aiocp manually using different block sizes (4k-128k) to copy
1 file to a subdirectory.  I removed the file in the subdirectory
afterward.  These tests completed without any problems or oopses.

> __aio_run_iocbs should have been called only for buffered i/o, 
> so this sounds like an O_DIRECT fallback to buffered i/o.
> Possibly after already submitting some blocks direct to BIO,
> the i/o completion path for which ends up calling aio_complete
> releasing the iocb. That could explain the use-after-free situation
> you see.

mm4 has my extra iocb ref count for retries patch.  So the iocb should
not be being freed by aio_complete.  The stack trace looks like the
fault is on the ctx or ctx->runlist.

> 
> But, O_DIRECT write should fallback to buffered i/o only if it 
> encounters holes in the middle of the file, not for simple appends 
> as in your case. Need to figure out how this could have happened ...
> 
> Could you try placing a few printks to find out if this is 
> the case or if we need to look elsewhere ?

I'll do more debugging and let you know what I find.

Daniel

