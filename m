Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTFOQzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFOQzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:55:10 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:12562 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262390AbTFOQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:54:57 -0400
Date: Mon, 16 Jun 2003 02:09:20 +0900 (JST)
Message-Id: <20030616.020920.110657425.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: James.Bottomley@SteelEye.com, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
 misalignment
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030610.091217.112601441.davem@redhat.com>
References: <1055221067.11728.14.camel@mulgrave>
	<20030610.091217.112601441.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030610.091217.112601441.davem@redhat.com> (at Tue, 10 Jun 2003 09:12:17 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:

>    From: James Bottomley <James.Bottomley@SteelEye.com>
>    Date: 09 Jun 2003 23:57:46 -0500
>    
>    A fix that seems to work for me on parisc64 is to move the atomic_t out
>    of the end of struct sock_common and back into the two other structures
>    (so struct sock_common now ends on 0 mod 8).
>    
> I would suggest instead to add the proper alignment attribute
> to the appropriate members of the tw bucket.

Like this?

Index: linux-2.5/include/net/tcp.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/net/tcp.h,v
retrieving revision 1.38
diff -u -r1.38 tcp.h
--- linux-2.5/include/net/tcp.h	7 Jun 2003 00:22:34 -0000	1.38
+++ linux-2.5/include/net/tcp.h	15 Jun 2003 15:50:22 -0000
@@ -164,6 +164,14 @@
  * problems of sockets in such a state on heavily loaded servers, but
  * without violating the protocol specification.
  */
+
+/* Address pair should be aligned to 64-bits boundary to avoid penalties. */
+#if (BITS_PER_LONG == 64)
+# define	__tw_aligned	__attribute__ ((aligned(8)))
+#else
+# define	__tw_aligned
+#endif
+
 struct tcp_tw_bucket {
 	/*
 	 * Now struct sock also uses sock_common, so please just
@@ -184,7 +192,7 @@
 	__u16			tw_sport;
 	/* Socket demultiplex comparisons on incoming packets. */
 	/* these five are in inet_opt */
-	__u32			tw_daddr;
+	__u32	__tw_aligned	tw_daddr;
 	__u32			tw_rcv_saddr;
 	__u16			tw_dport;
 	__u16			tw_num;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
