Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWKFHMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWKFHMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbWKFHMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:12:37 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:7302 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932762AbWKFHMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:12:37 -0500
Message-ID: <454ED769.8040302@in.ibm.com>
Date: Mon, 06 Nov 2006 12:04:17 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: menage@google.com
CC: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, jlan@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [PATCH 2/6] Cpusets hooked into containers
References: <20061020183819.656586000@menage.corp.google.com> <20061020190626.810567000@menage.corp.google.com>
In-Reply-To: <20061020190626.810567000@menage.corp.google.com>
Content-Type: multipart/mixed;
 boundary="------------090005050301070501020609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090005050301070501020609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

menage@google.com wrote:
> This patch removes the process grouping code from the cpusets code,
> instead hooking it into the generic container system. This temporarily
> adds cpuset-specific code in kernel/container.c, which is removed by
> the next patch in the series.
> 
> Signed-off-by: Paul Menage <menage@google.com>

I needed the following patches to get the cpuset code to compile.
Inlining two patches makes it hard to distinguish between the patches
and harder to read them, so I am attaching them along with this email.

-- 
	Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs

--------------090005050301070501020609
Content-Type: text/x-patch;
 name="fix-cpuset-guarantee-online-cpus-mems-in-subtree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="fix-cpuset-guarantee-online-cpus-mems-in-subtree.patch"



Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/cpuset.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN kernel/cpuset.c~fix-cpuset-guarantee-online-cpus-mems-in-subtree kernel/cpuset.c
--- linux-2.6.19-rc2/kernel/cpuset.c~fix-cpuset-guarantee-online-cpus-mems-in-subtree	2006-11-06 11:41:25.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/cpuset.c	2006-11-06 11:43:12.000000000 +0530
@@ -1280,10 +1280,12 @@ int __init cpuset_init(void)
 
 static void guarantee_online_cpus_mems_in_subtree(const struct cpuset *cur)
 {
+	struct container *cont;
 	struct cpuset *c;
 
 	/* Each of our child cpusets mems must be online */
-	list_for_each_entry(c, &cur->children, sibling) {
+	list_for_each_entry(cont, &cur->container->children, sibling) {
+		c = container_cs(cont);
 		guarantee_online_cpus_mems_in_subtree(c);
 		if (!cpus_empty(c->cpus_allowed))
 			guarantee_online_cpus(c, &c->cpus_allowed);
_

--------------090005050301070501020609
Content-Type: text/x-patch;
 name="fix-cpuset-proc-operations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-cpuset-proc-operations.patch"



Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/proc/base.c |    7 -------
 1 file changed, 7 deletions(-)

diff -puN fs/proc/base.c~fix-cpuset-proc-operations fs/proc/base.c
--- linux-2.6.19-rc2/fs/proc/base.c~fix-cpuset-proc-operations	2006-11-06 11:47:35.000000000 +0530
+++ linux-2.6.19-rc2-balbir/fs/proc/base.c	2006-11-06 11:48:27.000000000 +0530
@@ -68,7 +68,6 @@
 #include <linux/security.h>
 #include <linux/ptrace.h>
 #include <linux/seccomp.h>
-#include <linux/cpuset.h>
 #include <linux/container.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
@@ -1788,9 +1787,6 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_CONTAINERS
 	REG("container",  S_IRUGO, container),
 #endif
-#ifdef CONFIG_CPUSETS
-	REG("cpuset",     S_IRUGO, cpuset),
-#endif
 	INF("oom_score",  S_IRUGO, oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, oom_adjust),
 #ifdef CONFIG_AUDITSYSCALL
@@ -2065,9 +2061,6 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_CONTAINERS
 	REG("container",  S_IRUGO, container),
 #endif
-#ifdef CONFIG_CPUSETS
-	REG("cpuset",    S_IRUGO, cpuset),
-#endif
 	INF("oom_score", S_IRUGO, oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, oom_adjust),
 #ifdef CONFIG_AUDITSYSCALL
_

--------------090005050301070501020609--
