Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULHI5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULHI5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 03:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULHI5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 03:57:47 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:13805 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261152AbULHI5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 03:57:40 -0500
Message-ID: <41B6C200.50807@cyberone.com.au>
Date: Wed, 08 Dec 2004 19:57:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Dimitri Sivanich <sivanich@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] isolcpus option broken in 2.6.10-rc2-bk2
References: <20041206185221.GA23917@sgi.com> <20041206211817.GB10235@elte.hu>
In-Reply-To: <20041206211817.GB10235@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000807000301080507060100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807000301080507060100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Ingo Molnar wrote:

>* Dimitri Sivanich <sivanich@sgi.com> wrote:
>
>
>>The isolcpus option is broken in 2.6.10-rc2-bk2.  The domains are no longer
>>being properly initialized (which results in a panic at bootup).
>>
>>The following patch fixes this.
>>
>>Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
>>
>
>Acked-by: Ingo Molnar <mingo@elte.hu>
>
>only a minor nit:
>
>
>>+	/* Initialize isolated CPU (physical) domains and groups */
>>+	for_each_cpu_mask(i, cpu_isolated_map) {
>>+		struct sched_domain *sd = NULL;
>>
>
>there's no need to initialize 'sd' to NULL here.
>
>
>>+		int group;
>>+
>>+		sd = &per_cpu(phys_domains, i);
>>+		group = cpu_to_phys_group(i);
>>
>
>>+	for_each_cpu_mask(i, cpu_isolated_map) {
>>+		struct sched_domain *sd = NULL;
>>
>
>ditto.
>
>
>>+		int group;
>>+
>>+		sd = &per_cpu(phys_domains, i);
>>+		group = cpu_to_phys_group(i);
>>+		*sd = SD_CPU_INIT;
>>
>
>	Ingo
>
>
>

Actually, this is wrong. And I was wrong to say that the fix was
to initialize the dummy domain (because its ->flags are 0, there
is no need for it to have anything else set up).

The isolated domains don't need to be set up because they correctly
point to the dummy domain, which is already set up properly (zeroed).
The oops is just a problem with sched_domain_debug.

Andrew and/or Linus, please make sure Dimitri's patch gets reverted
and the attached one applied before 2.6.10.


--------------000807000301080507060100
Content-Type: text/plain;
 name="sched-debug-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-debug-oops.patch"



Fix an oops in sched_domain_debug when using the isolcpus= option.

Also move a debug check for validating groups into the "for-each-group"
loop, where it should be.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/kernel/sched.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~sched-debug-oops kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-debug-oops	2004-12-08 19:51:48.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-12-08 19:53:23.000000000 +1100
@@ -4446,6 +4446,7 @@ static void sched_domain_debug(void)
 				if (sd->parent)
 					printk(" ERROR !SD_LOAD_BALANCE domain has parent");
 				printk("\n");
+				break;
 			}
 
 			printk("span %s\n", str);
@@ -4454,8 +4455,6 @@ static void sched_domain_debug(void)
 				printk(KERN_DEBUG "ERROR domain->span does not contain CPU%d\n", i);
 			if (!cpu_isset(i, group->cpumask))
 				printk(KERN_DEBUG "ERROR domain->groups does not contain CPU%d\n", i);
-			if (!group->cpu_power)
-				printk(KERN_DEBUG "ERROR domain->cpu_power not set\n");
 
 			printk(KERN_DEBUG);
 			for (j = 0; j < level + 2; j++)
@@ -4466,6 +4465,9 @@ static void sched_domain_debug(void)
 					printk(" ERROR: NULL");
 					break;
 				}
+				
+				if (!group->cpu_power)
+					printk(KERN_DEBUG "ERROR group->cpu_power not set\n");
 
 				if (!cpus_weight(group->cpumask))
 					printk(" ERROR empty group:");

_

--------------000807000301080507060100--
