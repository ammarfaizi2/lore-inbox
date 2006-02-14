Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWBNATX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWBNATX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWBNATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:19:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:8680 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030326AbWBNATW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:19:22 -0500
Message-ID: <43F12207.9010507@watson.ibm.com>
Date: Mon, 13 Feb 2006 19:19:19 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SMP BUG
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks the change introduced in 2.6.16-rc2   over 2.6.15
wrt to the SMP initialization are wrong.
Please apply to unroll the change..

Here is the logic ...
sched_init is called from start_kernel before the
architecture specific function cpu_check_smp() is called
which is done as part of rest_init().

On s390 this actually sets the cpu_possible_map, which
is now used in sched_init through the for_each_cpu without
properly being initialized.
As a result bringing 2nd and subsequent cpu online
breaks.

This should be a quick fix, until this chicken and egg
problem is solved otherwise.

-- Hubertus

--- kernel/sched.c.orig 2006-02-13 19:08:28.000000000 -0500
+++ kernel/sched.c      2006-02-13 19:09:08.000000000 -0500
@@ -6111,7 +6111,7 @@ void __init sched_init(void)
         runqueue_t *rq;
         int i, j, k;

-       for_each_cpu(i) {
+       for (i = 0; i < NR_CPUS; i++ ) {
                 prio_array_t *array;

                 rq = cpu_rq(i);

