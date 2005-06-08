Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVFHAWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVFHAWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVFHAWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:22:36 -0400
Received: from dsl.static812142478.ttnet.net.tr ([81.214.24.78]:17886 "EHLO
	yssyk.labristeknoloji.com") by vger.kernel.org with ESMTP
	id S262050AbVFHAW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:22:26 -0400
Message-ID: <42A66485.8010208@labristeknoloji.com>
Date: Wed, 08 Jun 2005 03:22:45 +0000
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc6-mm1] add allowed CPUs check into find_idlest_{group|cpu}()
Content-Type: multipart/mixed;
 boundary="------------050902020608000604030705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902020608000604030705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello Nick,
a new patch related with recent thread is appended.

I check for CPUs only, ie. not for intersection, in find_idlest_cpu()
since there should be one-to-one comparison when finding CPU. But I
take intersection of group's CPUs and current task's allowed CPUs in
find_allowed_group(). Comments?

o add allowed CPUs check into find_idlest_group() and find_idlest_cpu()
o change the header of find_idlest_cpu() to be able to access
   allowed CPUs of current task.

diffstat:
  sched.c |   13 ++++++++++---
  1 files changed, 10 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc6-mm1/kernel/sched.c.orig	2005-06-08
00:28:59.000000000 +0000
+++ linux-2.6.12-rc6-mm1/kernel/sched.c	2005-06-08 02:28:28.000000000 +0000
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

  	for_each_cpu_mask(i, group->cpumask) {
+		if (!cpu_isset(i, p->cpus_allowed))
+			continue;
+
  		load = source_load(i, 0);

  		if (load < min_load || (load == min_load && i == this_cpu)) {
@@ -1124,7 +1131,7 @@
  		if (!group)
  			goto nextlevel;

-		new_cpu = find_idlest_cpu(group, cpu);
+		new_cpu = find_idlest_cpu(group, t, cpu);
  		if (new_cpu == -1 || new_cpu == cpu)
  			goto nextlevel;


-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                         Morpheus


--------------050902020608000604030705
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
--------------050902020608000604030705--
