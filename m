Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287314AbRL3CRN>; Sat, 29 Dec 2001 21:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbRL3CQx>; Sat, 29 Dec 2001 21:16:53 -0500
Received: from relay11.Austria.eu.net ([193.154.160.115]:53127 "EHLO
	relay11.austria.eu.net") by vger.kernel.org with ESMTP
	id <S287284AbRL3CQm>; Sat, 29 Dec 2001 21:16:42 -0500
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
From: Harald Holzer <harald.holzer@eunet.at>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112291618290.24475-100000@shell1.aracnet.com>
In-Reply-To: <Pine.LNX.4.33.0112291618290.24475-100000@shell1.aracnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 30 Dec 2001 03:14:36 +0100
Message-Id: <1009678476.12942.6.camel@hh2.hhhome.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested your suggestion with an 2.4.17rc2aa2 kernel,
but it didnt help.
The system dies after copying more then 6-8GB on data.
Here are the last lines from /var/log/messages:

Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)
Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)
Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)
Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)
Dec 30 01:47:32 localhost last message repeated 3 times
Dec 30 01:47:32 localhost kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)

I started to begin searching in the linux/fs/buffer.c, and found the
following interesting lines (line: 1450+):

void create_empty_buffers(struct page *page, kdev_t dev, unsigned long blocksize)
{
	struct buffer_head *bh, *head, *tail;

	/* FIXME: create_buffers should fail if there's no enough memory */
	head = create_buffers(page, blocksize, 1);
	if (page->buffers)
		BUG();

	bh = head;

Could the create_buffer function cause this problem ?

Harald Holzer

On Sun, 2001-12-30 at 01:25, M. Edward (Ed) Borasky wrote:
> On Sat, 29 Dec 2001, M. Edward (Ed) Borasky wrote:
> 
> > On Sat, 29 Dec 2001, Alan Cox wrote:
> >
> > > Because much of the memory cannot be used for kernel objects there
> > > is an imbalance in available resources and its very hard to balance
> > > them sanely.  I'm not sure how many 8Gb+ machines Andrea has handy
> > > to tune the VM on either.
> >
> > Along those lines -- I have in front of me the source to
> > "/linux/mm/page_alloc.c" (2.4.17 kernel) which reads (partially)
> 
> [snip]
> 
> 
> > Could someone with a big box and a benchmark that drives it out of
> > free memory please try commenting out the "else if" clause and see if
> > it makes a difference? I tried this on my puny 512 MB Athlon and
> > verified that the right values were there with "sysrq", but I don't
> > have anything bigger to try it on and I don't have a benchmark to test
> > it with either.
> 
> And here it is as a patch against 2.4.17:
> 
> diff -ur linux/mm/page_alloc.c linux-2.4.17znmeb/mm/page_alloc.c
> --- linux/mm/page_alloc.c	Mon Nov 19 16:35:40 2001
> +++ linux-2.4.17znmeb/mm/page_alloc.c	Sat Dec 29 16:04:25 2001
> @@ -718,8 +718,13 @@
>  		mask = (realsize / zone_balance_ratio[j]);
>  		if (mask < zone_balance_min[j])
>  			mask = zone_balance_min[j];
> +		/* else if clause commented out for testing
> +		 * M. Edward Borasky, Borasky Research
> +		 * 2001-12-29
> +		 *
>  		else if (mask > zone_balance_max[j])
>  			mask = zone_balance_max[j];
> +		 */
>  		zone->pages_min = mask;
>  		zone->pages_low = mask*2;
>  		zone->pages_high = mask*3;
> 
> 
> Apologies if pine with vim as the editor messes this puppy up :-).
> -- 
> M. Edward Borasky
> 
> znmeb@borasky-research.net
> http://www.borasky-research.net
> 
> I brought my inner child to "Take Your Child To Work Day."
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

