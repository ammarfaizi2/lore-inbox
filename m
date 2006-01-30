Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWA3VwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWA3VwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWA3VwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:52:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64391 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932384AbWA3VwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:52:21 -0500
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<20060129190539.GA26794@kroah.com>
	<m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>
	<20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com>
	<20060130184302.GA17457@kroah.com> <43DE6FE6.40705@cosmosbay.com>
	<m1bqxt5ts3.fsf@ebiederm.dsl.xmission.com>
	<43DE8604.1060109@cosmosbay.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 14:51:09 -0700
In-Reply-To: <43DE8604.1060109@cosmosbay.com> (Eric Dumazet's message of
 "Mon, 30 Jan 2006 22:32:52 +0100")
Message-ID: <m1zmld4c6q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> writes:

> This function is not inlined.
>
> Adding a test and a branch is a matter of 7 bytes.
>
>   'Bloating the icache' is a litle bit off :)

The size all depends on your architecture.  But I agree it
is not much of a size increase in general.

> Avoiding an atomic is important. This is already done elsewhere in the kernel,
> in a inlined function with *many* call sites :
>
> (See kfree_skb() in include/linux//skbuff.h )
>
> /*
>   * If users == 1, we are the only owner and are can avoid redundant
>   * atomic change.
>   */
>
> /**
>   *      kfree_skb - free an sk_buff
>   *      @skb: buffer to free
>   *
>   *      Drop a reference to the buffer and free it if the usage count has
>   *      hit zero.
>   */
> static inline void kfree_skb(struct sk_buff *skb)
> {
>          if (likely(atomic_read(&skb->users) == 1))
>                  smp_rmb();
>          else if (likely(!atomic_dec_and_test(&skb->users)))
>                  return;
>          __kfree_skb(skb);
> }
>
>
> This is a valid optimization : an atomic_dec_and_test() is very expensive.

It is a valid optimization if you will normally have only one user
like a skb.  For other structures that frequently have many users I'm
not at all certain it is a useful optimization.

Eric
