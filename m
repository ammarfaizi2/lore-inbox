Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318129AbSG2XkE>; Mon, 29 Jul 2002 19:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSG2XkE>; Mon, 29 Jul 2002 19:40:04 -0400
Received: from [195.223.140.120] ([195.223.140.120]:12320 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318129AbSG2XkD>; Mon, 29 Jul 2002 19:40:03 -0400
Date: Tue, 30 Jul 2002 01:44:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oopsen with rc3-aa3
Message-ID: <20020729234433.GL1201@dualathlon.random>
References: <20020729174238.GA1919@714-cm.cps.unizar.es> <20020729181020.GU1201@dualathlon.random> <20020729223539.GA1936@714-cm.cps.unizar.es> <20020729224737.GJ1201@dualathlon.random> <20020729231203.GA6314@714-cm.cps.unizar.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729231203.GA6314@714-cm.cps.unizar.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 01:12:03AM +0200, J.A. Magallon wrote:
> But -rc3-jam3 bombed on the dual-p4xeon box, but works on a PIII laptop.

I decored the oops and in short rq_target->idle is NULL, so then
resched_task bugs out while reading p->need_resched.

it's the hyperthreading support that bugs out infact.

I had a look and this should fix it (the first one is just a theorical
bug, since it's under an ifdef i386 cpu_number_map is an identity, the
++ thing was the reason I think). Can you test it?

--- 2.4.19rc3aa3/kernel/sched.c.~1~	Sun Jul 28 18:12:19 2002
+++ 2.4.19rc3aa3/kernel/sched.c	Tue Jul 30 01:42:08 2002
@@ -490,7 +490,7 @@ static inline void pull_task(runqueue_t 
  */
 static inline int find_idle_package(int this_cpu)
 {
-	int i = this_cpu + 1;
+	int i = cpu_number_map(this_cpu) + 1;
 
 	if (i == smp_num_cpus)
 		i = 0;
@@ -500,7 +500,7 @@ static inline int find_idle_package(int 
 		physical = cpu_logical_map(i);
 		sibling = cpu_sibling_map[physical];
 
-		if (i++ == smp_num_cpus)
+		if (++i == smp_num_cpus)
 			i = 0;
 		if (idle_cpu(physical) && idle_cpu(sibling))
 			return physical;

Andrea
