Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTDIJPf (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTDIJPd (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:15:33 -0400
Received: from [12.47.58.221] ([12.47.58.221]:33053 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262945AbTDIJP3 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 05:15:29 -0400
Date: Wed, 9 Apr 2003 02:27:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: keitha@edp.fastfreenet.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: bdflush flushing memory mapped pages.
Message-Id: <20030409022726.1ec93a0f.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.10.10304090209440.12558-100000@master.linux-ide.org>
References: <007601c2fecd$12209070$230110ac@kaws>
	<Pine.LNX.4.10.10304090209440.12558-100000@master.linux-ide.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 09:27:01.0514 (UTC) FILETIME=[2D0DCEA0:01C2FE7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> wrote:
>
> 
> Funny you mention this point!
> 
> I just spent 30-45 minutes on the phone talking to Jens about this very
> issue.  Jens states he can map the model in to 2.5. and will give it a
> fling in a bit.  This issue is a must; however, I had given up on the idea
> until 2.7.  However, the issues he and I addressed, in combination to your
> request jive in sync.

noooo.....   This isn't going to happen.  There are many reasons.

Firstly, how can bdflush even know what pages to write?  The dirtiness of
these pages is recorded *only* in some processor's hardware pte cache and/or
the software pagetables.  Someone needs to go tell all the CPUs to writeback
their pte caches into the pagetables and then someone needs to walk the
pagetables propagating the pte dirty bit into the pageframes before we can
even start the I/O.

That's what msync does, in filemap_sync().


And even if bdflush did this automagically, it's the wrong thing to do
because the application could very well be repeatedly dirtying the pages. 
Very probably.  So we've just gone and done a ton of pointless I/O, over and
over.

You can view MAP_SHARED as an IPC mechanism which uses the filesystem
namespace for naming.  No way do these people want bdflush pointlessly
hammering the disk.

You can also view MAP_SHARED as a (strange) way of writing files out.  If you
want to do that then fine, but you need to tell the kernel when you've
finished, just like write() does.   You do that with msync.



