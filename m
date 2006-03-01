Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWCAUS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCAUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWCAUS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:18:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750702AbWCAUS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:18:57 -0500
Date: Wed, 1 Mar 2006 12:12:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301121218.68fb3f76.akpm@osdl.org>
In-Reply-To: <1141227199.10460.2.camel@homer>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<1141221511.7775.10.camel@homer>
	<4405B4AA.7090207@free.fr>
	<1141227199.10460.2.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> On Wed, 2006-03-01 at 15:50 +0100, Laurent Riffard wrote:
> >  
> > 

OK, thanks guys.  Eric, could you please cook up something to make the
permissions appear-to-work as expected?

> > 2.6.16-rc5-mm2-pre1 works fine for me except numerous "BUG: warning at fs/inotify.c:533/inotify_d_instantiate()".
> 
> I feel left out.  I get none.
> 

Maybe you're not running applications which install inotify watches.  This
is apparently triggerable by doing `touch foo;rm foo;touch foo' in a watched
directory.

Nick, isn't it simply a matter of..

--- devel/fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix	2006-03-01 12:10:48.000000000 -0800
+++ devel-akpm/fs/dcache.c	2006-03-01 12:11:33.000000000 -0800
@@ -173,6 +173,7 @@ repeat:
 		goto kill_it;
   	if (list_empty(&dentry->d_lru)) {
   		dentry->d_flags |= DCACHE_REFERENCED;
+		dentry->d_flags &= DCACHE_INOTIFY_PARENT_WATCHED;
   		list_add(&dentry->d_lru, &dentry_unused);
   		dentry_stat.nr_unused++;
   	}
_

