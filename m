Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTGHLV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGHLVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:21:10 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:59396 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265089AbTGHLSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:18:50 -0400
Date: Tue, 8 Jul 2003 12:33:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@intercode.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
Message-ID: <20030708123304.A17486@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@intercode.com.au>,
	Jeff Garzik <jgarzik@pobox.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030703175153.GC27556@gtf.org> <Mutt.LNX.4.44.0307081942550.7740-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0307081942550.7740-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Tue, Jul 08, 2003 at 07:49:41PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 07:49:41PM +1000, James Morris wrote:
> +struct hashtab {
> +	struct hashtab_node **htable;	/* hash table */
> +	u32 size;			/* number of slots in hash table */
> +	u32 nel;			/* number of elements in hash table */
> +	u32 (*hash_value)(struct hashtab *h, void *key);
> +					/* hash function */
> +	int (*keycmp)(struct hashtab *h, void *key1, void *key2);
> +					/* key comparison function */

We use this callbacks in a bunch opf places, maybe add hash_value_t
and keycmp_t typedefs for them to avoid typing the prototypes all
the time?

> +/*
> +   Creates a new hash table with the specified characteristics.
> +
> +   Returns NULL if insufficent space is available or
> +   the new hash table otherwise.
> + */

Standrad kernel komments are either

/* foo */

or 

/*
 * Foo bar whiz blanbggvsgvb.
 */

> +struct hashtab *
> +hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
> +               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
> +               u32 size);

Documentation/CodingStyle says the type should be on the same line
as the function name.  I don't see that religious but it seems Linus
does according to a recent thread :)

> +/*
> +   Inserts the specified (key, datum) pair into the specified hash table.
> +
> +   Returns -ENOMEM on memory allocation error,
> +   -EEXIST if there is already an entry with the same key,
> +   -EINVAL for general errors or
> +   0 otherwise.
> + */

Maybe add kerneldoc comments in the source file instead of the
header comments?

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/hashtab.h>
> +
> +struct hashtab *
> +hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
> +               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
> +               u32 size)
> +{
> +	u32 i;
> +	struct hashtab *p;
> +
> +	p = kmalloc(sizeof(*p), GFP_KERNEL);

Pass the GFP_ mask down to hashtab_create() maybe?

> +	p->htable = kmalloc(sizeof(p) * size, GFP_KERNEL);
> +	if (p->htable == NULL) {
> +		kfree(p);
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < size; i++)
> +		p->htable[i] = NULL;

memset instead?

> +		memset(newnode, 0, sizeof(*newnode));
> +		newnode->key = key;
> +		newnode->datum = datum;
> +		if (prev) {
> +			newnode->next = prev->next;
> +			prev->next = newnode;

Use hlists?

> +config HASHTAB
> +	tristate "Generic hash table support"

Should this really be a user option or rather implicitly selected
by it's users?

>  CPPFLAGS	:= -D__KERNEL__ -Iinclude
>  CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
> -	  	   -fno-strict-aliasing -fno-common
> +	  	   -fno-strict-aliasing -fno-common -g

accident?

