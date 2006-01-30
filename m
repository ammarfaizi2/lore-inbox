Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWA3Vcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWA3Vcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWA3Vcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:32:55 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:25046 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750862AbWA3Vcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:32:54 -0500
Message-ID: <43DE8604.1060109@cosmosbay.com>
Date: Mon, 30 Jan 2006 22:32:52 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>	<20060129190539.GA26794@kroah.com>	<m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>	<20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com>	<20060130184302.GA17457@kroah.com> <43DE6FE6.40705@cosmosbay.com> <m1bqxt5ts3.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqxt5ts3.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman a écrit :
> Eric Dumazet <dada1@cosmosbay.com> writes:
> 
>> Greg KH a écrit :
>>> On Mon, Jan 30, 2006 at 06:19:35AM +0100, Eric Dumazet wrote:
>>>> Example of improvement in kref_put() :
>>>>
>>>> [PATCH] kref : Avoid an atomic operation in kref_put() when the last
>>>> reference is dropped. On most platforms, atomic_read() is a plan read of the
>>>> counter and involves no atomic at all.
>>> No, we wat to decrement and test at the same time, to protect against
>>> any race where someone is incrementing right when we are dropping the
>>> last reference.
>> Sorry ? Me confused !
> 
> Largely I think you have the right of it, that the optimization is
> correct.  My biggest complaint is that the common case is going to be
> several references to the data structure.  Releasing the references
> will always be slow.  To do the read you need to get the value into
> the cache line.
> 
> So it looks to me like you are optimizing the wrong case and
> bloating the icache with unnecessary code.

This function is not inlined.

Adding a test and a branch is a matter of 7 bytes.

  'Bloating the icache' is a litle bit off :)

Avoiding an atomic is important. This is already done elsewhere in the kernel, 
in a inlined function with *many* call sites :

(See kfree_skb() in include/linux//skbuff.h )

/*
  * If users == 1, we are the only owner and are can avoid redundant
  * atomic change.
  */

/**
  *      kfree_skb - free an sk_buff
  *      @skb: buffer to free
  *
  *      Drop a reference to the buffer and free it if the usage count has
  *      hit zero.
  */
static inline void kfree_skb(struct sk_buff *skb)
{
         if (likely(atomic_read(&skb->users) == 1))
                 smp_rmb();
         else if (likely(!atomic_dec_and_test(&skb->users)))
                 return;
         __kfree_skb(skb);
}


This is a valid optimization : an atomic_dec_and_test() is very expensive.

Eric
