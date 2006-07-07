Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWGGAUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWGGAUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGGAUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:20:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWGGAUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:20:52 -0400
Date: Thu, 6 Jul 2006 17:24:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mr. Berkley Shands" <bshands@exegy.com>
Cc: linux-kernel@vger.kernel.org, dlloyd@exegy.com
Subject: Re: 2.6.17 x86_64 regression - reboot fails due to deadlock
Message-Id: <20060706172424.01765d67.akpm@osdl.org>
In-Reply-To: <44AD37C2.50601@exegy.com>
References: <44AD37C2.50601@exegy.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. Berkley Shands" <bshands@exegy.com> wrote:
>
> With a SuperMicro H8DC8 (nvidia chipset), Dual Opteron 285's, 16GB, 
> Centos 4.3 -
> 
> Under 2.6.16 both the tyan 2895 and the supermicro H8DC8 both will 
> reboot corectly,
> in kernel/sys.c machine_restart() gets called. But with the changes to 
> sys.c under 2.6.17,
> a new path is introduced, calling void kernel_restart_prepare(char *cmd)
> which calls blocking_notifier_call_chain(&reboot_notifier_list, 
> SYS_RESTART, cmd); (line 588)
> Which looks at the first element of the notifier list, and blocks 
> forever. But ONLY on the supermicro.
> The tyan, a very similar motherboard does not deadlock. It returns and 
> still calls machine_restart().
> So neither reboot nor "shutdown -fh now" actually get to the bios calls.
> 
> on the supermicro, (linux-2.6.17/kernel/sys.c)
> 
> static int __kprobes notifier_call_chain(struct notifier_block **nl,
>                 unsigned long val, void *v)
> {
>         int ret = NOTIFY_DONE;
>         struct notifier_block *nb;
> 
>         nb = rcu_dereference(*nl);
>         while (nb) {
>                 ret = nb->notifier_call(nb, val, v);         /* this is 
> the deadlock for the first entry */
>                 if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
>                         break;
>                 nb = rcu_dereference(nb->next);
>         }
>         return ret;
> }
> 
> I see that 2.6.18 reworks this code further.
> 
> If I want to hurt myself really, really badly, disabling the call to 
> blocking_notifier_call_chain(&reboot_notifier_list,...
> restores the reboot/power off functions.
> 
> In kdb, the system sits idle awaiting something to schedule, but nothing 
> will schedule since there is
> a deadlock on the supermicro. Any clues as to how to find which notifier 
> is deadlocked?
> 

Are you able to do sysrq-T when it's stuck?

Something like this...
diff -puN kernel/sys.c~a kernel/sys.c

--- a/kernel/sys.c~a
+++ a/kernel/sys.c
@@ -70,6 +70,8 @@
 int overflowuid = DEFAULT_OVERFLOWUID;
 int overflowgid = DEFAULT_OVERFLOWGID;
 
+static int foo;
+
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
 EXPORT_SYMBOL(overflowgid);
@@ -141,6 +143,9 @@ static int __kprobes notifier_call_chain
 	nb = rcu_dereference(*nl);
 	while (nb) {
 		next_nb = rcu_dereference(nb->next);
+		if (foo)
+			print_symbol("calling %s()\n",
+				(unsigned long)nb->notifier_call);
 		ret = nb->notifier_call(nb, val, v);
 		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
 			break;
@@ -590,6 +595,7 @@ EXPORT_SYMBOL_GPL(emergency_restart);
 
 static void kernel_restart_prepare(char *cmd)
 {
+	foo = 1;
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	device_shutdown();
_


Be aware that there's a known lock_cpu_hotplug()-vs-cpufreq deadlock, but
afaik it's only been reported during suspend.  Disabling CONFIG_HOTPLUG_CPU
might make a difference.
