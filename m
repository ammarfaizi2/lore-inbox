Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289948AbSAKNZK>; Fri, 11 Jan 2002 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289950AbSAKNZA>; Fri, 11 Jan 2002 08:25:00 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:21510 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S289948AbSAKNYr>; Fri, 11 Jan 2002 08:24:47 -0500
Message-ID: <3C3EE76C.1030808@turbolinux.co.jp>
Date: Fri, 11 Jan 2002 22:23:56 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
Organization: Turbolinx Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:0.9.6) Gecko/20011206
X-Accept-Language: ja
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, sd@turbolinux.co.jp
Subject: Re: [PATCH] removed socket buffer in unix domain socket
In-Reply-To: <E16NaD0-0001Hs-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------010005040202000502080300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010005040202000502080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

What size of actually used hash table --unix_socket_table--?
If it is 256, probably forall_unix_sockets is dangerous.

forall_unix_sockets use 257 table size.
And If I apply this fix, test program can work.

Alan Cox wrote:

 >>                                 */
 >>-                               if(UNIXCB(skb).fp)
 >>+                               if(s->dead && UNIXCB(skb).fp)
 >>                                {
 >>
 >
 > The bug may be real but the fix would prevent garbage collection working
 > at all - which I grant would fix the problem.
 >
 > You don't need a socket to be dead to want to garbage collect it. If a
 > socket is getting disposed of while in use then there is a
 > maybe_unmark_and.. call missing, or a lock on the unix socket table missing
 > somewhere.

-- GO!

--------------010005040202000502080300
Content-Type: text/plain;
 name="af_net.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="af_net.h.patch"

--- linux/include/net/af_unix.h.orig	Tue Apr 25 05:43:04 2000
+++ linux/include/net/af_unix.h	Fri Jan 11 21:49:57 2002
@@ -14,7 +14,7 @@
 extern atomic_t unix_tot_inflight;
 
 
-#define forall_unix_sockets(i, s) for (i=0; i<=UNIX_HASH_SIZE; i++) \
+#define forall_unix_sockets(i, s) for (i=0; i<UNIX_HASH_SIZE; i++) \
                                     for (s=unix_socket_table[i]; s; s=s->next)
 
 struct unix_address


--------------010005040202000502080300--

