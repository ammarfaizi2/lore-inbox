Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132209AbRBKKpx>; Sun, 11 Feb 2001 05:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132196AbRBKKpd>; Sun, 11 Feb 2001 05:45:33 -0500
Received: from [194.213.32.137] ([194.213.32.137]:8964 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132192AbRBKKpQ>;
	Sun, 11 Feb 2001 05:45:16 -0500
Message-ID: <20010211002955.I7877@bug.ucw.cz>
Date: Sun, 11 Feb 2001 00:29:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1
In-Reply-To: <E14PcpU-0004U1-00@halfway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14PcpU-0004U1-00@halfway>; from Rusty Russell on Mon, Feb 05, 2001 at 03:00:40PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I did the infrastructure, Anton did the bugfinding and PPC support,
> aka. the hard stuff.  Other architectures need to implement
> __cpu_disable, __cpu_die and __cpu_up for them to work.  Volunteers
> appreciated.
> 
> 	This patch allows you to down & up CPUs as follows:
> 	# echo 0 > /proc/sys/cpu/0/online
> 	# echo 1 > /proc/sys/cpu/0/online
> 
> The relatively trivial patch works as follows:
> 
> 1) Implements synchronize_kernel() (thanks Andi Kleen for forwarding
>    Paul McKenney's quiescent-state ideas) which waits for a schedule
>    on all CPUs.
> 2) All CPU numbers are now physical: removes cpu_number_map,
>    cpu_logical_map and smp_num_cpus.
> 3) Adds cpu_online(cpu) and cpu_num_online() macros.
> 4) Adds cpu_down() and cpu_up() calls, which call arch-specific
>    __cpu_disable(cpu), __cpu_die(cpu) and __cpu_up(cpu).
> 5) Fixes schedule() to check allowed_cpus even if rescheduling same
>    task.

This is not quite right:

@@ -1643,7 +1643,7 @@
                printk(KERN_NOTICE "apm: disabled on user
request.\n");
                return -ENODEV;
        }
-       if ((smp_num_cpus > 1) && !power_off) {
+       if ((num_online_cpus() > 1) && !power_off) {
                printk(KERN_NOTICE "apm: disabled - APM is not SMP
safe.\n");
                return -ENODEV;
        }
@@ -1697,7 +1697,7 @@

        kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES |
CLONE_SIGHAND | SIGCHLD);

-       if (smp_num_cpus > 1) {
+       if (num_online_cpus() > 1) {
                printk(KERN_NOTICE
                   "apm: disabled - APM is not SMP safe (power off
active).\n");
                return 0;

I do not think it is safe to call APM when there is just CPU #5
running. smp_num_cpus in this context means "if we ever had more than
boot cpu".
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
