Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFHSHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFHSHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFHSHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:07:33 -0400
Received: from static.labristeknoloji.com ([81.214.24.78]:39914 "EHLO
	yssyk.labristeknoloji.com") by vger.kernel.org with ESMTP
	id S261371AbVFHSHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:07:14 -0400
Message-ID: <42A75E1A.8030803@labristeknoloji.com>
Date: Wed, 08 Jun 2005 21:07:38 +0000
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12-rc6-mm1] add allowed CPUs check into	find_idlest_{group|cpu}()
References: <42A66485.8010208@labristeknoloji.com> <1118191744.5104.49.camel@npiggin-nld.site>
In-Reply-To: <1118191744.5104.49.camel@npiggin-nld.site>
Content-Type: multipart/mixed;
 boundary="------------040908090203090307050700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908090203090307050700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Nick Piggin wrote:
 > [...]
> Hi,

Hi Nick,

 > [...]
> 
> By taking the intersection in find_idlest_cpu, I don't mean checking
> whether or not they intersect as in find_idlest_group. I mean doing
> this:
> 
> 
>     cpumask_t tmp;
> 
>     /* Find the intersection */
>     cpus_and(tmp, group->cpumask, p->cpus_allowed);
> 
>     for_each_cpu_mask(i, tmp) {
> 
> Right? That is effectively the same as what you've got in your patch,
> but it means we don't need to do the cpumask comparison every time
> around the loop (aside from being an extra branch, the actual operation
> itself gets a little costly with huge cpu masks).

You're right, I got it. Updated version is appended.

--- linux-2.6.12-rc6-mm1/kernel/sched.c.orig	2005-06-08 
00:28:59.000000000 +0000
+++ linux-2.6.12-rc6-mm1/kernel/sched.c	2005-06-08 20:45:25.000000000 +0000
@@ -1039,8 +1039,11 @@
  		int local_group;
  		int i;

+		/* Loop over if group has no CPUs allowed */
+		if (!cpus_intersects(group->cpumask, p->cpus_allowed))
+			continue;
+
  		local_group = cpu_isset(this_cpu, group->cpumask);
-		/* XXX: put a cpus allowed check */

  		/* Tally up the load of all CPUs in the group */
  		avg_load = 0;
@@ -1076,13 +1079,17 @@
  /*
   * find_idlest_queue - find the idlest runqueue among the cpus in group.
   */
-static int find_idlest_cpu(struct sched_group *group, int this_cpu)
+static int find_idlest_cpu(struct sched_group *group, struct 
task_struct *p,
+			   int this_cpu)
  {
  	unsigned long load, min_load = ULONG_MAX;
  	int idlest = -1;
  	int i;
+	cpumask_t allowed_cpus;

-	for_each_cpu_mask(i, group->cpumask) {
+	/* Traverse only the allowed CPUs */
+	cpus_and(allowed_cpus, group->cpumask, p->cpus_allowed);
+	for_each_cpu_mask(i, allowed_cpus) {
  		load = source_load(i, 0);

  		if (load < min_load || (load == min_load && i == this_cpu)) {
@@ -1124,7 +1131,7 @@
  		if (!group)
  			goto nextlevel;

-		new_cpu = find_idlest_cpu(group, cpu);
+		new_cpu = find_idlest_cpu(group, t, cpu);
  		if (new_cpu == -1 || new_cpu == cpu)
  			goto nextlevel;


PS: Thanks for your help and patience :-)

> Nick
> 


-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                         Morpheus

--------------040908090203090307050700
Content-Type: text/x-vcard; charset=utf-8;
 name="baris.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="baris.vcf"

YmVnaW46dmNhcmQNCmZuOk0uQmFyaXMgRGVtaXJheQ0KbjpEZW1pcmF5O00uQmFyaXMNCm9y
ZzpMYWJyaXMgVGVrbm9sb2ppDQphZHI6OztUZWtub2tlbnQgU2lsaWtvbiBCaW5hIE5vOjI0
IE9EVFU7QW5rYXJhOzswNjUzMTtUdXJrZXkNCmVtYWlsO2ludGVybmV0OmJhcmlzQGxhYnJp
c3Rla25vbG9qaS5jb20NCnRpdGxlOllhemlsaW0gR2VsaXN0aXJtZSBVem1hbmkNCnRlbDt3
b3JrOis5MDMxMjIxMDE0OTANCnRlbDtmYXg6KzkwMzEyMjEwMTQ5Mg0KeC1tb3ppbGxhLWh0
bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LmxhYnJpc3Rla25vbG9qaS5jb20NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------040908090203090307050700--
