Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269370AbTCDLCK>; Tue, 4 Mar 2003 06:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269371AbTCDLCK>; Tue, 4 Mar 2003 06:02:10 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:27605 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S269370AbTCDLCC>;
	Tue, 4 Mar 2003 06:02:02 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303041112.h24BCRW22235@csl.stanford.edu>
Subject: [CHECKER] potential races in kernel/*.c mm/*.c net/*ipv4*.c
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Mar 2003 03:12:27 -0800 (PST)
Cc: mc@cs.stanford.edu
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here are a few more potential races from checking the directories:
	kernel/*.c
	mm/*.c
	net/*ipv4*.c
	arch/i386/kernel/*.c

which seem relatively more important that other directories.  [If there
are other subdirs that a worth checking let me know --- I am trying to
ensure that if we release race bugs someone will care enough to look
at them.]

The message format is a bit confusing.  It gives the places where the
checker thinks there are errors, and then a short list of examples
that made it think that an omitted lock protects the variable.

I do apologize if there are false positives --- I've gone over these,
but sometimes it's very hard to tell if state needs to be protected.

Dawson
-------------------------------------------------------
BUG? pair: lock=<struct sighand_struct.siglock>, var=<recalc_sigpending>
  z score=0.90
  singles = 1
  last = 8
  global-var
  1 error out of 11 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/kernel/ptrace.c:339:ptrace_notify: ERROR: var <recalc_sigpending> not protected by <struct sighand_struct.siglock>(pop=11, s=10) [locked=0] [seen_lock=1]


	looks like a bug:

	void ptrace_notify(int exit_code)
	{
        	/* Let the debugger run.  */
        	current->exit_code = exit_code;
        	set_current_state(TASK_STOPPED);
        	notify_parent(current, SIGCHLD);
        	schedule();
	
         	// Signals sent while we were stopped might set TIF_SIGPENDING.
        	recalc_sigpending();

	other places are carefully guard recalc_sigpending with 
	siglock:
        	spin_lock_irqsave(&current->sighand->siglock, flags);
        	current->notifier = NULL;
        	current->notifier_data = NULL;
        	recalc_sigpending();
        	spin_unlock_irqrestore(&current->sighand->siglock, flags);

  ====================================
  10 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:403:unblock_all_signals: NOTE: var <recalc_sigpending> protected by <struct sighand_struct.siglock> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:unblock_all_signals:400] (pop=11, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:2183:sys_ssetmask: NOTE: var <recalc_sigpending> protected by <struct sighand_struct.siglock> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sys_ssetmask:2178] (pop=11, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:2115:sys_sigprocmask: NOTE: var <recalc_sigpending> protected by <struct sighand_struct.siglock> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sys_sigprocmask:2096] (pop=11, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1848:sys_rt_sigtimedwait: NOTE: var <recalc_sigpending> protected by <struct sighand_struct.siglock> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sys_rt_sigtimedwait:1844] (pop=11, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:43:sys_sigsuspend: NOTE: var <recalc_sigpending> protected by <struct sighand_struct.siglock> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:sys_sigsuspend:40] (pop=11, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1656:sigprocmask: NOTE: var <recalc_sigpending> protected by <struct sighand_struct.siglock> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sigprocmask:1640] (pop=11, s=10)
-------------------------------------------------------
BUG?  pair: lock=<socket_lock_t.slock>, var=<struct sock.backlog.tail>
  z score=2.81
  first = 38
  1 error out of 41 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp.c:1580:tcp_recvmsg: ERROR: var <struct sock.backlog.tail> not protected by <socket_lock_t.slock>(pop=41, s=40) [locked=0] [seen_lock=1]

	unprotected read of backlog.tail but it's unclear if this value
	is depended on later.

  ====================================
  40 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp.c:1382:tcp_data_wait: NOTE: var <struct sock.backlog.tail> protected by <socket_lock_t.slock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp.c:tcp_data_wait:1382] (pop=41, s=40)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp.c:1668:tcp_recvmsg: NOTE: var <struct sock.backlog.tail> protected by <socket_lock_t.slock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp.c:tcp_recvmsg:1668] (pop=41, s=40)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/udp.c:691:udp_sendpage: NOTE: var <struct sock.backlog.tail> protected by <socket_lock_t.slock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/udp.c:udp_sendpage:691] (pop=41, s=40)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_sockglue.c:688:ip_getsockopt: NOTE: var <struct sock.backlog.tail> protected by <socket_lock_t.slock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_sockglue.c:ip_getsockopt:688] (pop=41, s=40)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/udp.c:627:udp_sendmsg: NOTE: var <struct sock.backlog.tail> protected by <socket_lock_t.slock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/udp.c:udp_sendmsg:627] (pop=41, s=40)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_sockglue.c:642:ip_setsockopt: NOTE: var <struct sock.backlog.tail> protected by <socket_lock_t.slock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_sockglue.c:ip_setsockopt:642] (pop=41, s=40)
