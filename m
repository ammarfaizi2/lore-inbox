Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFEOhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFEOhC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFEOhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:37:02 -0400
Received: from dsl.static812142478.ttnet.net.tr ([81.214.24.78]:4033 "EHLO
	yssyk.labristeknoloji.com") by vger.kernel.org with ESMTP
	id S261575AbVFEOgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:36:48 -0400
Message-ID: <42A3381F.90801@labristeknoloji.com>
Date: Sun, 05 Jun 2005 17:36:31 +0000
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.12-rc5-mm2] [sched] add allowed CPUs check into find_idlest_group()
Content-Type: multipart/mixed;
 boundary="------------060407060407020601020407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060407060407020601020407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello,
following patch adds check for allowed CPUs into
sched.c:find_idlest_group() -as told in comment line that had
removed-. But, I have several questions about that comment.

Firstly, I've understood it as "Check whether process p is allowed to
run on each CPU of to-be-found idlest group"; is that right?

If so, isn't it more appropriate to do check in find_idlest_cpu()?
Because, we're only interested in CPUs that are in idlest group
but doing a check in find_idlest_group() also checks for CPUs
that are not in idlest group (since we're traversing all the groups
in given domain). Checking this after finding the idlest group
(in find_idlest_cpu() with ordinary call order as in
sched_balance_self()) will save us from extra overhead.

Although I've questions in my mind, I'm sending a patch following
that comment. Any explanation and comment on patch will be
appreciated.

Regards.

Signed-off-by: M.Baris Demiray <baris@labristeknoloji.com>

--- linux-2.6.12-rc5-mm2/kernel/sched.c.orig	2005-06-05 
12:31:04.000000000 +0000
+++ linux-2.6.12-rc5-mm2/kernel/sched.c	2005-06-05 16:49:49.000000000 +0000
@@ -1040,7 +1040,12 @@
  		int i;

  		local_group = cpu_isset(this_cpu, group->cpumask);
-		/* XXX: put a cpus allowed check */
+
+		/* Check whether all CPUs in the group is allowed to run on */
+		for_each_cpu_mask(i, group->cpumask) {
+			if (!cpu_isset(i, p->cpus_allowed))
+				continue;
+		}

  		/* Tally up the load of all CPUs in the group */
  		avg_load = 0;


-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                          Morpheus




--------------060407060407020601020407
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
--------------060407060407020601020407--
