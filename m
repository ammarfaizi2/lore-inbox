Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbTD3VNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTD3VNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:13:08 -0400
Received: from [12.47.58.20] ([12.47.58.20]:22617 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262435AbTD3VNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:13:06 -0400
Date: Wed, 30 Apr 2003 14:22:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68-mm3 with contest
Message-Id: <20030430142220.43fb0b4f.akpm@digeo.com>
In-Reply-To: <200304302049.34952.kernel@kolivas.org>
References: <200304302049.34952.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 21:25:22.0550 (UTC) FILETIME=[01F2B960:01C30F5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> All the io-write based loads were affected. 

Yup.  Mainly because the large queue increases truncate latencies.

gcc needs to delete a file.  truncate needs to wait on all in-progress
writeout against that file before releasing the blocks.  With the larger
queue that takes a lot longer.

Could be fixed with a global buffer cache (leave the IO in progress against
the freed block, only wait on it if the block is reallocated).  But we
don't have a global buffer cache.

Could be fixed with an IO cancellation capability at the request layer. 
has been discussed, is tricky.

Could be fixed by waiting on any pending IO at reallocation time at the
disk request layer, not the buffercache layer.  This could be made to work
OK with the rbtree-based request lookup actually.  But it'd hammer the heck
out of the request lookup code and the lock contention on big SMP would be
large.

Could be fixed by reducing the queue size again ;) This is what we'll do. 
There isn't a lot of benefit in the large queues.  -mm3 really only has the
big queue to demonstrate that the VM/VFS behaviour is now decoupled from
queue size, and for people to play with it.