-------------------------------------------------------
BUG?  pair: lock=<struct sighand_struct.siglock>, var=<struct task_struct.blocked>
  z score=-0.17
  singles = 1
  first = 3
  2 errors out of 9 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:583:do_signal: ERROR: var <struct task_struct.blocked> not protected by <struct sighand_struct.siglock>(pop=9, s=7) [locked=0] [seen_lock=1]

	seems like it: other places are careful about getting
	current->blocked.  here there is no lock at all:
	
asmlinkage int
sys_sigsuspend(int history0, int history1, old_sigset_t mask)
{
...
        regs->eax = -EINTR;
        while (1) {
                current->state = TASK_INTERRUPTIBLE;
                schedule();
                if (do_signal(regs, &saveset))
                        return -EINTR;

	...

// do_signal:

        if (!oldset)
                oldset = &current->blocked;

  ====================================
  7 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1686:sys_rt_sigprocmask: NOTE: var <struct task_struct.blocked> protected by <struct sighand_struct.siglock> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sys_rt_sigprocmask:1685] (pop=9, s=7)

                spin_lock_irq(&current->sighand->siglock);
                old_set = current->blocked;
                spin_unlock_irq(&current->sighand->siglock)

    /u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:70:sys_rt_sigsuspend: NOTE: var <struct task_struct.blocked> protected by <struct sighand_struct.siglock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:sys_rt_sigsuspend:69] (pop=9, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:41:sys_sigsuspend: NOTE: var <struct task_struct.blocked> protected by <struct sighand_struct.siglock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/arch/i386/kernel/signal.c:sys_sigsuspend:40] (pop=9, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1641:sigprocmask: NOTE: var <struct task_struct.blocked> protected by <struct sighand_struct.siglock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sigprocmask:1640] (pop=9, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1846:sys_rt_sigtimedwait: NOTE: var <struct task_struct.blocked> protected by <struct sighand_struct.siglock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sys_rt_sigtimedwait:1844] (pop=9, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1836:sys_rt_sigtimedwait: NOTE: var <struct task_struct.blocked> protected by <struct sighand_struct.siglock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:sys_rt_sigtimedwait:1824] (pop=9, s=7)
