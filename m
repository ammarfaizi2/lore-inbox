Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269669AbUINVUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269669AbUINVUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUINVTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:19:32 -0400
Received: from holomorphy.com ([207.189.100.168]:40086 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269669AbUINVLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:11:15 -0400
Date: Tue, 14 Sep 2004 14:11:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Hawkes <hawkes@sgi.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914211105.GP9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random> <200409140916.48786.jbarnes@engr.sgi.com> <20040914190030.GZ9106@holomorphy.com> <20040914200220.GH9106@holomorphy.com> <20040914200453.GI9106@holomorphy.com> <20040914210422.GM9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914210422.GM9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 01:04:53PM -0700, William Lee Irwin III wrote:
>> Take 2: actually register the notifier I wrote.

On Tue, Sep 14, 2004 at 02:04:22PM -0700, William Lee Irwin III wrote:
> As pointed out by John Hawkes, I forgot to flush the pending hits at
> the time of profile buffer reset. The following patch, atop the cpu
> hotplug notifier bits, does so.

Repost with corrected patch.


As pointed out by John Hawkes, I forgot to flush the pending hits at
the time of profile buffer reset. The following patch, atop the cpu
hotplug notifier bits, does so.

Index: mm5-2.6.9-rc1/kernel/profile.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/profile.c	2004-09-14 13:46:05.151456768 -0700
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-14 14:03:01.854894352 -0700
@@ -37,6 +37,7 @@
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
+static DECLARE_MUTEX(profile_flip_mutex);
 #endif /* CONFIG_SMP */
 
 static int __init profile_setup(char * str)
@@ -242,7 +243,6 @@
 
 static void profile_flip_buffers(void)
 {
-	static DECLARE_MUTEX(profile_flip_mutex);
 	int i, j, cpu;
 
 	down(&profile_flip_mutex);
@@ -261,6 +261,21 @@
 	up(&profile_flip_mutex);
 }
 
+static void profile_discard_flip_buffers(void)
+{
+	int i, cpu;
+
+	down(&profile_flip_mutex);
+	i = per_cpu(cpu_profile_flip, get_cpu());
+	put_cpu();
+	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
+	for_each_online_cpu(cpu) {
+		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[i];
+		memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
+	}
+	up(&profile_flip_mutex);
+}
+
 void profile_hit(int type, void *__pc)
 {
 	unsigned long primary, secondary, flags, pc = (unsigned long)__pc;
@@ -338,6 +353,7 @@
 #endif /* CONFIG_HOTPLUG_CPU */
 #else /* !CONFIG_SMP */
 #define profile_flip_buffers()		do { } while (0)
+#define profile_discard_flip_buffers()	do { } while (0)
 
 void profile_hit(int type, void *__pc)
 {
@@ -456,7 +472,7 @@
 			return -EINVAL;
 	}
 #endif
-
+	profile_discard_flip_buffers();
 	memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
 	return count;
 }
