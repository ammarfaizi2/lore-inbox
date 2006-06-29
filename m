Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWF2WQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWF2WQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbWF2WQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:16:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932556AbWF2WPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:15:34 -0400
Date: Thu, 29 Jun 2006 15:18:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Rode <rodec@mrduck.net>
Cc: linux-kernel@vger.kernel.org, Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: 2.6.17-mm4
Message-Id: <20060629151853.351a4b08.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606291221500.2985@lithium.mrduck.net>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<Pine.LNX.4.64.0606291221500.2985@lithium.mrduck.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rode <rodec@mrduck.net> wrote:
>
> Starting with -mm3 and continuing with -mm4, I'm getting:
> 
> % make modules_install
> ...
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F 
> System.map  2.6.17-mm4; fi
> WARNING: /lib/modules/2.6.17-mm4/kernel/arch/i386/kernel/msr.ko needs 
> unknown symbol register_cpu_notifier
> WARNING: /lib/modules/2.6.17-mm4/kernel/arch/i386/kernel/cpuid.ko needs 
> unknown symbol register_cpu_notifier
> 
> Defining CONFIG_HOTPLUG_CPU resolves it.  Config is attached.

Thanks.

Chandra, I assume we do this?

--- a/arch/i386/kernel/msr.c~msrc-usr-register_hotcpu_notifier
+++ a/arch/i386/kernel/msr.c
@@ -292,7 +292,7 @@ static int __init msr_init(void)
 		if (err != 0)
 			goto out_class;
 	}
-	register_cpu_notifier(&msr_class_cpu_notifier);
+	register_hotcpu_notifier(&msr_class_cpu_notifier);
 
 	err = 0;
 	goto out;
@@ -315,7 +315,7 @@ static void __exit msr_exit(void)
 		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
 	class_destroy(msr_class);
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
-	unregister_cpu_notifier(&msr_class_cpu_notifier);
+	unregister_hotcpu_notifier(&msr_class_cpu_notifier);
 }
 
 module_init(msr_init);
_

