Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWFOG4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWFOG4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWFOG4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:56:05 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:19998 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932094AbWFOG4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:56:02 -0400
Date: Thu, 15 Jun 2006 08:55:31 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
       jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, fpavlic@de.ibm.com
Subject: Re: [patch] ipv4: fix lock usage in udp_ioctl
Message-ID: <20060615065531.GA10411@osiris.ibm.com>
References: <20060614194305.GB10391@osiris.ibm.com> <E1FqeXX-0008OE-00@gondolin.me.apana.org.au> <20060615052806.GA19803@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615052806.GA19803@elte.hu>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 08:28:07AM +0200, Ingo Molnar wrote:
> 
> * Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > This is bogus.  These two locks belong to two different queues and 
> > they never intersect.
> 
> yeah - qeth does its own skb-queue management here, and it's done in an 
> irq-safe manner.
> 
> Heiko, in qeth_main.c, could you do something like:
> 
> + static struct lockdep_type_key qdio_out_skb_queue_key;
> 
> ...
> 		skb_queue_head_init(&card->qdio.out_qs[i]->bufs[j].
> 				     skb_list);
> +		lockdep_reinit_key(&card->qdio.out_qs[i]->bufs[j].skb_list,
> 				   &qdio_out_skb_queue_key)

How about the patch below? The warning goes away and I assume "tmp_list" needs
lockdep_reinit_key too, since it should have the same locking rules as the
rest of qeth's skb-queue management.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Avoid false positive illegal lock usage message in qeth driver.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/net/qeth_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/s390/net/qeth_main.c	2006-06-15 08:46:26.000000000 +0200
+++ b/drivers/s390/net/qeth_main.c	2006-06-15 08:29:58.000000000 +0200
@@ -85,6 +85,8 @@ static debug_info_t *qeth_dbf_qerr = NUL
 
 DEFINE_PER_CPU(char[256], qeth_dbf_txt_buf);
 
+static struct lockdep_type_key qdio_out_skb_queue_key;
+
 /**
  * some more definitions and declarations
  */
@@ -3230,6 +3232,9 @@ qeth_alloc_qdio_buffers(struct qeth_card
 				&card->qdio.out_qs[i]->qdio_bufs[j];
 			skb_queue_head_init(&card->qdio.out_qs[i]->bufs[j].
 					    skb_list);
+			lockdep_reinit_key(
+				&card->qdio.out_qs[i]->bufs[j].skb_list.lock,
+				&qdio_out_skb_queue_key);
 			INIT_LIST_HEAD(&card->qdio.out_qs[i]->bufs[j].ctx_list);
 		}
 	}
@@ -5273,6 +5278,7 @@ qeth_free_vlan_buffer(struct qeth_card *
 	struct sk_buff_head tmp_list;
 
 	skb_queue_head_init(&tmp_list);
+	lockdep_reinit_key(&tmp_list.lock, &qdio_out_skb_queue_key);
 	for(i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i){
 		while ((skb = skb_dequeue(&buf->skb_list))){
 			if (vlan_tx_tag_present(skb) &&
