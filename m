Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287945AbSAHLhN>; Tue, 8 Jan 2002 06:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287407AbSAHLgy>; Tue, 8 Jan 2002 06:36:54 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:28678 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287400AbSAHLgp>;
	Tue, 8 Jan 2002 06:36:45 -0500
Date: Tue, 8 Jan 2002 22:32:52 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020108113251.GB20897@krispykreme>
In-Reply-To: <200201071922.g07JMN106760@penguin.transmeta.com> <Pine.LNX.4.33.0201072222100.15970-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201072222100.15970-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I tested 2.5.2-pre10 today. There is some bitop abuse that needs fixing
for big endian machines to work :)

At the moment we have:

	#define BITMAP_SIZE ((MAX_PRIO+7)/8)
	char bitmap[BITMAP_SIZE];

Which is initialised using:

	memset(array->bitmap, 0xff, BITMAP_SIZE);
	clear_bit(MAX_PRIO, array->bitmap);

This results in the following in memory (in ascending memory order):

ffffffffffffffff ffffffffffffffff fffffeffff000000

The problem here is that when we search the high word, we do so from
the right, therefore we get 128 all the time :)

The following patch fixes this. We need to define the bitmap to be in
terms of unsigned long, in this case its only lucky we have the correct
alignment. We also replace the memset of the bitmap with set_bit.

With the patch things look much better (and the kernel boots on my
ppc64 machine :)

ffffffffffffffff ffffffffffffffff 000000ffffffffff 

Anton

diff -urN linuxppc_2_5/include/asm-i386/mmu_context.h linuxppc_2_5_work/include/asm-i386/mmu_context.h
--- linuxppc_2_5/include/asm-i386/mmu_context.h	Tue Jan  8 17:09:47 2002
+++ linuxppc_2_5_work/include/asm-i386/mmu_context.h	Tue Jan  8 22:06:35 2002
@@ -16,7 +16,7 @@
 # error update this function.
 #endif
 
-static inline int sched_find_first_zero_bit(char *bitmap)
+static inline int sched_find_first_zero_bit(unsigned long *bitmap)
 {
 	unsigned int *b = (unsigned int *)bitmap;
 	unsigned int rt;
diff -urN linuxppc_2_5/kernel/sched.c linuxppc_2_5_work/kernel/sched.c
--- linuxppc_2_5/kernel/sched.c	Tue Jan  8 17:09:47 2002
+++ linuxppc_2_5_work/kernel/sched.c	Tue Jan  8 22:13:45 2002
@@ -20,15 +20,13 @@
 #include <linux/interrupt.h>
 #include <asm/mmu_context.h>
 
-#define BITMAP_SIZE ((MAX_PRIO+7)/8)
-
 typedef struct runqueue runqueue_t;
 
 struct prio_array {
 	int nr_active;
 	spinlock_t *lock;
 	runqueue_t *rq;
-	char bitmap[BITMAP_SIZE];
+	unsigned long bitmap[3];
 	list_t queue[MAX_PRIO];
 };
 
@@ -1306,11 +1304,12 @@
 			array = rq->arrays + j;
 			array->rq = rq;
 			array->lock = &rq->lock;
-			for (k = 0; k < MAX_PRIO; k++)
+			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
-			memset(array->bitmap, 0xff, BITMAP_SIZE);
+				__set_bit(k, array->bitmap);
+			}
 			// zero delimiter for bitsearch
-			clear_bit(MAX_PRIO, array->bitmap);
+			__clear_bit(MAX_PRIO, array->bitmap);
 		}
 	}
 	/*
