Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbTHUQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbTHUQ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:57:30 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7578
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262832AbTHUQ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:57:28 -0400
Date: Thu, 21 Aug 2003 18:58:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030821165841.GH29612@dualathlon.random>
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk> <3F447D40.5020000@suse.de> <20030821154113.GE29612@dualathlon.random> <3F44EB85.5000108@suse.de> <20030821163938.GG29612@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821163938.GG29612@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 06:39:38PM +0200, Andrea Arcangeli wrote:
> static void do_machine_restart(void * __unused)
> {
> 	clear_bit(smp_processor_id(), &cpu_restart_map);
> 	if (smp_processor_id() == 0) {
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> if the `reboot` program doesn't run by luck on cpu 0, it will be the one
> that will hang instead of the others. the above check must be changed to:
> 
> 	smp_processor_id() == reboot_cpu
> 
> and you should snapshot reboot_cpu in machine_restart_smp. then it won't
> hang anymore.

this untested patch should do the trick:

--- 2.4.22pre7aa1/arch/s390x/kernel/smp.c.~1~	2003-07-19 02:34:04.000000000 +0200
+++ 2.4.22pre7aa1/arch/s390x/kernel/smp.c	2003-08-21 18:48:05.000000000 +0200
@@ -240,11 +240,12 @@ void smp_send_stop(void)
  * Reboot, halt and power_off routines for SMP.
  */
 static volatile unsigned long cpu_restart_map;
+static unsigned long restart_cpu;
 
 static void do_machine_restart(void * __unused)
 {
 	clear_bit(smp_processor_id(), &cpu_restart_map);
-	if (smp_processor_id() == 0) {
+	if (smp_processor_id() == restart_cpu) {
 		/* Wait for all other cpus to enter do_machine_restart. */
 		while (cpu_restart_map != 0);
 		/* Store status of other cpus. */
@@ -263,6 +264,7 @@ static void do_machine_restart(void * __
 
 void machine_restart_smp(char * __unused) 
 {
+	restart_cpu = smp_processor_id();
 	cpu_restart_map = cpu_online_map;
         smp_call_function(do_machine_restart, NULL, 0, 0);
 	do_machine_restart(NULL);

Andrea
