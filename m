Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272830AbRIMXSH>; Thu, 13 Sep 2001 19:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272798AbRIMXRw>; Thu, 13 Sep 2001 19:17:52 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:44540 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272797AbRIMXR3>;
	Thu, 13 Sep 2001 19:17:29 -0400
Date: Thu, 13 Sep 2001 16:17:48 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir248_sk_free_2.diff
Message-ID: <20010913161748.B7470@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir248_sk_free_2.diff :
--------------------
	o [CORRECT] Fix socket memory leak (leak struct sock on each socket)
	o [CORRECT] Cleanup init/destroy socket code
		- (kfree -> sk_free, skb_queue_purge, ...)
	o [FEATURE] Cleanup comments & debugging code

diff -u -p linux/net/irda/af_irda.d8.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d8.c	Thu Sep 13 11:23:51 2001
+++ linux/net/irda/af_irda.c	Thu Sep 13 11:24:28 2001
@@ -98,6 +98,8 @@ static int irda_data_indication(void *in
 	struct sock *sk;
 	int err;
 
+	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+
 	self = (struct irda_sock *) instance;
 	ASSERT(self != NULL, return -1;);
 
@@ -128,10 +130,10 @@ static void irda_disconnect_indication(v
 	struct irda_sock *self;
 	struct sock *sk;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
 	self = (struct irda_sock *) instance;
 
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	sk = self->sk;
 	if (sk == NULL)
 		return;
@@ -155,8 +157,10 @@ static void irda_disconnect_indication(v
 	 * Note : all socket function do check sk->state, so we are safe...
 	 * Jean II
 	 */
-	irttp_close_tsap(self->tsap);
-	self->tsap = NULL;
+	if (self->tsap) {
+		irttp_close_tsap(self->tsap);
+		self->tsap = NULL;
+	}
 
 	/* Note : once we are there, there is not much you want to do
 	 * with the socket anymore, apart from closing it.
@@ -180,10 +184,10 @@ static void irda_connect_confirm(void *i
 	struct irda_sock *self;
 	struct sock *sk;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
 	self = (struct irda_sock *) instance;
 
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	sk = self->sk;
 	if (sk == NULL)
 		return;
@@ -238,10 +242,10 @@ static void irda_connect_indication(void
 	struct irda_sock *self;
 	struct sock *sk;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
  	self = (struct irda_sock *) instance;
 
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	sk = self->sk;
 	if (sk == NULL)
 		return;
@@ -358,14 +362,14 @@ static void irda_getvalue_confirm(int re
 {
 	struct irda_sock *self;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
 	self = (struct irda_sock *) priv;
 	if (!self) {
 		WARNING(__FUNCTION__ "(), lost myself!\n");
 		return;
 	}
 
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	/* We probably don't need to make any more queries */
 	iriap_close(self->iriap);
 	self->iriap = NULL;
@@ -539,7 +543,7 @@ static int irda_open_lsap(struct irda_so
  */
 static int irda_find_lsap_sel(struct irda_sock *self, char *name)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(), name=%s\n", name);
+	IRDA_DEBUG(2, __FUNCTION__ "(%p, %s)\n", self, name);
 
 	ASSERT(self != NULL, return -1;);
 
@@ -550,6 +554,8 @@ static int irda_find_lsap_sel(struct ird
 
 	self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
 				 irda_getvalue_confirm);
+	if(self->iriap == NULL)
+		return -ENOMEM;
 
 	/* Treat unexpected signals as disconnect */
 	self->errno = -EHOSTUNREACH;
@@ -777,11 +783,11 @@ static int irda_bind(struct socket *sock
 	struct irda_sock *self;
 	int err;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
 
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	if (addr_len != sizeof(struct sockaddr_irda))
 		return -EINVAL;
 
@@ -942,10 +948,10 @@ static int irda_connect(struct socket *s
 	struct irda_sock *self;
 	int err;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
 	self = sk->protinfo.irda;
 	
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	/* Don't allow connect for Ultra sockets */
 	if ((sk->type == SOCK_DGRAM) && (sk->protocol == IRDAPROTO_ULTRA))
 		return -ESOCKTNOSUPPORT;
@@ -1063,22 +1069,29 @@ static int irda_create(struct socket *so
 		return -ESOCKTNOSUPPORT;
 	}
 
-	/* Allocate socket */
+	/* Allocate networking socket */
 	if ((sk = sk_alloc(PF_IRDA, GFP_ATOMIC, 1)) == NULL)
 		return -ENOMEM;
-	
+
+	/* Allocate IrDA socket */
 	self = kmalloc(sizeof(struct irda_sock), GFP_ATOMIC);
 	if (self == NULL) {
-		kfree (sk);
+		sk_free(sk);
 		return -ENOMEM;
 	}
 	memset(self, 0, sizeof(struct irda_sock));
 
+	IRDA_DEBUG(2, __FUNCTION__ "() : self is %p\n", self);
+
 	init_waitqueue_head(&self->query_wait);
 
-	self->sk = sk;
+	/* Initialise networking socket struct */ 
+	sock_init_data(sock, sk);	/* Note : set sk->refcnt to 1 */
+	sk->family = PF_IRDA;
+	sk->protocol = protocol;
+	/* Link networking socket and IrDA socket structs together */
 	sk->protinfo.irda = self;
-	sock_init_data(sock, sk);
+	self->sk = sk;
 
 	switch (sock->type) {
 	case SOCK_STREAM:
@@ -1110,8 +1123,6 @@ static int irda_create(struct socket *so
 		return -ESOCKTNOSUPPORT;
 	}		
 
-	sk->protocol = protocol;
-
 	/* Register as a client with IrLMP */
 	self->ckey = irlmp_register_client(0, NULL, NULL, NULL);
 	self->mask = 0xffff;
@@ -1133,7 +1144,7 @@ static int irda_create(struct socket *so
  */
 void irda_destroy_socket(struct irda_sock *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
 
 	ASSERT(self != NULL, return;);
 
@@ -1187,12 +1198,47 @@ static int irda_release(struct socket *s
 	sk->state       = TCP_CLOSE;
 	sk->shutdown   |= SEND_SHUTDOWN;
 	sk->state_change(sk);
-	sk->dead        = 1;
 
+	/* Destroy IrDA socket */
 	irda_destroy_socket(sk->protinfo.irda);
+	/* Prevent sock_def_destruct() to create havoc */
+	sk->protinfo.irda = NULL;
 
+	sock_orphan(sk);
         sock->sk   = NULL;      
-        sk->socket = NULL;      /* Not used, but we should do this. */
+
+	/* Purge queues (see sock_init_data()) */
+	skb_queue_purge(&sk->receive_queue);
+
+	/* Destroy networking socket if we are the last reference on it,
+	 * i.e. if(sk->refcnt == 0) -> sk_free(sk) */
+	sock_put(sk);
+
+	/* Notes on socket locking and deallocation... - Jean II
+	 * In theory we should put pairs of sock_hold() / sock_put() to
+	 * prevent the socket to be destroyed whenever there is an
+	 * outstanding request or outstanding incomming packet or event.
+	 *
+	 * 1) This may include IAS request, both in connect and getsockopt.
+	 * Unfortunately, the situation is a bit more messy than it looks,
+	 * because we close iriap and kfree(self) above.
+	 * 
+	 * 2) This may include selective discovery in getsockopt.
+	 * Same stuff as above, irlmp registration and self are gone.
+	 *
+	 * Probably 1 and 2 may not matter, because it's all triggered
+	 * by a process and the socket layer already prevent the
+	 * socket to go away while a process is holding it, through
+	 * sockfd_put() and fput()...
+	 *
+	 * 3) This may include deferred TSAP closure. In particular,
+	 * we may receive a late irda_disconnect_indication()
+	 * Fortunately, (tsap_cb *)->close_pend should protect us
+	 * from that.
+	 *
+	 * I did some testing on SMP, and it looks solid. And the socket
+	 * memory leak is now gone... - Jean II
+	 */
 
         return 0;
 }
@@ -1585,11 +1631,11 @@ static int irda_shutdown(struct socket *
 	struct irda_sock *self;
 	struct sock *sk = sock->sk;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
 
+	IRDA_DEBUG(1, __FUNCTION__ "(%p)\n", self);
+
 	sk->state       = TCP_CLOSE;
 	sk->shutdown   |= SEND_SHUTDOWN;
 	sk->state_change(sk);
@@ -1763,6 +1809,8 @@ static int irda_setsockopt(struct socket
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
 
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+
 	if (level != SOL_IRLMP)
 		return -ENOPROTOOPT;
 		
@@ -2028,6 +2076,8 @@ static int irda_getsockopt(struct socket
 	int offset, total;
 
 	self = sk->protinfo.irda;
+
+	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
 
 	if (level != SOL_IRLMP)
 		return -ENOPROTOOPT;
