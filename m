Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVFUXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVFUXNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFUXNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:13:04 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:153 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S262442AbVFUXMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:12:21 -0400
Date: Wed, 22 Jun 2005 01:12:14 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
In-Reply-To: <20050621084426.GA13094@elte.hu>
Message-Id: <Pine.OSF.4.05.10506220109490.17063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Esben Nielsen
Work:
 Cotas Computer Technology A/S
 Paludan Mullersvej 82
 8200 Aarhus N 
Private
 Moellegade 7A, 3., 4
 8000 Aarhus C
Phone: 
 +45 86 12 73 79
Mobile:
 +45 27 13 10 05


On Tue, 21 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > I am seeing very high latencies on 2.6.12-RT-V0.7.50-04 with a 
> > modified realfeel2: maximum is 246 us. Shouldn't it be in the order of 
> > 50 us?
> 
> i never got reliable results from realfeel - it should do the kind of 
> careful things rtc_wakeup does to avoid false positives.
> 
I tried with rtc_wakeup while I was at work (which is on my disk at home) 
- but it crashed my machine (one have to be _very_ carefull about what you
do when you run in a task with RT priority!). I have fixed it now (see
below patch) and it is running for the night. Let us see if I get similar
results. 

Esben

diff -Naur wakeup.cc~ wakeup.cc
--- wakeup.cc~  2004-12-10 13:41:59.000000000 +0100
+++ wakeup.cc   2005-06-21 22:28:53.000000000 +0200
@@ -359,8 +359,7 @@
   cycles_t last_cycles_count;
   double max_jitter = 0;
 
-  struct timespec pause;
-  pause.tv_nsec = 10000;
+  struct timespec pause = { 0, 10000};
   
   std::cout.flags(std::ios::fixed);
   std::cout << std::setprecision(1);
@@ -428,7 +427,11 @@
       if (max_number_of_irqs > 0 && total_num_of_irqs >= max_number_of_irqs)
        stopit = true;
     }
-    nanosleep(&pause,0);
+    if(nanosleep(&pause,0))
+      {
+       perror("nanosleep:");
+       exit(1);
+      }
   }
   std::cout << "done." << std::endl;
   std::cout << "total # of irqs:      " << total_num_of_irqs << std::endl;


