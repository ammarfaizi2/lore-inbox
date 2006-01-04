Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWADJh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWADJh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWADJh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:37:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751229AbWADJh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:37:57 -0500
Date: Wed, 4 Jan 2006 01:36:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
Message-Id: <20060104013658.620e51e6.akpm@osdl.org>
In-Reply-To: <43B64712.3000105@sw.ru>
References: <1135973075.6039.63.camel@localhost.localdomain>
	<1135978110.6039.81.camel@localhost.localdomain>
	<20051230154647.5a38227e.akpm@osdl.org>
	<43B64712.3000105@sw.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Hi Andrew,
> 
> I have a full patch for this.

Please don't top-post.  It makes things hard...

> I don't remember the details yet, but lock was not god here, we used 
> semaphore. I pointed to this problem long ago when fixed error path in 
> proc with moduleget.
> 
> This patch protects proc_dir_entry tree with a proc_tree_sem semaphore. 
> I suppose lock_kernel() can be removed later after checking that no proc 
> handlers require it.
> Also this patch remakes de refcounters a bit making it more clear and 
> more similar to dentry scheme - this is required to make sure that 
> everything works correctly.
> 
> Patch is against 2.6.15-rcX and was tested for about a week. Also works 
> half a year on 2.6.8 :)
> 
> [ patch which uses an rwsem for procfs and somewhat removes lock_kernel() ]
>

I worry about replacing a spinlock with a sleeping lock.  In some
circumstances it can cause a complete scalability collapse and I suspect
this could happen with /proc.  Although I guess the only fastpath here is
proc_readdir(), and as the lock is taken there for reading, we'll be OK..

The patch does leave some lock_kernel() calls behind.  If we're going to do
this, I think they should all be removed?

Races in /proc have been plentiful and hard to find.  The patch worries me,
frankly.  I'd like to see quite a bit more description of the locking
schema and some demonstration that it's actually complete before taking the
plunge.

