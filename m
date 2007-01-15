Return-Path: <linux-kernel-owner+w=401wt.eu-S932126AbXAOJHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbXAOJHK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 04:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbXAOJHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 04:07:09 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:43202 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbXAOJHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 04:07:07 -0500
Message-ID: <45AB42E6.4020507@in.ibm.com>
Date: Mon, 15 Jan 2007 14:31:26 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       serue@us.ibm.com, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, mbligh@google.com,
       winget@google.com, containers@lists.osdl.org, devel@openvz.org
Subject: [PATCH 0/1] Add mount/umount callbacks to containers (Re: [ckrm-tech]
 [PATCH 4/6] containers: Simple CPU accounting container subsystem)
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.755437205@menage.corp.google.com> <45A4F675.3080503@in.ibm.com> <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
In-Reply-To: <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/10/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> I have run into a problem running this patch on a powerpc box. Basically,
>> the machine panics as soon as I mount the container filesystem with
> 
> This is a multi-processor system?
> 
> My guess is that it's a race in the subsystem API that I've been
> meaning to deal with for some time - basically I've been using
> (<foo>_subsys.subsys_id != -1) to indicate that <foo> is ready for
> use, but there's a brief window during subsystem registration where
> that's not actually true.
> 
> I'll add an "active" field in the container_subsys structure, which
> isn't set until registration is completed, and subsystems should use
> that instead. container_register_subsys() will set it just prior to
> releasing callback_mutex, and cpu_acct.c (and other subsystems) will
> check <foo>_subsys.active rather than (<foo>_subsys.subsys_id != -1)
> 
>> I am trying to figure out the reason for the panic and trying to find
>> a fix. Since the introduction of whole hierarchy system, the debugging
>> has gotten a bit harder and taking longer, hence I was wondering if you
>> had any clues about the problem
>>
> 

Hi, Paul,

I figured out the reason for the panic. Here are the fixes

Add mount and umount callbacks. These callbacks can be used by the
controller to figure out the correct root container and also know
whether the controller is currently acitve.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/container.h |    2 ++
 kernel/container.c        |   12 ++++++++++++
 2 files changed, 14 insertions(+)

diff -puN include/linux/container.h~add-mount-callback include/linux/container.h
--- linux-2.6.20-rc3/include/linux/container.h~add-mount-callback	2007-01-12
21:23:00.000000000 +0530
+++ linux-2.6.20-rc3-balbir/include/linux/container.h	2007-01-12
21:23:00.000000000 +0530
@@ -171,6 +171,8 @@ struct container_subsys {
 	void (*exit)(struct container_subsys *ss, struct task_struct *task);
 	int (*populate)(struct container_subsys *ss,
 			struct container *cont);
+	void (*mount)(struct container_subsys *ss, struct container *cont);
+	void (*umount)(struct container_subsys *ss, struct container *cont);

 	int subsys_id;
 #define MAX_CONTAINER_TYPE_NAMELEN 32
diff -puN kernel/container.c~add-mount-callback kernel/container.c
--- linux-2.6.20-rc3/kernel/container.c~add-mount-callback	2007-01-12
21:23:00.000000000 +0530
+++ linux-2.6.20-rc3-balbir/kernel/container.c	2007-01-12 21:42:59.000000000 +0530
@@ -394,6 +394,7 @@ static void container_put_super(struct s
 	int i;
 	struct container *cont = &root->top_container;
 	struct task_struct *g, *p;
+	struct container_subsys *ss;

 	root->sb = NULL;
 	sb->s_fs_info = NULL;
@@ -407,6 +408,11 @@ static void container_put_super(struct s

 	mutex_lock(&callback_mutex);

+	for_each_subsys(hierarchy, ss) {
+		if (ss->umount)
+			ss->umount(ss, cont);
+	}
+
 	/* Remove all tasks from this container hierarchy */
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
@@ -607,6 +613,12 @@ static int container_get_sb(struct file_
 			rcu_assign_pointer(subsys[i]->hierarchy,
 					   hierarchy);
 		}
+
+		for_each_subsys(hierarchy, ss) {
+			if (ss->mount)
+				ss->mount(ss, cont);
+		}
+
 		mutex_unlock(&callback_mutex);
 		synchronize_rcu();

_



	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs

PS: I hope my mailer does not word wrap the patches.
