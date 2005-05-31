Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVEaWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEaWVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVEaWVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:21:18 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:49044 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261157AbVEaWVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:21:02 -0400
Message-ID: <429CE33E.609@zabbo.net>
Date: Tue, 31 May 2005 15:20:46 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: wim.coekaerts@oracle.com, mark.fasheh@oracle.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: review of ocfs2
References: <20050530112101.GF15326@wotan.suse.de>
In-Reply-To: <20050530112101.GF15326@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Over the weekend I read the ocfs2 patch (without configfs). Overall
> it looks pretty good and in good shape for merging.  Most of the
> stuff I noted are nits, not major things.

Awesome, thanks.  I'll try and respond to the bits I interacted with.

> One thing I would like to see is to combine it with a merging
> of the more advanced file system level AIO code. ocfs2 adds quite
> some hacks to do efficient aio without it, but that doesn't make
> sense.  Perhaps some Oracle people could help out testing
> and submitting the retry AIO patches and the clean it up?

Indeed.  Smoothing out AIO is definitely on the list.

> +	spin_lock_irqsave(&osb->osb_okp_teardown_lock, flags);
> 
> I presume the irqsave is because of end_io callbacks. Most major
> fs seem to have shifted to push them into workqueues and not disable
> interrupts. Might be an alternative. It tends to be good for interrupt
> latency at least.

Yeah, that doesn't sound unreasonable.  I added it to my list, and I'll
eyeball other such locks while I'm at it.

> +/* see ocfs2_ki_dtor */
> +void ocfs2_wait_for_okp_destruction(ocfs_super *osb)
> +{
> +	/* first wait for okps to enter the work queue */
> +	wait_event(osb->osb_okp_pending_wq, okp_pending_empty(osb));
> 
> Don't you need some lock here?

okp_pending_empty() locks around testing the list that it's reporting
the status of.  What problem are you picturing?

> +/* this is a hack until 2.6 gets its story straight regarding bubbling up
> + * EIOCBQUEUED and the like.  in mainline we'd pass an iocb down and do lots of
> + * is_sync() testing.  In suparna's patches the dlm would use waitqueues and
> + * the waiting primatives would test current->wait for sync.  until that gets
> + * settled we have a very limited async/cb mechanism in the dlm and have it
> + * call this which triggers a retry. */
> 
> If you really want it how about you help pushing Suparna's patches.
> iirc one of the problems they never got anywhere is that nobody else
> really used/tested them... <hint hint>. I suppose with some effort
> of testing/reviewing on mailing lists/etc.  this could be all fixed properly 
> in relatively short time. That would be much preferable to piling up hacks 
> like this in new code.

Agreed, though we have to acknowledge the simple fact that this kind of
code needs to exist to work with kernels in the wild today.  It's
unacceptable to have DLM locking stall apps as they issue AIO.

I'm surprised the horrible mmap() DLM deadlock avoidance stuff didn't
set off your alarm bells :)  It's a similar aspect of these kinds of
file systems that would benefit hugely from support in the core kernel.
 Lustre, GFS, and OCFS2 all implement this themselves under
->{read,write} and ->nopage and all conditionalize it on vmas which are
owned by their file system.  They all fail to deal with ABBA deadlocks
where locks are acquired in different orders across file systems.

> +	atomic_set(&wc->wc_num_reqs, num_ios);
> +	init_completion(&wc->wc_io_complete);
> +}
> +
> +/* Used in error paths too */
> +static inline void hb_bio_wait_dec(struct hb_bio_wait_ctxt *wc,
> +				   unsigned int num)
> +{
> +	/* sadly atomic_sub_and_test() isn't available on all platforms.  The
> +	 * good news is that the fast path only completes one at a time */
> 
> Really? Where is it missing? Most seem to have it. I would just use it
> and let the platforms catch up.

Sadly some s390 users are big weirdos and are more interested in ocfs2
running on old computers in their apartments than they are in waiting
for pressure on arch maintainers to bear fruit.

> 
> +	ret = wait_event_interruptible(hb_steady_queue,
> +				atomic_read(&reg->hr_steady_iterations) == 0);
> 
> What lock protects steady queue here?

hmm?  hb_steady_queue is static and global.  There will only be one
thread sampling the hb regions for a given region because configfs
serializes _write callers.

> + * Any framing errors (bad magic, large payload lengths) close a connection.
> 
> Have you considered adding a stronger checksum? That TCP default is quite
> weak.

Not really, no.  If that became an issue I bet we'd push to have it
handled for the file system / dlm by generic networking bits.

> +#define __msg_fmt "[mag %u len %u typ %u stat %d sys_stat %d key %u num %u] "
> +#define __msg_args __hdr->magic, __hdr->data_len, __hdr->msg_type, 	\
> + 	__hdr->status,	__hdr->sys_status, __hdr->key, __hdr->msg_num
> +#define msglog(hdr, fmt, args...) do {					\
> +	typeof(hdr) __hdr = (hdr);					\
> +	mlog(ML_MSG, __msg_fmt fmt, __msg_args, ##args);		\
> 
> Looks quite obfuscated with the separate argument lists.

"eh".  The argument spew used to be referenced in more than one place
but that has since changed.

> +		wait_event_interruptible(*sock->sk->sk_sleep,
> 
> That looks racy because of missing locking on sk_sleep.

I'd love to hear more.  My understanding of the sock/sk lifetimes here
tells me it isn't, but I've been wrong before.

> +EXPORT_SYMBOL(net_register_handler);
> 
> This looks like name space polution to me.  You cannot really claim
> to be _the_ net_. Give it some other prefix.

I couldn't agree more and continue to point to California and hysterical
raisins.  I'll search and replace if someone doesn't beat me to it.

> +	/* wait on other node's handler */
> +	wait_event(nsw.ns_wq, net_nsw_completed(node, &nsw));
> 
> Locking? Without an additional lock net_nsw_completed might be 
> false again when you get around to look.

Hmm?  net_nsw_completed() holds a lock while testing the list, the list
modification path also uses the lock and unlocks before waking.

> +void dlm_

That's my cue!

- z
