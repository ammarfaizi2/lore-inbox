Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbULRJNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbULRJNE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 04:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbULRJNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 04:13:04 -0500
Received: from ns.suse.de ([195.135.220.2]:62929 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261154AbULRJMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 04:12:41 -0500
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
References: <87k6rhc4uk.fsf@coraid.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Dec 2004 10:11:04 +0100
In-Reply-To: <87k6rhc4uk.fsf@coraid.com.suse.lists.linux.kernel>
Message-ID: <p73r7loc6on.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed L Cashin <ecashin@coraid.com> writes:

Lots of nits and two design bugs.

> +void
> +aoechr_error(char *msg)
> +{
> +	struct ErrMsg *em;
> +	char *mp;
> +	ulong flags, n;
> +
> +	n = strlen(msg);
> +
> +	spin_lock_irqsave(&emsgs_lock, flags);
> +
> +	em = emsgs + emsgs_tail_idx;
> +	if ((em->flags & EMFL_VALID)) {
> +bail:		spin_unlock_irqrestore(&emsgs_lock, flags);
> +		return;
> +	}
> +
> +	mp = kmalloc(n, GFP_ATOMIC);

Why don't you do that outside the spinlock with GFP_KERNEL. Will make it
much more reliable

> +	if (mp == NULL) {
> +		printk(KERN_CRIT "aoe: aoechr_error: allocation failure, len=%ld\n", n);
> +		goto bail;
> +	}
>
> +void
> +aoechr_hdump(char *buf, int n)
> +{
> +	int bufsiz;
> +	char *fbuf;
> +	int linelen;
> +	char *p, *e, *fp;
> +
> +	bufsiz = n * 3;			/* 2 hex digits and a space */
> +	bufsiz += n / PERLINE + 1;	/* the newline characters */
> +	bufsiz += 1;			/* the final '\0' */
> +
> +	fbuf = kmalloc(bufsiz, GFP_ATOMIC);

In general you should only use GFP_ATOMIC when absolutely needed
and you have a good fallback path. It can fail regularly.


> +	if (!fbuf) {
> +		printk(KERN_INFO
> +		       "%s: cannot allocate memory\n",
> +		       __FUNCTION__);
> +		return;
> +	}
> +	
> +	for (p = buf; n <= 0;) {
> +		linelen = n > PERLINE ? PERLINE : n;
> +		n -= linelen;
> +
> +		fp = fbuf;
> +		for (e=p+linelen; p<e; p++)
> +			fp += sprintf(fp, "%2.2X ", *p & 255);
> +		sprintf(fp, "\n");
> +		aoechr_error(fbuf);
> +	}

I hope such complicated string code is really needed in the kernel.
It tends to be security bug prone.

> +
> +	kfree(fbuf);
> +}
> +
> +static ssize_t
> +aoechr_write(struct file *filp, const char *buf, size_t cnt, loff_t *offp)
> +{
> +	char *str = kcalloc(1, cnt+1, GFP_KERNEL);

Shouldn't that have some size check. This would allow each user
to allocate a lot of memory and put the system into a swap storm
while it tries to defragment enough physical address space. Better limit
it to a page or so.


Also I don't see why the buffer needs to be cleared.

> +	int ret;
> +
> +	if (!str) {
> +		printk(KERN_CRIT "aoe: aoechr_write: cannot allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(str, buf, cnt)) {

When someone passes a 128K buffer it will block the kernel for a long time 
to copy.

> +	default:
> +		return -EFAULT;

Is that the right errno here?
> +
> +void __exit
> +aoechr_exit(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
> +		class_simple_device_remove(MKDEV(AOE_MAJOR, chardevs[i].minor));
> +	class_simple_destroy(aoe_class);
> +	unregister_chrdev(AOE_MAJOR, "aoechr");

I think there is a module unload race here. Someone could reenter your
functions while this runs. 



> + * aoecmd.c
> + * Filesystem request handling methods
> + */
> +
> +#include <linux/hdreg.h>
> +#include <linux/blkdev.h>
> +#include <linux/skbuff.h>
> +#include <linux/netdevice.h>
> +#include "aoe.h"
> +
> +#define TIMERTICK (HZ / 10)
> +#define MINTIMER (2 * TIMERTICK)
> +#define MAXTIMER (HZ << 1)
> +#define MAXWAIT (60 * 3)	/* After MAXWAIT seconds, give up and fail dev */
> +
> +static struct sk_buff *
> +new_skb(struct net_device *if_dev, ulong len)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = alloc_skb(len, GFP_ATOMIC);

This is called on the block write path, right? Memory allocation
here implies that you can deadlock when the write is down due to
swapout on low memory.

Better would be if you had an emergency pool here and sleep
on it and guarantee that you always make progress with at least
one skb. There is no suitable callback on skb free for this
so it might be a bit tricky.

Failing that you should warn people from putting swap
on a AoE device and even be careful with rw mmaps which have
the same problem.

Also some network drivers (rarely fortunately) do memory 
allocation on their own in dev_queue_xmit.

That's quite a big design problem in your code.

> +		return NULL;
> +	}
> +
> +	p = skb->mac.raw;
> +	memcpy(p, f->data, f->ndata);


Why don't you check if the device supports NETIF_F_SG and then
just submit the pages directly in the skb? That would be much faster for 
sending at least since you would save a copy.




> + * Leave the top bit clear so we have tagspace for userland.
> + * The bottom 16 bits are the xmit tick for rexmit/rttavg processing.
> + * This driver reserves tag -1 to mean "unused frame."
> + */
> +static int
> +newtag(struct aoedev *d)
> +{
> +	register ulong n;

register? 


> +
> +	n = jiffies & 0xffff;
> +	return n |= (++d->lasttag & 0x7fff) << 16;

So it wraps every 16k packets? 

Better not use that protocol on multiple bounded Gigabit interfaces,
because they go through 16k packets in no time together with a reasonable
window size.

We spent a lot of time trying to work wrapping issues with the 16bit ipid
(and yes they happen in practice), it's sad to see that big mistake repeated
in a new protocol. 



> +}
> +
> +static int
> +aoehdr_atainit(struct aoedev *d, struct aoe_hdr *h)
> +{
> +	u16 type = __constant_cpu_to_be16(ETH_P_AOE);
> +	u16 aoemajor = __cpu_to_be16(d->aoemajor);

ntohs


> +	u32 host_tag = newtag(d);
> +	u32 tag = __cpu_to_be32(host_tag);

ntohl


> +	struct buf *buf;
> +loop:
> +	f = getframe(d, FREETAG);
> +	if (f == NULL)
> +		return;
> +	if (d->inprocess == NULL) {
> +		if (list_empty(&d->bufq))
> +			return;
> +		buf = container_of(d->bufq.next, struct buf, bufs);
> +		list_del(d->bufq.next);
> +/*printk(KERN_INFO "aoecmd_work: bi_size=%ld\n", buf->bio->bi_size); */
> +		d->inprocess = buf;
> +	}
> +	aoecmd_ata_rw(d, f);
> +	goto loop;

Nothing against gotos for errors, but why not use a nice
for (;;) or while (1) here?

> +	snprintf(buf, sizeof buf,
> +		"%15s e%ld.%ld oldtag=%08x@%08lx newtag=%08x\n",
> +		"retransmit",
> +		d->aoemajor, d->aoeminor, f->tag, jiffies, n);
> +	aoechr_error(buf);
> +
> +	h = (struct aoe_hdr *) f->data;
> +	f->tag = n;
> +	net_tag = __cpu_to_be32(n);

htonl


> +
> +	aoenet_xmit(sl);
> +}
> +
> +static void
> +ataid_complete(struct aoedev *d, unsigned char *id)
> +{
> +	u64 ssize;
> +	u16 n;
> +
> +	/* word 83: command set supported */
> +	n = __le16_to_cpu(*((u16 *) &id[83<<1]));

ntohs

etc. lots more occurrences.


> +aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
> +{
> +	struct aoe_hdr *h;
> +	struct aoe_cfghdr *ch;
> +	struct sk_buff *skb, *sl;
> +	struct net_device *ifp;
> +	u16 aoe_type = __constant_cpu_to_be16(ETH_P_AOE);
> +	u16 net_aoemajor = __cpu_to_be16(aoemajor);
> +
> +	sl = NULL;
> +
> +	read_lock(&dev_base_lock);
> +	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
> +		dev_hold(ifp);
> +		if (!is_aoe_netif(ifp))
> +			continue;
> +
> +		skb = new_skb(ifp, sizeof *h + sizeof *ch);

In general memory allocations should be done outside spinlocks
and not use GFP_ATOMIC unless absolutely needed.

> +
> +void
> +aoedev_downdev(struct aoedev *d)
> +{
> +	struct frame *f, *e;
> +	struct buf *buf;
> +	struct bio *bio;
> +
> +	d->flags |= DEVFL_TKILL;
> +	del_timer(&d->timer);

This probably needs to be del_timer_sync. I haven't checked fully,
but it looks like you have some races against the timer handler.


> +	f = d->frames;
> +	e = f + d->nframes;
> +	for (; f<e; f->tag = FREETAG, f->buf = NULL, f++) {
> +		if (f->tag == FREETAG || f->buf == NULL)
> +			continue;
> +		buf = f->buf;
> +		bio = buf->bio;
> +		if (--buf->nframesout == 0) {

What lock protects that decrement?

> +		del_gendisk(d->gd);
> +		put_disk(d->gd);
> +	}
> +	kfree(d->frames);
> +	mempool_destroy(d->bufpool);
> +	kfree(d);
> +}
> +
> +void __exit
> +aoedev_exit(void)
> +{
> +	struct aoedev *d;
> +	ulong flags;
> +
> +	flush_scheduled_work();
> +
> +	while ((d = devlist)) {
> +		devlist = d->next;

Surely there must be some lock for devlist?

> +MODULE_VERSION(VERSION);
> +
> +enum { TINIT, TRUN, TKILL };
> +
> +static void
> +discover_timer(ulong vp)
> +{
> +	static struct timer_list t;
> +	static volatile ulong die;
> +	static spinlock_t lock;
> +	ulong flags;
> +	enum { DTIMERTICK = HZ * 60 }; /* one minute */
> +
> +	switch (vp) {

> +	case TINIT:
> +		init_timer(&t);
> +		spin_lock_init(&lock);
> +		t.data = TRUN;
> +		t.function = discover_timer;
> +		die = 0;
> +	case TRUN:

I don't see any code that ever calls it with vp != TINIT ?


> +aoe_init(void)
> +{
> +	int n, (**p)(void);
> +	int (*fns[])(void) = {
> +		aoedev_init, aoechr_init, aoeblk_init, aoenet_init, NULL
> +	};

static? 

> +
> +	for (p=fns; *p != NULL; p++) {
> +		n = (*p)();
> +		if (n) {
> +			aoe_exit();
> +			printk(KERN_INFO "aoe: aoe_init: initialisation failure.\n");
> +			return n;
> +		}
> +	}

Nothing against obfuscated code, but wouldn't it have been much clearer and shorter
to just call these four functions directly?

> + * (1) i have no idea if this is redundant, but i can't figure why
> + * the ifp is passed in if it is.
> + *
> + * (2) len doesn't include the header by default.  I want this. 
> + */
> +static int
> +aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt)
> +{
> +	struct aoe_hdr *h;
> +	ulong n;
> +
> +	skb = skb_check(skb);
> +	if (!skb)
> +		return 0;
> +
> +	skb->dev = ifp;	/* (1) */

This looks certainly wrong. If you copy or destroy device
pointers you have to manage the reference count of the device.

> +
> +	if (!is_aoe_netif(ifp))
> +		goto exit;
> +
> +	skb->len += ETH_HLEN;	/* (2) */
> +
> +	h = (struct aoe_hdr *) skb->mac.raw;
> +	n = __be32_to_cpu(*((u32 *) h->tag));

Why do you use the private __ functions here?
Normally this is just ntohl()

> +	if ((h->verfl & AOEFL_RSP) == 0 || (n & 1<<31))
> +		goto exit;
> +
> +	if (h->verfl & AOEFL_ERR) {
> +		n = h->err;
> +		if (n > NECODES)
> +			n = 0;
> +		printk(KERN_CRIT "aoe: aoenet_rcv: error packet from %d.%d; "
> +			"ecode=%d '%s'\n",
> +		       __be16_to_cpu(*((u16 *) h->major)), h->minor, 
> +			h->err, aoe_errlist[n]);

That's a network triggerable printk, right? You should at least add
some load limit checking, otherwise it allows an attacker to fill up
your log disk.


-Andi
