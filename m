Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWA0CWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWA0CWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWA0CWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:22:22 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:12805 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030228AbWA0CWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:22:22 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: romieu@fr.zoreil.com (Francois Romieu)
Subject: Re: [lock validator] drivers/net/8139too.c: deadlock?
Cc: mingo@elte.hu, jgarzik@redhat.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, davem@redhat.com
Organization: Core
In-Reply-To: <20060127003511.GA10871@electric-eye.fr.zoreil.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au>
Date: Fri, 27 Jan 2006 13:22:11 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
> Ingo Molnar <mingo@elte.hu> :
> [...]
>> i'm wondering, is this a genuine deadlock, or a false positive? The 
>> dependency chain is quite complex, but looks realistic:
>> 
>>   -> #4 {&dev->xmit_lock}: [<c045294b>] dev_watchdog+0x1b/0xc0
>>   -> #3 {&dev->queue_lock}: [<c0447154>] dev_queue_xmit+0x64/0x290
>>   -> #2 {&((sk)->sk_lock.slock)}: [<c043eb66>] sk_clone+0x66/0x200
>>   -> #1 {&((sk)->sk_lock.slock)}: [<c047a116>] tcp_v4_rcv+0x726/0x9d0
>>   -> #0 {&tp->rx_lock}: [<c033e460>] rtl8139_tx_timeout+0x110/0x1f0
> 
> It looks like watchdog racing against rx_poll (which should/can not
> happen). Do you have something specific in mind ?

You've got it.

rx_poll => rtl8139_rx => netif_receive_skb => ... => tcp_v4_rcv

In fact once we're at netif_receive_skb it's easy to see how we'll grab
xmit_lock again.

Prescription: Move TX timeout handling into a work queue.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