-------------------------------------------------------
BUG? pair: lock=<struct sighand_struct.siglock>, var=<struct task_struct.signal.group_stop_count>
  z score=-0.57
  singles = 1
  2 errors out of 7 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1483:get_signal_to_deliver: ERROR: var <struct task_struct.signal.group_stop_count> not protected by <struct sighand_struct.siglock>(pop=7, s=5) [locked=0] [seen_lock=1]

   seems like a race, since someone else could have slipped in and
   decremented group_stop_count after the check and before the
   acquisition:

                        if (current->signal->group_stop_count > 0) {
                                spin_lock_irq(&current->sighand->siglock);
                                --current->signal->group_stop_count;
                                spin_unlock_irq(&current->sighand->siglock
  ====================================
  5 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1485:get_signal_to_deliver: NOTE: var <struct task_struct.signal.group_stop_count> protected by <struct sighand_struct.siglock> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:get_signal_to_deliver:1484] (pop=7, s=5)

                        if (current->signal->group_stop_count > 0) {
                                spin_lock_irq(&current->sighand->siglock);
                                --current->signal->group_stop_count;
                                spin_unlock_irq(&current->sighand->siglock

    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:207:recalc_sigpending_tsk: NOTE: var <struct task_struct.signal.group_stop_count> protected by <struct sighand_struct.siglock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exit.c:exit_notify:624
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exit.c:exit_notify:631
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exit.c:exit_notify:627
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:recalc_sigpending_tsk:207] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/fork.c:958:copy_process: NOTE: var <struct task_struct.signal.group_stop_count> protected by <struct sighand_struct.siglock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/fork.c:copy_process:944] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:1461:get_signal_to_deliver: NOTE: var <struct task_struct.signal.group_stop_count> protected by <struct sighand_struct.siglock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/signal.c:get_signal_to_deliver:1447] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/fork.c:964:copy_process: NOTE: var <struct task_struct.signal.group_stop_count> protected by <struct sighand_struct.siglock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/fork.c:copy_process:944] (pop=7, s=5)
-------------------------------------------------------
BUG? pair: lock=<&cpufreq_driver_sem:struct semaphore:1>, var=<cpufreq_driver,struct cpufreq_driver,1>
  z score=1.11
  first = 11
  global-lock
  global-var
  1 error out of 13 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:1221:cpufreq_register_driver: ERROR: var <cpufreq_driver,struct cpufreq_driver,1> not protected by <&cpufreq_driver_sem:struct semaphore:1>(pop=13, s=12) [locked=0] [seen_lock=1]

   seems like a bug --- the exmaples strongly suggest someone can make the
   driver null, in which case i believe the following is open to a race.

        if (cpufreq_driver)
                return -EBUSY;

        if (!driver_data || !driver_data->verify ||
            ((!driver_data->setpolicy) && (!driver_data->target)))
                return -EINVAL;

        down(&cpufreq_driver_sem);


  ====================================
  12 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:331:cpufreq_add_dev: NOTE: var <cpufreq_driver,struct cpufreq_driver,1> protected by <&cpufreq_driver_sem:struct semaphore:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:cpufreq_add_dev:330] (pop=13, s=12)

        down(&cpufreq_driver_sem);
        if (!cpufreq_driver) {
                up(&cpufreq_driver_sem);
                return -EINVAL;
        }


    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:309:show_cpuinfo_min_freq: NOTE: var <cpufreq_driver,struct cpufreq_driver,1> protected by <&cpufreq_driver_sem:struct semaphore:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:show_cpuinfo_min_freq:309] (pop=13, s=12)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:193:show_scaling_governor: NOTE: var <cpufreq_driver,struct cpufreq_driver,1> protected by <&cpufreq_driver_sem:struct semaphore:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:show_scaling_governor:192] (pop=13, s=12)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:1271:cpufreq_unregister_driver: NOTE: var <cpufreq_driver,struct cpufreq_driver,1> protected by <&cpufreq_driver_sem:struct semaphore:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:cpufreq_unregister_driver:1269] (pop=13, s=12)

        down(&cpufreq_driver_sem);

        if (!cpufreq_driver ||
            ((driver != cpufreq_driver) 

    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:1062:cpufreq_set_policy: NOTE: var <cpufreq_driver,struct cpufreq_driver,1> protected by <&cpufreq_driver_sem:struct semaphore:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:cpufreq_set_policy:1061] (pop=13, s=12)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:85:cpufreq_parse_governor: NOTE: var <cpufreq_driver,struct cpufreq_driver,1> protected by <&cpufreq_driver_sem:struct semaphore:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/cpufreq.c:cpufreq_parse_governor:84] (pop=13, s=12)
