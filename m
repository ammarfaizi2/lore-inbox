Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282074AbRLXGZE>; Mon, 24 Dec 2001 01:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284467AbRLXGYy>; Mon, 24 Dec 2001 01:24:54 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:52380 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S282074AbRLXGYi>;
	Mon, 24 Dec 2001 01:24:38 -0500
Message-ID: <3C26CA24.4090809@candelatech.com>
Date: Sun, 23 Dec 2001 23:24:36 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]:  Make UDP wait for 64k of free buffer before telling select/poll there is space to send.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should allow better handling of large (> 2048 byte) UDP packets
when the socket write buffer is relatively large....

diff -u -r -N -X /home/greear/exclude.list linux/include/net/sock.h linux.dev/include/net/sock.h
--- linux/include/net/sock.h	Fri Dec 21 10:42:04 2001
+++ linux.dev/include/net/sock.h	Sun Dec 23 12:22:52 2001
@@ -1230,7 +1230,16 @@
   */
  static inline int sock_writeable(struct sock *sk)
  {
- 
return sock_wspace(sk) >= SOCK_MIN_WRITE_SPACE;
+   /* The goal is to only signal writable when there is at least 64k of buffer space
+    * when your send buffers are 128k or bigger.  The reason is that otherwise
+    * you get many failed UDP sends when you run > SOCK_MIN_WRITE_SPACE sized packets
+    * at extreme speed (ie faster than your network can keep up).  This change is
+    * designed to make select/poll wait untill you can actually be assured of sending
+    * the UDP packet at least into the kernel buffers w/out dropping it.
+    * This puts us more in line with sock_dev_write_space in core/sock.c too. --Ben
+    */
+   return sock_wspace(sk) >= max(SOCK_MIN_WRITE_SPACE,
+                                 min((unsigned int)(0xFFFF), sk->sndbuf >> 1));
  }

  static inline int gfp_any(void)

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


