Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbWHXAtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbWHXAtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 20:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbWHXAtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 20:49:05 -0400
Received: from rune.pobox.com ([208.210.124.79]:16259 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S965289AbWHXAtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 20:49:04 -0400
Date: Wed, 23 Aug 2006 19:48:56 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuset code prevents binding tasks to new cpus
Message-ID: <20060824004856.GK11309@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821140148.435d15f3.pj@sgi.com> <20060821215120.244f1f6f.akpm@osdl.org> <20060822050401.GB11309@localdomain> <20060821221437.255808fa.pj@sgi.com> <20060823221114.GF11309@localdomain> <20060823234953.GH11309@localdomain> <20060823171239.b1e85cec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823171239.b1e85cec.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 23 Aug 2006 18:49:53 -0500
> Nathan Lynch <ntl@pobox.com> wrote:
> 
> >  
> > +static int cpuset_handle_cpuhp(struct notifier_block *nb,
> > +				unsigned long phase, void *_cpu)
> > +{
> > +	unsigned long cpu = (unsigned long)_cpu;
> > +
> > +	mutex_lock(&manage_mutex);
> > +	mutex_lock(&callback_mutex);
> > +
> > +	switch (phase) {
> > +	case CPU_ONLINE:
> > +		cpu_set(cpu, top_cpuset.cpus_allowed);
> > +		break;
> > +	case CPU_DEAD:
> > +		cpu_clear(cpu, top_cpuset.cpus_allowed);
> > +		break;
> > +	}
> > +
> > +	mutex_unlock(&callback_mutex);
> > +	mutex_unlock(&manage_mutex);
> > +
> > +	return 0;
> > +}
> > +
> 
> The above needs #ifdef CONFIG_HOTPLUG_CPU wrappers.

Fixed, thanks.


Update cpus_allowed in top_cpuset when cpus are hotplugged; otherwise
binding a task to a newly hotplugged cpu fails since the toplevel
cpuset has a static copy of whatever cpu_online_map was at boot time.

Signed-off-by: Nathan Lynch <ntl@pobox.com>


--- cpuhp-sched_setaffinity.orig/kernel/cpuset.c
+++ cpuhp-sched_setaffinity/kernel/cpuset.c
@@ -2033,6 +2033,31 @@ out:
 	return err;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int cpuset_handle_cpuhp(struct notifier_block *nb,
+				unsigned long phase, void *_cpu)
+{
+	unsigned long cpu = (unsigned long)_cpu;
+
+	mutex_lock(&manage_mutex);
+	mutex_lock(&callback_mutex);
+
+	switch (phase) {
+	case CPU_ONLINE:
+		cpu_set(cpu, top_cpuset.cpus_allowed);
+		break;
+	case CPU_DEAD:
+		cpu_clear(cpu, top_cpuset.cpus_allowed);
+		break;
+	}
+
+	mutex_unlock(&callback_mutex);
+	mutex_unlock(&manage_mutex);
+
+	return 0;
+}
+#endif
+
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
@@ -2043,6 +2068,8 @@ void __init cpuset_init_smp(void)
 {
 	top_cpuset.cpus_allowed = cpu_online_map;
 	top_cpuset.mems_allowed = node_online_map;
+
+	hotcpu_notifier(cpuset_handle_cpuhp, 0);
 }
 
 /**
