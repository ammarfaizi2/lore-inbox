Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJHOLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTJHOLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:11:47 -0400
Received: from dydimus.dreamhost.com ([66.33.197.17]:29344 "EHLO
	dydimus.dreamhost.com") by vger.kernel.org with ESMTP
	id S261500AbTJHOLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:11:44 -0400
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
From: Tobias DiPasquale <toby@cbcg.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, jmorris@intercode.com.au,
       yoshfuji@linux-ipv6.org
In-Reply-To: <3F840C9C.9050704@pobox.com>
References: <1065617075.1514.29.camel@localhost>
	 <3F840C9C.9050704@pobox.com>
Content-Type: text/plain
Message-Id: <1065622303.1512.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 08 Oct 2003 10:11:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 09:09, Jeff Garzik wrote:
> Tobias DiPasquale wrote:
> > Hi all,
> > 
> > I was debugging one of my iptables/netfilter modules yesterday and I
> > came across this bug in kfree_skb(). One of my functions returns a
> > struct skbuff * on success and NULL on failure. When it failed, the code
> > calling said function attempted to free the struct skbuff *, which at
> > that point was NULL. This produced a kernel panic. I investigated the
> > problem and found that, not only should I be checking for a NULL pointer
> > when freeing the struct skbuff *, but the actual cause of the panic was
> > because kfree_skb() and kfree_skb_fast() do not check for skb==NULL,
> > either. They immediately attempt to dereference the users field of the
> > struct skbuff * in order to decrement that reference counter. 
> 
> 
> I would prefer that you fix your code instead, to not pass NULL to 
> kfree_skb()...
> 

Well, I certainly have done that already ;-) But I have checked kfree()
and vfree() and they have a sanity check for NULL before processing, as
well as those are also the well-known semantics for the userspace free()
call. It seems to me (and I recognize that my understanding is limited)
that it could do no harm and may even help in certain cases. Am I
missing something in why it would be preferable _not_ to check for NULL
in kfree_skb()? Is it a performance issue associated with the extra
overhead of having to check for NULL on every kfree_skb[_fast]() call?
And, if so, could we possibly document in the source code and/or kernel
documentation in order to let less experienced programmers know that
they should under no circumstances pass NULL into these functions? I
certainly didn't know that, since I was working off of the semantics of
the other kernel *free() functions. Help me understand my error in
judgement. Thanks :)



