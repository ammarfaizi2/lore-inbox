Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQKWLqT>; Thu, 23 Nov 2000 06:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129514AbQKWLqB>; Thu, 23 Nov 2000 06:46:01 -0500
Received: from 4dyn163.delft.casema.net ([195.96.105.163]:49420 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129507AbQKWLpy>; Thu, 23 Nov 2000 06:45:54 -0500
Message-Id: <200011231115.MAA10903@cave.bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <20001122092356.B53983@sfgoth.com> from Mitchell Blank Jr at "Nov
 22, 2000 09:23:56 am"
To: Mitchell Blank Jr <mitch@sfgoth.com>
Date: Thu, 23 Nov 2000 12:15:34 +0100 (MET)
CC: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> > +MODULE_PARM(fs_debug, "i");
> 
> There's no reason to wrap these "MODULE_PARM"s inside an "#ifdef MODULE".
                 ^^^^ anymore in 2.4 

OK. 
 
> > +#define MIN(a,b) (((a)<(b))?(a):(b))
> 
> You don't seem to ever use this definition.

Hmmmm. Used to though.. ;-)

There are spots where the requested bit rate needs to be capped at the
devices spec. That's where this may come back.

> > +#else /* DEBUG */
> > +static void my_hd (void *addr, int len){}
> > +#endif /* DEBUG */
> 
> You might as well make this a null #define in this case.

There was a reason for this one day, long, long ago. I don't remember. 


> > +static int fs_send (struct atm_vcc *atm_vcc, struct sk_buff *skb)
> [...]
> > +	vcc->last_skb = skb;
> 
> I'm really leary of this... it looks to me that if we already had been in
> the process of sending an skb then sends after that will lose that skb
> (and leak the associated memory).  Please reference the recent thread on
> the linux-atm mailing list about how to deal with TX backlog.  also:

The last_skb is not the "one to be freed". The skb's are freed when the
chips reports them back as "transmitted". 

We have to trust the chip to actually work. If it doesn't we're in
deep shit anyway. It is really really hard to make a mechanism where
we detect that hte chip is taking way too long on transmitting a
packet, so that we could time the packet out and reclaim the memory. 

So I trust the chip to actually report all packets back to us
eventually. If the chip crashes, you lose some memory. Sorry.

I contributed to that thread. I submitted my solution. At the time
this was the only solution. Some others have submitted less reliable
ways of doing the same. I prefer mine. 

So, my philosophy is: We remember the last skb we submitted, and once
the chip reports that skb back to us, we're allowed to deallocate the
vcc.

> > +	td = kmalloc (sizeof (struct FS_BPENTRY), GFP_ATOMIC);
> > +	fs_dprintk (FS_DEBUG_ALLOC, "Alloc transd: %p(%d)\n", td, sizeof (struct FS_BPENTRY));
> > +	if (!td) {
> > +		/* Oops out of mem */
> > +		return -ENOMEM;
> > +	}
> 
> What frees the skb in this case?

I expect the caller to do this. Or to retry the skb. 

I more or less copied this from "ambassador.c". It too just returns
the errorcode if sending a packet fails for some reason.

> > +{
> > +	void  *t;
> > +
> > +	if (alignment <= 0x10) {
> > +		t = kmalloc (size, flags);
> > +		if ((unsigned int)t & (alignment-1)) {
> > +			printk ("Kmalloc doesn't align things correctly! %p\n", t);
> > +			kfree (t);
> > +			return aligned_kmalloc (size, flags, alignment * 4);
> 
> Uh, ok....  I'd prefer if you just died here - there shouldn't be any way
> that kmalloc is going to return something that isn't 16-byte aligned.  It's
> wise to double check this when it's important but I wouldn't put too much
> work into fixing this.  And calling ourselves recursively doesn't make
> much sense to me - especially since it's likely to bomb out because of:

> > +	printk (KERN_ERR "Request for > 0x10 alignment not yet implemented (hard!)\n");

Yes, I thought I was going to implement it, but it turned out to be
harder than expected. (Actually it'd have been lots easier if kfree
would allow you to return a pointer to somewhere inside the area
allocated, instead of requiring the pointer to point to the
beginning. This was a side-effect of one of the faster kmallocs that
I've written. However this one never made it into the kernel....)

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
