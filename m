Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWGIK2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWGIK2W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWGIK2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:28:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29066 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030395AbWGIK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:28:21 -0400
Subject: Re: INFO: inconsistent lock state
From: Arjan van de Ven <arjan@infradead.org>
To: Arne Ahrend <aahrend@web.de>
Cc: marcel@holtmann.org, maxk@qualcomm.com, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <793057896@web.de>
References: <793057896@web.de>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 12:28:11 +0200
Message-Id: <1152440891.3255.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 12:02 +0200, Arne Ahrend wrote:
> On Sat, 2006-07-08 at 19:12 +0200, Arjan van de Ven wrote:
> > Arne: Can you try this patch and verify it makes the message go away?
> > [...]
> > --- linux-2.6.17-mm6.orig/include/linux/skbuff.h
> > +++ linux-2.6.17-mm6/include/linux/skbuff.h
> > @@ -609,7 +609,6 @@ extern struct lock_class_key skb_queue_l
> >  static inline void skb_queue_head_init(struct sk_buff_head *list)
> >  {
> >  	spin_lock_init(&list->lock);
> > -	lockdep_set_class(&list->lock, &skb_queue_lock_key);
> >  	list->prev = list->next = (struct sk_buff *)list;
> >  	list->qlen = 0;
> >  }
> 
> With this patch the message at boot goes away. However, I have had one
> instance of the following message at shutdown, but not always.
> This particular one happened with the above patch applied.
> 

I think this is a real bug, well in fact there seem to be 2:

there are 2 locks that have dodgy locking, one is a spinlock one is a
rwlock. Both are used in softirq context, but neither had the proper _bh
marking. The patch below corrects this

---
 net/bluetooth/l2cap.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.17-mm6/net/bluetooth/l2cap.c
===================================================================
--- linux-2.6.17-mm6.orig/net/bluetooth/l2cap.c
+++ linux-2.6.17-mm6/net/bluetooth/l2cap.c
@@ -167,9 +167,9 @@ static int l2cap_conn_del(struct hci_con
 static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct sock *parent)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
-	write_lock(&l->lock);
+	write_lock_bh(&l->lock);
 	__l2cap_chan_add(conn, sk, parent);
-	write_unlock(&l->lock);
+	write_unlock_bh(&l->lock);
 }
 
 static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
@@ -182,14 +182,14 @@ static inline u8 l2cap_get_ident(struct 
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
 
-	spin_lock(&conn->lock);
+	spin_lock_bh(&conn->lock);
 
 	if (++conn->tx_ident > 128)
 		conn->tx_ident = 1;
 
 	id = conn->tx_ident;
 
-	spin_unlock(&conn->lock);
+	spin_unlock_bh(&conn->lock);
 
 	return id;
 }
@@ -1006,7 +1006,7 @@ static inline void l2cap_chan_unlink(str
 {
 	struct sock *next = l2cap_pi(sk)->next_c, *prev = l2cap_pi(sk)->prev_c;
 
-	write_lock(&l->lock);
+	write_lock_bh(&l->lock);
 	if (sk == l->head)
 		l->head = next;
 
@@ -1014,7 +1014,7 @@ static inline void l2cap_chan_unlink(str
 		l2cap_pi(next)->prev_c = prev;
 	if (prev)
 		l2cap_pi(prev)->next_c = next;
-	write_unlock(&l->lock);
+	write_unlock_bh(&l->lock);
 
 	__sock_put(sk);
 }
@@ -1424,7 +1424,7 @@ static inline int l2cap_connect_req(stru
 	if (!sk)
 		goto response;
 
-	write_lock(&list->lock);
+	write_lock_bh(&list->lock);
 
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(list, scid)) {
@@ -1466,7 +1466,7 @@ static inline int l2cap_connect_req(stru
 	result = status = 0;
 
 done:
-	write_unlock(&list->lock);
+	write_unlock_bh(&list->lock);
 
 response:
 	bh_unlock_sock(parent);


