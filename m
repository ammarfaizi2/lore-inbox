Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbTGHJz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265666AbTGHJz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:55:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265664AbTGHJz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:55:26 -0400
Date: Tue, 8 Jul 2003 03:09:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@intercode.com.au>
Cc: jgarzik@pobox.com, sds@epoch.ncsc.mil, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, alan@lxorguk.ukuu.org.uk,
       hch@infradead.org, greg@kroah.com, chris@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
Message-Id: <20030708030931.6864972b.akpm@osdl.org>
In-Reply-To: <Mutt.LNX.4.44.0307081942550.7740-100000@excalibur.intercode.com.au>
References: <20030703175153.GC27556@gtf.org>
	<Mutt.LNX.4.44.0307081942550.7740-100000@excalibur.intercode.com.au>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> wrote:
>
> +int hashtab_replace(struct hashtab *h, void *key, void *datum,
>  +		    void (*destroy)(void *k, void *d, void *args),
>  +		    void *args)
>  +{
> ...
>  +		newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);

>From an API perspective, the GFP_KERNEL is a problem.  Particularly as this
code seems to require that the caller perform the locking?

The GFP_KERNEL means that the locking _has_ to be via a sleeping lock
rather than a spinlock, and interrupt-time insertions are not possible.

Would be better to pass in the gfp_flags.


Comparing the complexity (size) of this code with the q-n-d hash tables
which are currently used one does wonder how useful it all will be.  The
additional indirections are not needed with q-n-d hashes.

But if it doesn't significantly add to the overall selinux patch then I
guess it makes sense.


A slab cache for hashtab_nodes would probably save a bit of space.


otoh: It would be faster and more space-efficient to require that the
clients of ths code embed a hastab_node inside their structures and just
pass the address of that hastab_node into here.  When they do a lookup they
retreive their original struct with container_of.  That fixes the GFP_KERNEL
thing too.


