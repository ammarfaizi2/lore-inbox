Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130689AbQJOMXA>; Sun, 15 Oct 2000 08:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130680AbQJOMWv>; Sun, 15 Oct 2000 08:22:51 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:29933 "EHLO isis.its.uow.edu.au") by vger.kernel.org with ESMTP id <S129732AbQJOMWe>; Sun, 15 Oct 2000 08:22:34 -0400
Message-ID: <39E99F2C.BD33D5C5@uow.edu.au>
Date: Sun, 15 Oct 2000 23:12:28 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: "David S. Miller" <davem@redhat.com>
Subject: On labelled initialisers, gcc-2.7.2.3 and tcp_ipv4.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in gcc-2.7.2.3.  It incorrectly lays out
structure initialisers when the `name:value;' construct is used.


Here is the degenerate case:

	struct struct_1 { int a; };

	struct thing {
	        int a;
	        struct struct_1 b;
	};

	struct thing a_thing = {
	//      a: 0,		/* Uncomment this for correct code */
	        b: {0},
	};


Which produces:

	        .file   "e.c"
	        .version        "01.01"
	gcc2_compiled.:
	.globl a_thing
	.data
	        .align 4
	        .type    a_thing,@object
	        .size    a_thing,8
	a_thing:
	        .zero   4
	        .zero   4
	        .long 0
	        .ident  "GCC: (GNU) 2.7.2.3"

Note the extra `.zero 4'.

As far as I can tell the rule to follow is this:

     If a structure has nested structures, and if you are
     initialising one of the nested structures then you
     _must_ initialise all fields which precede that nested
     structure.


There are five ways to fix this:

1: Remember to initialise all fields which precede
   initialised structures.

2: Arrange your struct so that all nested structs come first
   and remember to initialise them all.

3: Don't use gcc-2.7.2.3 (use one of the later compilers and
   put up with 50% longer build times).

4: Fix gcc-2.7.2.3

5: Don't use named initialisers.


David, your recent changes to tcp_ipv4.c make 2.7.2.3-compiled
kernels fail very strangely.  I used option 2 to fix it:




--- linux-2.4.0-test10-pre3/include/net/tcp.h	Sat Oct 14 17:02:04 2000
+++ linux-akpm/include/net/tcp.h	Sun Oct 15 22:56:38 2000
@@ -90,6 +90,24 @@
 };
 
 extern struct tcp_hashinfo {
+	rwlock_t __tcp_lhash_lock;
+	atomic_t __tcp_lhash_users;
+	wait_queue_head_t __tcp_lhash_wait;
+	spinlock_t __tcp_portalloc_lock;
+
+	/* All sockets in TCP_LISTEN state will be in here.  This is the only
+	 * table where wildcard'd TCP sockets can exist.  Hash function here
+	 * is just local port number.
+	 */
+	struct sock *__tcp_listening_hash[TCP_LHTABLE_SIZE];
+
+	/*
+	 * All the below members are written once at bootup and are
+	 * never written again _or_ are predominantly read-access.
+	 * Hence we align to a new cache line as all the preceding members
+	 * are often dirty.
+	 */
+
 	/* This is for sockets with full identity only.  Sockets here will
 	 * always be without wildcards and will have the following invariant:
 	 *
@@ -97,8 +115,10 @@
 	 *
 	 * First half of the table is for sockets not in TIME_WAIT, second half
 	 * is for TIME_WAIT sockets only.
+	 *
 	 */
-	struct tcp_ehash_bucket *__tcp_ehash;
+	struct tcp_ehash_bucket *__tcp_ehash
+		__attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 	/* Ok, let's try this, I give up, we do need a local binding
 	 * TCP hash as well as the others for fast bind/connect.
@@ -107,24 +127,6 @@
 
 	int __tcp_bhash_size;
 	int __tcp_ehash_size;
-
-	/* All sockets in TCP_LISTEN state will be in here.  This is the only
-	 * table where wildcard'd TCP sockets can exist.  Hash function here
-	 * is just local port number.
-	 */
-	struct sock *__tcp_listening_hash[TCP_LHTABLE_SIZE];
-
-	/* All the above members are written once at bootup and
-	 * never written again _or_ are predominantly read-access.
-	 *
-	 * Now align to a new cache line as all the following members
-	 * are often dirty.
-	 */
-	rwlock_t __tcp_lhash_lock
-		__attribute__((__aligned__(SMP_CACHE_BYTES)));
-	atomic_t __tcp_lhash_users;
-	wait_queue_head_t __tcp_lhash_wait;
-	spinlock_t __tcp_portalloc_lock;
 } tcp_hashinfo;
 
 #define tcp_ehash	(tcp_hashinfo.__tcp_ehash)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
