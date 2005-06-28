Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVF1GjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVF1GjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVF1Gh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:37:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261971AbVF1Gbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:31:35 -0400
Date: Mon, 27 Jun 2005 23:30:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: cfq build breakage
Message-Id: <20050627233055.20029d85.akpm@osdl.org>
In-Reply-To: <20050628062108.GA3411@suse.de>
References: <42C0B39E.7070509@pobox.com>
	<20050627201333.4c7d3d06.akpm@osdl.org>
	<20050628062108.GA3411@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Mon, Jun 27 2005, Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > >
> > > 
> > > In latest git tree...
> > > 
> > >    CC [M]  drivers/block/cfq-iosched.o
> > > drivers/block/cfq-iosched.c: In function `cfq_put_queue':
> > > drivers/block/cfq-iosched.c:303: sorry, unimplemented: inlining failed 
> > > in call to 'cfq_pending_requests': function body not available
> > > drivers/block/cfq-iosched.c:1080: sorry, unimplemented: called from here
> > > drivers/block/cfq-iosched.c: In function `__cfq_may_queue':
> > > drivers/block/cfq-iosched.c:1955: warning: the address of 
> > > `cfq_cfqq_must_alloc_slice', will always evaluate as `true'
> > > make[2]: *** [drivers/block/cfq-iosched.o] Error 1
> > > make[1]: *** [drivers/block] Error 2
> > > make: *** [drivers] Error 2
> > 
> > hm.  The inline thing is trivial, but the misuse of
> > cfq_cfqq_must_alloc_slice() means that we now wander into untested
> > territory.
> 
> Indeed, which compiler errors on that?

4.0 and later, I guess.

> > @@ -1969,7 +1968,7 @@ __cfq_may_queue(struct cfq_data *cfqd, s
> >  		 * only allow 1 ELV_MQUEUE_MUST per slice, otherwise we
> >  		 * can quickly flood the queue with writes from a single task
> >  		 */
> > -		if (rw == READ || !cfq_cfqq_must_alloc_slice) {
> > +		if (rw == READ || !cfq_cfqq_must_alloc_slice(cfqq)) {
> >  			cfq_mark_cfqq_must_alloc_slice(cfqq);
> >  			return ELV_MQUEUE_MUST;
> >  		}
> 
> thanks, clearly a typo but inside if 0.

But the other instance was inside `#if 1'.  This fixup will change behaviour.