-------------------------------------------------------
BUG? pair: lock=<struct in_device.lock>, var=<struct in_device.mc_list>
  z score=-1.00
  singles = 1
  first = 4
  last = 1
  3 errors out of 9 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:497:ip_mc_inc_group: ERROR: var <struct in_device.mc_list> not protected by <struct in_device.lock>(pop=9, s=6) [locked=0] [seen_lock=1]

	seems like they should have a read lock.


     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:544:ip_mc_dec_group: ERROR: var <struct in_device.mc_list> not protected by <struct in_device.lock>(pop=9, s=6) [locked=0] [seen_lock=1]

	read_lock?

     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:571:ip_mc_down: ERROR: var <struct in_device.mc_list> not protected by <struct in_device.lock>(pop=9, s=6) [locked=0] [seen_lock=1]
  ====================================
  6 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:525:ip_mc_inc_group: NOTE: var <struct in_device.mc_list> protected by <struct in_device.lock> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:ip_mc_inc_group:523] (pop=9, s=6)

        write_lock_bh(&in_dev->lock);
        im->next=in_dev->mc_list;
        in_dev->mc_list=im;
        write_unlock_bh(&in_dev->lock);


    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:602:ip_mc_destroy_dev: NOTE: var <struct in_device.mc_list> protected by <struct in_device.lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:ip_mc_destroy_dev:601] (pop=9, s=6)

        write_lock_bh(&in_dev->lock);
        while ((i = in_dev->mc_list) != NULL) {


    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:773:ip_check_mc: NOTE: var <struct in_device.mc_list> protected by <struct in_device.lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/igmp.c:ip_check_mc:772] (pop=9, s=6)


        read_lock(&in_dev->lock);
        for (im=in_dev->mc_list; im; im=im->next) {
                if (im->multiaddr == mc_addr) {
                        read_unlock(&in_dev->lock);

-------------------------------------------------------
BUG? pair: lock=<&fib_rules_lock:rwlock_t:1>, var=<struct fib_rule.r_ifindex>
  z score=-1.12
  singles = 1
  last = 1
  global-lock
  2 errors out of 5 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:289:fib_rules_detach: ERROR: var <struct fib_rule.r_ifindex> not protected by <&fib_rules_lock:rwlock_t:1>(pop=5, s=3) [locked=0] [seen_lock=1]

   this seems pretty busted: they check r->r_ifindex and then 
   write to it without rechecking that it's the same value:

        for (r=fib_rules; r; r=r->r_next) {
                if (r->r_ifindex == dev->ifindex) {
                        write_lock_bh(&fib_rules_lock);
                        r->r_ifindex = -1;
                        write_unlock_bh(&fib_rules_lock);
                }
        }
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:302:fib_rules_attach: ERROR: var <struct fib_rule.r_ifindex> not protected by <&fib_rules_lock:rwlock_t:1>(pop=5, s=3) [locked=0] [seen_lock=1]

     same: check, and a write without rechecking:

        for (r=fib_rules; r; r=r->r_next) {
                if (r->r_ifindex == -1 && strcmp(dev->name, r->r_ifname) == 0) {
                        write_lock_bh(&fib_rules_lock);
                        r->r_ifindex = dev->ifindex;
                        write_unlock_bh(&fib_rules_lock);

  ====================================
  3 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:291:fib_rules_detach: NOTE: var <struct fib_rule.r_ifindex> protected by <&fib_rules_lock:rwlock_t:1> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:fib_rules_detach:290] (pop=5, s=3)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:304:fib_rules_attach: NOTE: var <struct fib_rule.r_ifindex> protected by <&fib_rules_lock:rwlock_t:1> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:fib_rules_attach:303] (pop=5, s=3)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:323:fib_lookup: NOTE: var <struct fib_rule.r_ifindex> protected by <&fib_rules_lock:rwlock_t:1> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:fib_lookup:321] (pop=5, s=3)
-------------------------------------------------------
BUG? pair: lock=<&fib_rules_lock:rwlock_t:1>, var=<*rp,struct fib_rule,0>
  z score=-1.50
  singles = 1
  global-lock
  2 errors out of 4 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:111:inet_rtm_delrule: ERROR: var <*rp,struct fib_rule,0> not protected by <&fib_rules_lock:rwlock_t:1>(pop=4, s=2) [locked=0] [seen_lock=1]
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:234:inet_rtm_newrule: ERROR: var <*rp,struct fib_rule,0> not protected by <&fib_rules_lock:rwlock_t:1>(pop=4, s=2) [locked=0] [seen_lock=1]

   sure seems like the code is depending on state from outside the
   critical section:

        while ( (r = *rp) != NULL ) {
                if (r->r_preference > new_r->r_preference)
                        break;
                rp = &r->r_next;
        }

        new_r->r_next = r;
        atomic_inc(&new_r->r_clntref);
        write_lock_bh(&fib_rules_lock);
        *rp = new_r;
        write_unlock_bh(&fib_rules_lock);

  ====================================
  2 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:243:inet_rtm_newrule: NOTE: var <*rp,struct fib_rule,0> protected by <&fib_rules_lock:rwlock_t:1> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:inet_rtm_newrule:242] (pop=4, s=2)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:129:inet_rtm_delrule: NOTE: var <*rp,struct fib_rule,0> protected by <&fib_rules_lock:rwlock_t:1> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/fib_rules.c:inet_rtm_delrule:128] (pop=4, s=2)

                        write_lock_bh(&fib_rules_lock);
                        *rp = r->r_next;
                        r->r_dead = 1;
                        write_unlock_bh(&fib_rules_lock);

