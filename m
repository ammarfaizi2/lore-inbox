Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSLUOhs>; Sat, 21 Dec 2002 09:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSLUOhs>; Sat, 21 Dec 2002 09:37:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:65461 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261322AbSLUOhs>; Sat, 21 Dec 2002 09:37:48 -0500
Message-ID: <3E047D6C.1030702@BitWagon.com>
Date: Sat, 21 Dec 2002 06:40:44 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML
References: <200212200241.VAA04202@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent races between valgrind for UML and kernel allocators which
valgrind does not "know", then the VALGRIND_* declarations being added to kernel
allocators should allow for expressing the concept "atomically change state in
both allocator and valgrind".  One example might be
	VALGRIND_STORE_AND_UPDATE(ptr, value, n, ranges)
with semantics
	struct vg_update {
		void const *addr;  /* valgrind itself never changes the contents */
		unsigned length;
		enum {vg_na, vg_w, vg_rw, vg_ro} new_state;
	} *ranges;

	valgrind_lock();
	*ptr = value;
	valgrind_update(n, ranges);  /* ranges should not overlap */
	valgrind_unlock();

In general there is a need for such a primitive for each kind of atomic
operation performed by an allocator: on x86, anything with an explicit or
implicit LOCK prefix (INC, DEC, ADD, SUB, AND, OR, XOR, BTR, BTS, BTC, XADD,
XCHG, CMPXCHG are the most likely).  Of course, most actual allocators
already use an explicit software lock which in some cases can subsume the
valgrind lock.  But there are lockless allocators; a circular buffer between
consumer and producer is the simplest.  Also, there are allocators which use
a hardware device as part of the lock: UART FIFO, circular buffer with
hardware on one side, SCSI command queue, etc.

-- 
John Reiser, jreiser@BitWagon.com

