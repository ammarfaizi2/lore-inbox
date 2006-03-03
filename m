Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752056AbWCCGxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbWCCGxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWCCGxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:53:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752056AbWCCGxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:53:51 -0500
Subject: Re: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN
	DECT PABX
From: Arjan van de Ven <arjan@infradead.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <440779AF.5060202@imap.cc>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
	 <1141032577.2992.83.camel@laptopd505.fenrus.org> <440779AF.5060202@imap.cc>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 07:53:28 +0100
Message-Id: <1141368808.2883.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 00:03 +0100, Tilman Schmidt wrote:
> Thank you very much, Arjan, for your review of our code and your
> extensive comments. We are working on taking them into account for the
> next attempt at submitting the driver. Most of them are quite clear and
> don't need discussing. Just a few remarks and questions:
> 
> On 27.02.2006, Arjan van de Ven wrote:
> > as a general review remark: you seem to use a LOT of atomic variables.
> > This I think is not too good an approach in general, because you get
> > into all kinds of race situations if you need to access multiple (and
> > you do).
> 
> I see. We'll try to reduce our atomic consumption. :-)
> 
> > In addition I've seen a lot of your code using 2 or more
> > atomics in the same function, at which point it's most likely cheaper to
> > just have a spinlock instead... (yes a single atomic is same cost as a
> > spinlock, but once you do multiple in the same function the price is
> > thus higher than a spinlock ;)
> 
> So you are saying that, for example
> 
> 	spin_lock_irqsave(&cs->ev_lock, flags);
> 	head = cs->ev_head;
> 	tail = cs->ev_tail;
> 	spin_unlock_irqrestore(&cs->ev_lock, flags);
> 
> is (mutatis mutandis) actually cheaper than
> 
> 	head = atomic_read(&cs->ev_head);
> 	tail = atomic_read(&cs->ev_tail);


atomic_read is special since it's not actually an atomic operation ;)
but.. think about it: you do 2 atomic reads, however there is ZERO
guarantee that the reads are atomic with respect to eachother; eg your
head and tail are not an atomic "snapshot" of these 2 variables!



> >>+#define IFNULL(a) \
> >>+       if (unlikely(!(a)))
> > 
> > please please get rid of this!
> > (same goes for the variants of this just below this)
> 
> Ok, these were mainly debugging aids. We'll just drop them and let the
> oops mechanism catch the (hopefully non-existent) remaining cases of
> pointers being unexpectedly NULL.

you can also use WARN_ON() and BUG_ON() for that, you then get a more
readable oops message (with filename and line information)


> 
> >> +void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
> >> +			size_t len, const unsigned char *buf, int from_user)
> > 
> > such "from_user" parameter is highly evil, and also breaks sparse and
> > friends.. (btw please run sparse on the code and fix all warnings)
> 
> Are you referring to anything in particular? We do run sparse regularly,
> and it did not emit any warnings for the submitted version, not even for
> this function. (But heaps of them for other parts of the kernel, if you
> pardon the remark.)

msg should have the __user atribute here since it can be in userspace...
sometimes. It is the "sometimes" that is the bad idea!


> 
> >> +       spin_lock_irqsave(&cs->lock, flags);
> >> +       ret = kmalloc(sizeof(struct at_state_t), GFP_ATOMIC);
> >> +       if (ret) {
> >> +               gigaset_at_init(ret, NULL, cs, cid);
> > 
> > if you move the kmalloc one line up, can it use GFP_KERNEL ?
> 
> Sorry but no - this is executed within a tasklet.

ok fair enough ;)

> 
> > (GFP_ATOMIC is evil in the sense that spurious use of it gives trouble
> > for the VM)
> 
> Does that mean that every function doing kmalloc() and which may be
> called from both interrupt and non-interrupt context needs a gfp_t flags
> argument?

well that's the other extreme. But if it's going to be a major source of
memory allocations, yes. If it's only sometimes, or "a few", then no.
For example if your tasklet function allocates one, and then frees it
before being done, I don't see a problem. It becomes a problem when
there will be many of these, and when they have longer lifetimes,
because then the vm can become starved of memory before it has a chance
to do correct the memory imbalance.
(GFP_ATOMIC is like borrowing from the VM, the VM will be in slight
imbalance afterwards. With GFP_KERNEL you allow the kernel to fix this
imbalance. A slight imbalance is fine and not a problem. Especially if
you give it the memory back soon. But if the imbalance can accumulate,
for example because you keep allocating and free the memory much later,
it can become a problem)