-------------------------------------------------------
MINOR: not false, just dumb pair: lock=<&exec_domains_lock:rwlock_t:1>, var=<exec_domains,struct exec_domain,1>
  z score=0.20
  first = 5
  global-lock
  global-var
  1 error out of 6 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:143:unregister_exec_domain: ERROR: var <exec_domains,struct exec_domain,1> not protected by <&exec_domains_lock:rwlock_t:1>(pop=6, s=5) [locked=0] [seen_lock=1]

        epp = &exec_domains;
        write_lock(&exec_domains_lock);
        for (epp = &exec_domains; *epp; epp = &(*epp)->next) {

  ====================================
  5 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:98:lookup_exec_domain: NOTE: var <exec_domains,struct exec_domain,1> protected by <&exec_domains_lock:rwlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:lookup_exec_domain:96] (pop=6, s=5)

        read_lock(&exec_domains_lock);

        for (ep = exec_domains; ep; ep = ep->next) {
                if (pers >= ep->pers_low && pers <= ep->pers_high)
                        if (try_module_get(ep->module))
                                goto out;

    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:208:get_exec_domain_list: NOTE: var <exec_domains,struct exec_domain,1> protected by <&exec_domains_lock:rwlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:get_exec_domain_list:207] (pop=6, s=5)

        read_lock(&exec_domains_lock);
        for (ep = exec_domains; ep && len < PAGE_SIZE - 80; ep = ep->next)
                len += sprintf(page + len, "%d-%d\t%-16s\t[%s]\n",
                               ep->pers_low, ep->pers_high, ep->name,

    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:145:unregister_exec_domain: NOTE: var <exec_domains,struct exec_domain,1> protected by <&exec_domains_lock:rwlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:unregister_exec_domain:144] (pop=6, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:83:lookup_exec_domain: NOTE: var <exec_domains,struct exec_domain,1> protected by <&exec_domains_lock:rwlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:lookup_exec_domain:82] (pop=6, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:124:register_exec_domain: NOTE: var <exec_domains,struct exec_domain,1> protected by <&exec_domains_lock:rwlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/exec_domain.c:register_exec_domain:123] (pop=6, s=5)
