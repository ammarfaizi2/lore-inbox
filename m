Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319662AbSIMOfD>; Fri, 13 Sep 2002 10:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319663AbSIMOfC>; Fri, 13 Sep 2002 10:35:02 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:40966 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319662AbSIMOfB>; Fri, 13 Sep 2002 10:35:01 -0400
Date: Fri, 13 Sep 2002 18:39:24 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.34] alpha rwsem fix
Message-ID: <20020913183924.A7498@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__down_read_trylock is utterly broken in a contention case,
as Richard pointed out. Here's a replacement.

Ivan.


--- 2.5.34/include/asm-alpha/rwsem.h	Tue Sep  3 01:12:00 2002
+++ linux/include/asm-alpha/rwsem.h	Fri Sep 13 03:31:20 2002
@@ -93,14 +93,16 @@ static inline void __down_read(struct rw
  */
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
-	long res, tmp;
+	long old, new, res;
 
 	res = sem->count;
 	do {
-		tmp = res + RWSEM_ACTIVE_READ_BIAS;
-		if (tmp <= 0)
+		new = res + RWSEM_ACTIVE_READ_BIAS;
+		if (new <= 0)
 			break;
-	} while (cmpxchg(&sem->count, res, tmp) != res);
+		old = res;
+		res = cmpxchg(&sem->count, old, new);
+	} while (res != old);
 	return res >= 0 ? 1 : 0;
 }
 
