Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSG1SEZ>; Sun, 28 Jul 2002 14:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSG1SEZ>; Sun, 28 Jul 2002 14:04:25 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:51975 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317002AbSG1SEY>; Sun, 28 Jul 2002 14:04:24 -0400
Date: Sun, 28 Jul 2002 20:07:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: dhowells@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
In-Reply-To: <200207281750.KAA19369@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0207282005360.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 28 Jul 2002, Adam J. Richter wrote:

> 	Although noting in 2.5.29 appears to use downgrade_write(),
> I assume that the facility was added because it is going to be used
> in the near future.  So, I've added what I think is an implementation
> of __downgrade_write for lib/rwsem-spinlock.c.  It is the same as
> __up_write, except that it sets sem->activity to 1.

IMO you have to add the patch below, otherwise you may wake up a writer.

>  Since nothing
> uses it yet, I haven't tested it.

Same problem here.

bye, Roman

diff -u -p -r1.1.1.1 rwsem-spinlock.c
--- lib/rwsem-spinlock.c	21 Oct 2001 23:50:13 -0000	1.1.1.1
+++ lib/rwsem-spinlock.c	28 Jul 2002 18:04:08 -0000
@@ -59,7 +59,7 @@ static inline struct rw_semaphore *__rws
 	/* try to grant a single write lock if there's a writer at the front of the queue
 	 * - we leave the 'waiting count' incremented to signify potential contention
 	 */
-	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
+	if (waiter->flags & RWSEM_WAITING_FOR_WRITE && !sem->activity) {
 		sem->activity = -1;
 		list_del(&waiter->list);
 		waiter->flags = 0;