-------------------------------------------------------
BUG? pair: lock=<&logbuf_lock:spinlock_t:1>, var=<log_start,unsigned int,1>
  z score=-0.57
  first = 3
  last = 1
  global-lock
  global-var
  2 errors out of 7 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:179:do_syslog: ERROR: var <log_start,unsigned int,1> not protected by <&logbuf_lock:spinlock_t:1>(pop=7, s=5) [locked=0] [seen_lock=1]

	supposed to protect log start?

  ====================================
  5 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:625:register_console: NOTE: var <log_start,unsigned int,1> protected by <&logbuf_lock:spinlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:register_console:624] (pop=7, s=5)

                spin_lock_irqsave(&logbuf_lock, flags);
                con_start = log_start;
                spin_unlock_irqrestore(&logbuf_lock, flags);

    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:184:do_syslog: NOTE: var <log_start,unsigned int,1> protected by <&logbuf_lock:spinlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:do_syslog:183] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:498:release_console_sem: NOTE: var <log_start,unsigned int,1> protected by <&logbuf_lock:spinlock_t:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:release_console_sem:497] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:186:do_syslog: NOTE: var <log_start,unsigned int,1> protected by <&logbuf_lock:spinlock_t:1> [annot=last] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:do_syslog:183] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:365:emit_log_char: NOTE: var <log_start,unsigned int,1> protected by <&logbuf_lock:spinlock_t:1> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:printk:403
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:printk:423
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/kernel/printk.c:emit_log_char:365] (pop=7, s=5)
-------------------------------------------------------
BUG? pair: lock=<struct shmem_inode_info.lock>, var=<struct shmem_inode_info.next_index>
  z score=0.20
  first = 2
  1 error out of 6 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:385:shmem_truncate: ERROR: var <struct shmem_inode_info.next_index> not protected by <struct shmem_inode_info.lock>(pop=6, s=5) [locked=0] [seen_lock=1]

   seems like a potential race, since info_next_index seems like it could
   get decreased in the meantime violating the if-stmt:

        if (idx >= info->next_index)
                return;

        spin_lock(&info->lock);
        limit = info->next_index;


  ====================================
  5 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:389:shmem_truncate: NOTE: var <struct shmem_inode_info.next_index> protected by <struct shmem_inode_info.lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_truncate:388] (pop=6, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:582:shmem_unuse_inode: NOTE: var <struct shmem_inode_info.next_index> protected by <struct shmem_inode_info.lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_unuse_inode:581] (pop=6, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:482:shmem_truncate: NOTE: var <struct shmem_inode_info.next_index> protected by <struct shmem_inode_info.lock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_truncate:388] (pop=6, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:335:shmem_swp_alloc: NOTE: var <struct shmem_inode_info.next_index> protected by <struct shmem_inode_info.lock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_swp_alloc:324] (pop=6, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:343:shmem_swp_alloc: NOTE: var <struct shmem_inode_info.next_index> protected by <struct shmem_inode_info.lock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_getpage:755
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_getpage:757
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:shmem_swp_alloc:343] (pop=6, s=5)
-------------------------------------------------------
BUG: pair: lock=<struct ipq.lock>, var=<struct ipq.last_in>
  z score=-0.57
  first = 2
  2 errors out of 7 uses:
     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:163:ip_frag_destroy: ERROR: var <struct ipq.last_in> not protected by <struct ipq.lock>(pop=7, s=5) [locked=0] [seen_lock=1]

	BUG_ON call that looks at last_in

     /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:289:ip_frag_intern: ERROR: var <struct ipq.last_in> not protected by <struct ipq.lock>(pop=7, s=5) [locked=0] [seen_lock=1]

	seems like a definite bug they read-modify-write it right after
	releasing the lock:

                        write_unlock(&ipfrag_lock);
                        qp_in->last_in |= COMPLETE;
                        ipq_put(qp_in);

  ====================================
  5 examples:
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:226:ip_evictor: NOTE: var <struct ipq.last_in> protected by <struct ipq.lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_evictor:225] (pop=7, s=5)

                                spin_lock(&qp->lock);
                                if (!(qp->last_in&COMPLETE))
                                        ipq_kill(qp);
                                spin_unlock(&qp->lock);

    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:249:ip_expire: NOTE: var <struct ipq.last_in> protected by <struct ipq.lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_expire:247] (pop=7, s=5)

        spin_lock(&qp->lock);

        if (qp->last_in & COMPLETE)
                goto out;

    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:619:ip_defrag: NOTE: var <struct ipq.last_in> protected by <struct ipq.lock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:615] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:377:ip_frag_queue: NOTE: var <struct ipq.last_in> protected by <struct ipq.lock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:615
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:617
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_frag_queue:377] (pop=7, s=5)
    /u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:193:ipq_kill: NOTE: var <struct ipq.last_in> protected by <struct ipq.lock> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:615
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:623
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:623
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_defrag:621
	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ip_frag_reasm:515
	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/ip_fragment.c:ipq_kill:193] (pop=7, s=5)
-------------------------------------------------------
