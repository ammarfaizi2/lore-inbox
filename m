Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUHFUjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUHFUjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268288AbUHFUiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:38:51 -0400
Received: from holomorphy.com ([207.189.100.168]:27343 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268282AbUHFUgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:36:50 -0400
Date: Fri, 6 Aug 2004 13:33:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: PROC_FS=n link errors
Message-ID: <20040806203336.GQ17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040806195804.GC2746@fs.tum.de> <20040806202414.GP17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806202414.GP17188@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 09:58:05PM +0200, Adrian Bunk wrote:
>> Theses patches cause the following link errors with CONFIG_PROC_FS=n:
>> <--  snip  -->
>>   LD      .tmp_vmlinux1
>> arch/i386/kernel/built-in.o(.text+0x45ce): In function `init_irq_proc':
>> : undefined reference to `create_prof_cpu_mask'

On Fri, Aug 06, 2004 at 01:24:14PM -0700, William Lee Irwin III wrote:
> Ugh. Okay, here goes:
> Fix up compile with CONFIG_PROC_FS=n. Accomplish this by conditionally
> declaring create_prof_cpu_mask(), privatizing create_proc_profile(),
> and unconditionally including profile_hit() and profile_tick().

Fix up create_proc_profile() to actually return values, and also
s/unsigned int/atomic_t/ in one last place with a casting to atomic_t
hangover.


-- wli

Index: mm1-2.6.8-rc3/kernel/profile.c
===================================================================
--- mm1-2.6.8-rc3.orig/kernel/profile.c	2004-08-06 13:12:19.567689928 -0700
+++ mm1-2.6.8-rc3/kernel/profile.c	2004-08-06 13:21:00.284528936 -0700
@@ -292,11 +292,12 @@
 	struct proc_dir_entry *entry;
 
 	if (!prof_on)
-		return;
+		return 0;
 	if (!(entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL)))
-		return;
+		return 0;
 	entry->proc_fops = &proc_profile_operations;
-	entry->size = (1+prof_len) * sizeof(unsigned int);
+	entry->size = (1+prof_len) * sizeof(atomic_t);
+	return 0;
 }
 module_init(create_proc_profile);
 #endif /* CONFIG_PROC_FS */
