Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWGIKCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWGIKCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWGIKCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:02:05 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:59585 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S932182AbWGIKCE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:02:04 -0400
Reveived: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id 18A824A993;
	Sun,  9 Jul 2006 12:02:03 +0200 (CEST)
Date: Sun, 09 Jul 2006 12:02:02 +0200
Message-Id: <793057896@web.de>
MIME-Version: 1.0
From: Arne Ahrend <aahrend@web.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: INFO: inconsistent lock state
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 19:12 +0200, Arjan van de Ven wrote:
> Arne: Can you try this patch and verify it makes the message go away?
> [...]
> --- linux-2.6.17-mm6.orig/include/linux/skbuff.h
> +++ linux-2.6.17-mm6/include/linux/skbuff.h
> @@ -609,7 +609,6 @@ extern struct lock_class_key skb_queue_l
>  static inline void skb_queue_head_init(struct sk_buff_head *list)
>  {
>  	spin_lock_init(&list->lock);
> -	lockdep_set_class(&list->lock, &skb_queue_lock_key);
>  	list->prev = list->next = (struct sk_buff *)list;
>  	list->qlen = 0;
>  }

With this patch the message at boot goes away. However, I have had one
instance of the following message at shutdown, but not always.
This particular one happened with the above patch applied.

Arne


[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
kbnepd bnep0/2098 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&conn->lock){-+..}, at: [<e29dea5f>] __l2cap_sock_close+0xb9/0x111 [l2cap]
{in-softirq-W} state was registered at:
  [<c012a05e>] lock_acquire+0x4f/0x6d
  [<c0265e61>] _spin_lock+0x24/0x32
  [<e29df9f6>] l2cap_connect_cfm+0x8d/0x12a [l2cap]
  [<e2921d6b>] hci_event_packet+0x65e/0xddb [bluetooth]
  [<e291f279>] hci_rx_task+0x77/0x22f [bluetooth]
  [<c011786f>] tasklet_action+0x45/0x75
  [<c0117a76>] __do_softirq+0x45/0x9f
  [<c010480e>] do_softirq+0x4d/0xab
irq event stamp: 208973
hardirqs last  enabled at (208973): [<c02661f0>] _spin_unlock_irqrestore+0x36/0x55
hardirqs last disabled at (208972): [<c0265c4b>] _spin_lock_irqsave+0xf/0x3c
softirqs last  enabled at (208970): [<c021367d>] lock_sock+0xad/0xb8
softirqs last disabled at (208968): [<c0265cbb>] _spin_lock_bh+0xb/0x37

other info that might help us debug this:
2 locks held by kbnepd bnep0/2098:
 #0:  (bnep_session_sem){----}, at: [<e29e59b6>] bnep_session+0x67b/0x6b5 [bnep]
 #1:  (sk_lock-AF_BLUETOOTH){--..}, at: [<e29dff7b>] l2cap_sock_shutdown+0x18/0x6b [l2cap]

stack backtrace:
 [<c0103433>] show_trace+0x16/0x19
 [<c0103913>] dump_stack+0x1a/0x1f
 [<c01284b8>] print_usage_bug+0x1d0/0x1da
 [<c0128a62>] mark_lock+0x23c/0x35a
 [<c01295f7>] __lock_acquire+0x41b/0x929
 [<c012a05e>] lock_acquire+0x4f/0x6d
 [<c0265e61>] _spin_lock+0x24/0x32
 [<e29dea5f>] __l2cap_sock_close+0xb9/0x111 [l2cap]
 [<e29dff98>] l2cap_sock_shutdown+0x35/0x6b [l2cap]
 [<e29e00a2>] l2cap_sock_release+0x20/0x5f [l2cap]
 [<c02120b9>] sock_release+0x16/0xab
 [<c02123de>] sock_close+0x30/0x3a
 [<c014ec5d>] __fput+0xa8/0x18a
 [<c014ee08>] fput+0x2e/0x33
 [<e29e59cc>] bnep_session+0x691/0x6b5 [bnep]
 [<c01006e9>] kernel_thread_helper+0x5/0xb






__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsstärkeren E-Mail-Postfach!		
Mehr Infos unter http://freemail.web.de/home/landingpad/?mc=021131

