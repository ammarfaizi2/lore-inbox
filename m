Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSFQUxk>; Mon, 17 Jun 2002 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317008AbSFQUxj>; Mon, 17 Jun 2002 16:53:39 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:59121 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317007AbSFQUxi>; Mon, 17 Jun 2002 16:53:38 -0400
Date: Mon, 17 Jun 2002 16:53:40 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617165340.F1457@redhat.com>
References: <20020617161434.D1457@redhat.com> <20020617222812.I758@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020617222812.I758@suse.de>; from davej@suse.de on Mon, Jun 17, 2002 at 10:28:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 10:28:12PM +0200, Dave Jones wrote:
> On Mon, Jun 17, 2002 at 04:14:34PM -0400, Benjamin LaHaise wrote:
>  > +#define add_wait_queue_cond(q, wait, cond) \
>  > +	({							\
>  > +		unsigned long flags;				\
>  > +		int _raced = 0;					\
>  > +		wq_write_lock_irqsave(&(q)->lock, flags);	\
> 
> I thought we killed off wq_write_lock_irqsave 1-2 kernels ago ?

Ah, I didn't notice that as I've not reached the point of merging 
everything into a working build -- I'd like to get some feedback 
and comments on the mergable units as they become available, since 
I'm rewriting a few portions to fix problems that experience with 
the code revealed.  Anyways, the patch below changes add_wait_queue_cond 
to use spin_locks directly.

		-ben

diff -urN wq-func-v2.5.22.diff/include/linux/wait.h wq-func-v2.5.22-b.diff/include/linux/wait.h
--- wq-func-v2.5.22.diff/include/linux/wait.h	Mon Jun 17 15:53:25 2002
+++ wq-func-v2.5.22-b.diff/include/linux/wait.h	Mon Jun 17 16:46:23 2002
@@ -106,7 +106,7 @@
 	({							\
 		unsigned long flags;				\
 		int _raced = 0;					\
-		wq_write_lock_irqsave(&(q)->lock, flags);	\
+		spin_lock_irqsave(&(q)->lock, flags);	\
 		(wait)->flags = 0;				\
 		__add_wait_queue((q), (wait));			\
 		rmb();						\
@@ -114,7 +114,7 @@
 			_raced = 1;				\
 			__remove_wait_queue((q), (wait));	\
 		}						\
-		wq_write_unlock_irqrestore(&(q)->lock, flags);	\
+		spin_lock_irqrestore(&(q)->lock, flags);	\
 		_raced;						\
 	})
 
