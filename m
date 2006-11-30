Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031503AbWK3VRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031503AbWK3VRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031528AbWK3VRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:17:09 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:56751 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1031503AbWK3VRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:17:08 -0500
Date: Thu, 30 Nov 2006 16:17:06 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: ak@muc.de, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] atomic_cmpxchg return type error
Message-ID: <20061130211705.GA12987@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:11:02 up 99 days, 18:18,  3 users,  load average: 1.09, 1.17, 0.80
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed that a atomic_cmpxchg, that would be given an atomic64_t
parameter, would cast the return value as a (int). In the typical use of this
primitive, the result would be that the 32 MSB would be lost when comparing
against the original value. It also affects atomic_add_unless. Note that there
is no atomic64_cmpxchg nor atomic64_add_unless, which might make things a
little clearer.

Here is a quick fix for this against 2.6.18.

Regards,

Mathieu

-- BEGIN --
--- a/include/asm-x86_64/atomic.h
+++ b/include/asm-x86_64/atomic.h
@@ -388,7 +388,8 @@ static __inline__ long atomic64_sub_retu
 #define atomic64_inc_return(v)  (atomic64_add_return(1,v))
 #define atomic64_dec_return(v)  (atomic64_sub_return(1,v))
 
-#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_cmpxchg(v, old, new) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), old, new))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
@@ -402,7 +403,7 @@ #define atomic_xchg(v, new) (xchg(&((v)-
  */
 #define atomic_add_unless(v, a, u)				\
 ({								\
-	int c, old;						\
+	__typeof__((v)->counter) c, old;			\
 	c = atomic_read(v);					\
 	for (;;) {						\
 		if (unlikely(c == (u)))				\
-- END --


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
