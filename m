Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129248AbQKVRyZ>; Wed, 22 Nov 2000 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129324AbQKVRyO>; Wed, 22 Nov 2000 12:54:14 -0500
Received: from adsl-63-205-85-133.dsl.snfc21.pacbell.net ([63.205.85.133]:7684
        "EHLO schmee.sfgoth.com") by vger.kernel.org with ESMTP
        id <S129248AbQKVRyA>; Wed, 22 Nov 2000 12:54:00 -0500
Date: Wed, 22 Nov 2000 09:23:56 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
Message-ID: <20001122092356.B53983@sfgoth.com>
In-Reply-To: <Pine.LNX.4.21.0011221031340.995-100000@panoramix.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0011221031340.995-100000@panoramix.bitwizard.nl>; from patrick@bitwizard.nl on Wed, Nov 22, 2000 at 10:32:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I'd like to make a couple points about driver style that I'm trying
to move towards with the ATM drivers.  You're free to take them or leave
them, but I want to eventually move the tree in this direction.
  * I don't like header files that define the registers of the chip - since
    the header file is only included in the driver's .c file you might as
    well just put the definitions there (unless, of course, there is good
    reason to think that the registers will be used in multiple drivers -
    unlikely in this case)  Having a seperate header file just serves to
    hamper searching around the driver and cluttering the directory.
  * Please use the new PCI interface for new drivers (i.e. MODULE_DEVICE_TABLE
    and all that)

> +int loopback = 0;
> +int num=0x5a;

These should be defined static.

> +char *irq_bitname[] = {

Should be static.

> +#ifdef DEBUG
> +#define fs_dprintk(f, str...) if (fs_debug & f) printk (str)

Hint - you could use "(fs_debug & FS_DEBUG_##f)" in order to clean up
the callers of this function.  Also you might want to wrap this in a
"do { ... } while(0)" in order to avoid expansion problems in the future.

> +#ifdef DEBUG
> +/* I didn't forget to set this to zero before shipping. Hit me with a stick 
> +   if you get this with the debug default not set to zero again. -- REW */
> +int fs_debug = 0;

Again, should be static.

> +#ifdef MODULE
> +#ifdef DEBUG 
> +MODULE_PARM(fs_debug, "i");

There's no reason to wrap these "MODULE_PARM"s inside an "#ifdef MODULE".

> +#define MIN(a,b) (((a)<(b))?(a):(b))

You don't seem to ever use this definition.

> +#else /* DEBUG */
> +static void my_hd (void *addr, int len){}
> +#endif /* DEBUG */

You might as well make this a null #define in this case.

> +/* Hmm. If this is ATM specific, why isn't there an ATM routine for this?
> + * I copied it over from the ambassador driver. -- REW */
> +
> +static inline void fs_kfree_skb (struct sk_buff * skb) 

Yes, in the 2.5 timeframe this wart will be cleaned up (by always requiring
vcc->pop to be !=NULL)

> +/* It seems the ATM forum recomends this horribly complicated 16bit
> + * floating point format. Turns out the Ambassador uses the exact same
> + * encoding. I just copied it over. If Mitch agrees, I'll move it over
> + * to the atm_misc file or something like that. (and remove it from 
> + * here and the ambassador driver) -- REW
> + */

Yep, in 2.5 we can do something like that (although I want to look at it
a bit further)

> +void write_fs (struct fs_dev *dev, int offset, int val)

Should be static.  And probably inline.  "val" should be a u32.

> +unsigned int read_fs (struct fs_dev *dev, int offset)

Ditto.  Return value should be u32.

> +struct FS_QENTRY *get_qentry (struct fs_dev *dev, struct queue *q)

Should be static

> +void submit_qentry (struct fs_dev *dev, struct queue *q, struct FS_QENTRY *qe)

Should be static

> +void submit_queue (struct fs_dev *dev, struct queue *q, 
> +		   u32 cmd, u32 p1, u32 p2, u32 p3)

Should be static

> +void submit_command (struct fs_dev *dev, struct queue *q, 

Should be static

> +void process_return_queue (struct fs_dev *dev, struct queue *q)

Should be static

> +void process_txdone_queue (struct fs_dev *dev, struct queue *q)

Should be static

> +void process_incoming (struct fs_dev *dev, struct queue *q)

Should be static

> +static int fs_send (struct atm_vcc *atm_vcc, struct sk_buff *skb)
[...]
> +	vcc->last_skb = skb;

I'm really leary of this... it looks to me that if we already had been in
the process of sending an skb then sends after that will lose that skb
(and leak the associated memory).  Please reference the recent thread on
the linux-atm mailing list about how to deal with TX backlog.  also:

> +	td = kmalloc (sizeof (struct FS_BPENTRY), GFP_ATOMIC);
> +	fs_dprintk (FS_DEBUG_ALLOC, "Alloc transd: %p(%d)\n", td, sizeof (struct FS_BPENTRY));
> +	if (!td) {
> +		/* Oops out of mem */
> +		return -ENOMEM;
> +	}

What frees the skb in this case?

> +void undocumented_pci_fix (struct pci_dev *pdev)

Should be static

> +void write_phy (struct fs_dev *dev, int regnum, int val)

Should be static

> +int init_phy (struct fs_dev *dev, struct reginit_item *reginit)

Should be static

> +void reset_chip (struct fs_dev *dev)

Should be static

> +void *aligned_kmalloc (int size, int flags, int alignment)

Should be static

> +{
> +	void  *t;
> +
> +	if (alignment <= 0x10) {
> +		t = kmalloc (size, flags);
> +		if ((unsigned int)t & (alignment-1)) {
> +			printk ("Kmalloc doesn't align things correctly! %p\n", t);
> +			kfree (t);
> +			return aligned_kmalloc (size, flags, alignment * 4);

Uh, ok....  I'd prefer if you just died here - there shouldn't be any way
that kmalloc is going to return something that isn't 16-byte aligned.  It's
wise to double check this when it's important but I wouldn't put too much
work into fixing this.  And calling ourselves recursively doesn't make
much sense to me - especially since it's likely to bomb out because of:

> +	printk (KERN_ERR "Request for > 0x10 alignment not yet implemented (hard!)\n");

Continuing on...

> +int init_q (struct fs_dev *dev, 

Should be static.

> +int init_fp (struct fs_dev *dev, 

Should be static.

> +void top_off_fp (struct fs_dev *dev, struct freepool *fp, int gfp_flags)

Should be static

> +void free_queue (struct fs_dev *dev, struct queue *txq)

Should be static

> +void free_freepool (struct fs_dev *dev, struct freepool *fp)

Should be static

> +void fs_irq (int irq, void *dev_id,  struct pt_regs * pt_regs) 

Should be static

> +	/* 10ms * 100 is 1 second. That should be enough, as AN3:9 says it takes
> +	   1ms. */
> +	to = 100;
> +	while (--to) {
[...]
> +		/* Try again after 100ms. */
> +		current->state = TASK_UNINTERRUPTIBLE;
> +		schedule_timeout ((HZ+99)/100);
> +	}

Note that the second comment is wrong - you're trying again in 10ms.

> +int init_module(void)

You might as well convert this to the new "module_init()" system when
you update to use the new PCI probing code.

-Mitch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
