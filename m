Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTHTLv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTHTLv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:51:57 -0400
Received: from ns.suse.de ([195.135.220.2]:54920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261971AbTHTLvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:51:50 -0400
Message-ID: <3F4360D3.8070004@suse.de>
Date: Wed, 20 Aug 2003 13:51:47 +0200
From: Hannes Reinecke <Hannes.Reinecke@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: BKL on reboot ?
References: <3F434BD1.9050704@suse.de.suse.lists.linux.kernel> <p73wud861tg.fsf@oldwotan.suse.de>
In-Reply-To: <p73wud861tg.fsf@oldwotan.suse.de>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Hannes Reinecke <Hannes.Reinecke@suse.de> writes:
> 
> 
>>I've got a dumb question: Why is the BKL held on entering sys_reboot()
>>in kernel/sys.c:405 ?
> 
> 
> Interesting. I have a few SMP deadlocks on x86-64 in reboot too 
> and it's possible that it is the same problem.
> 
> I would hold it during exection of the notifiers, but drop
> it before calling into machine_*
> 
Indeed. Works on s390 and survived several reboots (test still 
continuing). I moved lock_kernel() into the sections that actually _do_ 
something; looks much cleaner IMHO.

THX for your help.

Is it worth to try to push it into mainstream kernel?

Cheers,

Hannes
--

--- linux-2.4.21/kernel/sys.c.orig      2003-08-20 10:52:39.000000000 +0200
+++ linux-2.4.21/kernel/sys.c   2003-08-20 10:52:39.000000000 +0200
@@ -340,11 +340,12 @@
                         magic2 != LINUX_REBOOT_MAGIC2B))
                 return -EINVAL;

-       lock_kernel();
         switch (cmd) {
         case LINUX_REBOOT_CMD_RESTART:
+               lock_kernel();
                 notifier_call_chain(&reboot_notifier_list, SYS_RESTART, 
NULL);
                 printk(KERN_EMERG "Restarting system.\n");
+               unlock_kernel();
                 machine_restart(NULL);
                 break;

@@ -357,20 +358,25 @@
                 break;

         case LINUX_REBOOT_CMD_HALT:
+               lock_kernel();
                 notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
                 printk(KERN_EMERG "System halted.\n");
+               unlock_kernel();
                 machine_halt();
                 do_exit(0);
                 break;

         case LINUX_REBOOT_CMD_POWER_OFF:
+               lock_kernel();
                 notifier_call_chain(&reboot_notifier_list, 
SYS_POWER_OFF, NULL);
                 printk(KERN_EMERG "Power down.\n");
+               unlock_kernel();
                 machine_power_off();
                 do_exit(0);
                 break;

         case LINUX_REBOOT_CMD_RESTART2:
+               lock_kernel();
                 if (strncpy_from_user(&buffer[0], (char *)arg, 
sizeof(buffer) -
1) < 0) {
                         unlock_kernel();
                         return -EFAULT;
@@ -379,14 +385,13 @@

                 notifier_call_chain(&reboot_notifier_list, SYS_RESTART, 
buffer);
                 printk(KERN_EMERG "Restarting system with command 
'%s'.\n", buff
er);
+               unlock_kernel();
                 machine_restart(buffer);
                 break;

         default:
-               unlock_kernel();
                 return -EINVAL;
         }
-       unlock_kernel();
         return 0;
  }

