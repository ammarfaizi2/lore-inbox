Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265463AbRGHT2w>; Sun, 8 Jul 2001 15:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbRGHT2m>; Sun, 8 Jul 2001 15:28:42 -0400
Received: from ns.suse.de ([213.95.15.193]:8719 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266161AbRGHT22>;
	Sun, 8 Jul 2001 15:28:28 -0400
Subject: Re: recvfrom and sockaddr_in.sin_port
From: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
Date: 08 Jul 2001 21:28:27 +0200
In-Reply-To: Adam's message of "8 Jul 2001 18:23:35 +0200"
Message-ID: <ouppubbfcf8.fsf@pigdrop.muc.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam <adam@eax.com> writes:
> 
> 	and as show in above example and other repeated test, the port
> 	part is always set to 0. Shouldn't that be set to port number?

SOCK_RAW has no ports, so no.

> 
> 	on similar token the "padding" part after the IP is always set
> 	to the same pattern. Shouldn't it rather be zeroed, or be
> 	some random data?

It should stay at the old value or alternatively be zeroed. That's a 
kernel bug.

Here is a patch that implements the first alternative. David, please consider
applying.

diff -burp linux/include/linux/in.h linux-work/include/linux/in.h
--- linux/include/linux/in.h	Thu Jul  5 13:18:27 2001
+++ linux-work/include/linux/in.h	Sun Jul  8 19:05:30 2001
@@ -109,6 +109,10 @@ struct in_pktinfo
 };
 
 /* Structure describing an Internet (IP) socket address. */
+/* Note here and in others places is the assumption made that there
+   are no holes in in this structure. This is ok for all architectures
+   which layout structures members at worst to their natural
+   alignment. -AK */
 #define __SOCK_SIZE__	16		/* sizeof(struct sockaddr)	*/
 struct sockaddr_in {
   sa_family_t		sin_family;	/* Address family		*/
@@ -119,7 +123,7 @@ struct sockaddr_in {
   unsigned char		__pad[__SOCK_SIZE__ - sizeof(short int) -
 			sizeof(unsigned short int) - sizeof(struct in_addr)];
 };
-#define sin_zero	__pad		/* for BSD UNIX comp. -FvK	*/
+#define sin_zero	__pad
 
 
 /*
diff -burp linux/net/ipv4/af_inet.c linux-work/net/ipv4/af_inet.c
--- linux/net/ipv4/af_inet.c	Wed Jul  4 17:21:32 2001
+++ linux-work/net/ipv4/af_inet.c	Sun Jul  8 19:05:31 2001
@@ -729,7 +729,7 @@ static int inet_getname(struct socket *s
 		sin->sin_port = sk->sport;
 		sin->sin_addr.s_addr = addr;
 	}
-	*uaddr_len = sizeof(*sin);
+	*uaddr_len = sizeof(offsetof(struct sockaddr_in, sin_zero));
 	return(0);
 }
 
diff -burp linux/net/ipv4/raw.c linux-work/net/ipv4/raw.c
--- linux/net/ipv4/raw.c	Wed Jul  4 17:21:32 2001
+++ linux-work/net/ipv4/raw.c	Sun Jul  8 19:06:10 2001
@@ -493,7 +493,7 @@ int raw_recvmsg(struct sock *sk, struct 
 		goto out;
 
 	if (addr_len)
-		*addr_len = sizeof(*sin);
+		*addr_len = offsetof(struct sockaddr_in, sin_zero);
 
 	if (flags & MSG_ERRQUEUE) {
 		err = ip_recv_error(sk, msg, len);
diff -burp linux/net/ipv4/udp.c linux-work/net/ipv4/udp.c
--- linux/net/ipv4/udp.c	Thu Apr 12 21:11:39 2001
+++ linux-work/net/ipv4/udp.c	Sun Jul  8 19:05:31 2001
@@ -635,7 +635,7 @@ int udp_recvmsg(struct sock *sk, struct 
 	 *	Check any passed addresses
 	 */
 	if (addr_len)
-		*addr_len=sizeof(*sin);
+		*addr_len=offsetof(struct sockaddr_in, sin_zero);
 
 	if (flags & MSG_ERRQUEUE)
 		return ip_recv_error(sk, msg, len);


-Andi
