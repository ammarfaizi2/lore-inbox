Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbVIOSlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbVIOSlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbVIOSlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:41:39 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:6786 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030571AbVIOSlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:41:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=t5sFaPNr2XQGkuNeNwPeV63i56N/TkGjtb5eYfYhxQ8t/e79UgajVsvtpZIlw0pqHau8OCXAM6iRwQcyck4LHbPmeu5HOp42tUVaK08CePd2bJHHrC333QqPmaDLfyag7QCsWNLNJHCDEv2PdvjRxABXGINRsISEBdBkoY7EFGo=
Message-ID: <9268368b05091511416c3e5230@mail.gmail.com>
Date: Thu, 15 Sep 2005 14:41:31 -0400
From: Daniel Petrini <d.pensator@gmail.com>
Reply-To: d.pensator@gmail.com
To: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       Tony Lindgren <tony@atomide.com>
Subject: [PATCH] Timertop - some improvements (3)
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17684_21147916.1126809691993"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_17684_21147916.1126809691993
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here we have a new and cleaned version of timertop. It now uses
seq_file to get a more stable output.

Timertop is a small utility that gets some information to be useful
for dynamic-tick patch, it consists of a kernel patch and a perl
script. The kernel patch gathers information from timer functions ans
stores it in a proc entry (/proc/timer_info).
The perl script parses it and shows in the screen the usage of timer
functions in the system, including the timer count, pid and cmdline of
the processes that started the timer. It shows also the Hz value (idea
from pm-stats).

The idea is to know which applications or drivers are consuming timers
and try to optimize them in order to get lower HZ values and save more
power, at least in theory. So it is applicable over the dyn-tick
patch.

The perl script has this output:

Timer Top v0.9.3=20
Ticks: 236 HZ
Address   Count    Freq(Hz)    Function         PID    Command
c011f2b7 |38847164|  444.00|    process_timeout|6765  |cpufreq-applet  |
c011f2b7 |38847164|  444.00|    process_timeout|20327 |timer_top.pl    |
c011f2b7 |38847164|  444.00|    process_timeout|18304 |firefox-bin     |
c01be3b8 |44840   |    4.00|     commit_timeout|783   |kjournald       |
c011ad7b |5440294 |  172.00|         it_real_fn|5572  |Xorg            |
c028f061 |323612  |   44.00| neigh_periodic_tim|X     |                |

Some of the timers, of course, are only related to kernel so there is
nothing in the process (PID and  Command) column.

The System.map file must be in the script directory.
The patch should apply over 2.6.13-mm1.

We hope that this can be useful.

We are open to comments, suggestions and review.

Daniel Petrini
---------------------
10LE - Linux
INdT - Manaus - Brazil

------=_Part_17684_21147916.1126809691993
Content-Type: text/x-patch; name=timer_top4-20050901.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="timer_top4-20050901.patch"

diff -uprN linux-2.6.12-orig/kernel/Makefile linux-dyn-tick/kernel/Makefile
--- linux-2.6.12-orig/kernel/Makefile	2005-08-05 09:33:24.000000000 -0400
+++ linux-dyn-tick/kernel/Makefile	2005-08-05 09:28:18.000000000 -0400
@@ -30,7 +30,7 @@ obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
-obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o timer_top.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uprN linux-2.6.12-orig/kernel/timer.c linux-dyn-tick/kernel/timer.c
--- linux-2.6.12-orig/kernel/timer.c	2005-08-05 09:33:31.000000000 -0400
+++ linux-dyn-tick/kernel/timer.c	2005-08-05 09:38:33.000000000 -0400
@@ -508,6 +508,9 @@ static inline void __run_timers(tvec_bas
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
+extern struct timer_top_info top_info;
+extern int account_timer(unsigned int function,
+	       		struct timer_top_info * top_info);
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
@@ -571,6 +574,7 @@ found:
 				expires = nte->expires;
 		}
 	}
+	account_timer((unsigned int)nte->function, &top_info);
 	spin_unlock(&base->t_base.lock);
 	return expires;
 }
diff -uprN linux-2.6.12-orig/kernel/timer_top.c linux-dyn-tick/kernel/timer_top.c
--- linux-2.6.12-orig/kernel/timer_top.c	1969-12-31 20:00:00.000000000 -0400
+++ linux-dyn-tick/kernel/timer_top.c	2005-09-01 10:49:37.000000000 -0400
@@ -0,0 +1,139 @@
+/*
+ * kernel/timer_top.c
+ *
+ * Export Timers information to /proc/timer_info
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
+ * Written by Daniel Petrini <d.pensator@gmail.com>
+ *
+ * This utility should be used to get information from the system timers
+ * and maybe optimize the system once you know which timers are being used
+ * and the process which starts them.
+ * This is particular useful above dynamic tick implementation. One can 
+ * see who is starting timers and make the HZ value increase.
+ *
+ * We export the addresses and counting of timer functions being called,
+ * the pid and cmdline from the owner process if applicable.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+
+#define VERSION		"Timer Top v0.9.3"
+
+static LIST_HEAD(timer_list);
+
+struct timer_top_info {
+	unsigned int		func_pointer;
+	unsigned long		counter;
+	pid_t			pid;
+	char 			comm[TASK_COMM_LEN];
+	struct list_head 	list;      	
+};
+
+struct timer_top_info top_info;
+
+static spinlock_t timer_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long flags;
+
+
+int account_timer(unsigned long function, unsigned long data, struct timer_top_info * top_info)
+{
+	struct timer_top_info *top;
+	struct task_struct * task_info;
+	pid_t pid_info = 0;
+	char name[TASK_COMM_LEN] = "";
+	
+	spin_lock_irqsave(&timer_lock, flags);
+
+	if (data) { 
+	       	task_info = (struct task_struct *) data;
+		/* little sanity ... not enough yet */
+		if ((task_info->pid > 0) && (task_info->pid < PID_MAX_LIMIT)) {
+			pid_info = task_info->pid;
+			strncpy(name, task_info->comm, sizeof(task_info->comm));
+		}
+	}
+
+	list_for_each_entry(top, &timer_list, list) {
+		/* if it is in the list increment its count */
+		if (top->func_pointer == function) {
+			top->counter++;
+			top->pid = pid_info;
+			strncpy(top->comm, name, sizeof(name));
+			spin_unlock_irqrestore(&timer_lock, flags);
+			goto out;
+		}
+	}
+	
+	/* if you are here then it didnt find so inserts in the list */
+
+	top = kmalloc(sizeof(struct timer_top_info), GFP_ATOMIC);
+	if (!top) 
+		return -ENOMEM;
+	top->func_pointer = function;
+	top->counter = 1;
+	top->pid = pid_info;
+	strncpy(top->comm, name, sizeof(name));
+	list_add(&top->list, &timer_list);
+
+	spin_unlock_irqrestore(&timer_lock, flags);
+
+out:	
+	return 0;
+}
+
+EXPORT_SYMBOL(account_timer);
+
+/* PROC_FS_SECTION  */
+
+static struct proc_dir_entry *top_info_file;
+
+static int proc_read_top_info(struct seq_file *m, void *v)
+{
+	struct timer_top_info *top;
+	
+	seq_printf(m, "Function counter - %s\n", VERSION);
+
+	list_for_each_entry(top, &timer_list, list) {
+		seq_printf(m, "%x %lu %d %s\n", top->func_pointer, top->counter, top->pid, top->comm);
+	}
+
+	return 0;
+} 
+
+static int proc_timertop_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_read_top_info, NULL);
+}
+
+static struct file_operations proc_timertop_operations = {
+	.open		= proc_timertop_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int init_top_info(void)
+{
+	top_info_file = create_proc_entry("timer_info", 0444, NULL);
+	if (top_info_file == NULL) {
+		return -ENOMEM;
+	}
+
+	top_info_file->proc_fops = &proc_timertop_operations;
+	
+	return 0;
+}
+
+module_init(init_top_info);
+//module_exit();



------=_Part_17684_21147916.1126809691993
Content-Type: application/x-perl; name=timer_top.pl
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="timer_top.pl"

#!/usr/bin/perl
#
# timer_top.pl
#
# Timer Top: gets timers info exported by kernel in /proc/timer_info and
# organizes and shows useful info in the screen. Its main purpose is to
# test the dynamic tick patch by Tony Lindgren and Tuukka Tikkanen.
# Idea is to evolve this in order to get more useful info
# It needs the System.map file to be in the same directory
#
# Copyright (C) 2005 Insituto Nokia de Tecnologia - INdT - Manaus
# Written by Daniel Petrini <daniel.petrini@indt.org.br> and
#            Ilias Biris <ilias.biris@indt.org.br>
#
# With some code from pmstats-0.2 by Tony Lindgren
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
# 

open (INFILE, "System.map") || die ("cannot open file\n");

my ($interval) = $ARGV[0];
my ($refresh_rate) = $ARGV[1];

if ($refresh_rate eq "") {
    $refresh_rate = 0.5;
}

if ($interval eq "") {
    printf("Usage: %s refresh rate(in seconds) interval(in seconds) \n", $0);
    print "Refresh rate (default = 0.50) is period between /proc/timer_info reads\n";
    print "Interval is max period that a sampled timer will apear without being recalled\n";	
    exit(1); 
}

%sys_map_lines=();
%top_lines=();
%numb_func=();
%diff_time=();

# Get functions from System.map 
while(<INFILE>) {
    chomp $_;
    if( $_ ne "" ) {
	$sys_map_line = substr($_, 0, 8);	
	$sys_map_lines{$sys_map_line}=substr($_, 10, length($_));
    }
}
close(INFILE);

#
# Reads kernel timers info from /proc/timer_info
#
sub read_top_info {

    open (INFILE2, "/proc/timer_info") || die ("cannot open file\n");

    while(<INFILE2>){
	if( $_ !~ m/^Function\scounter/ ){
	    #$func_adr = substr( $_, 0, 8);
	    #$numb_top = substr( $_, 9, 8);
	    @words = split( / / , $_);
	    $func_adr = $words[0];  # Timer Function address
	    $numb_top = $words[1];  # Timer Function counter
	    $pid_top  = $words[2];  # Pid, if exists, which uses the timer function
	    $comm_top = $words[3];  # Command line for the pid
	    if( $sys_map_lines{$func_adr} ne "" ){
		# Check if there is variation for that timer function
		if ( ($numb_top) != ($numb_func{$func_adr})  ) {
		    $top_lines{$func_adr} = $sys_map_lines{$func_adr};
		    $diff_time{$func_adr} = $numb_top - $numb_func{$func_adr};	#Get the difference
		    $numb_func{$func_adr} = $numb_top;

		    # Store function address, cmdline and timestamp per pid
		    $pid_2{$pid_top} = $func_adr;
		    $comm_2{$pid_top} = $comm_top;
		    $time_st{$pid_top} = time();

		    #print "$numb_top \n"
	    	} else {
		    $top_lines{$func_adr} = "";
		    $pid_proc{$func_adr}  = 0;
		    $comm_proc{$func_adr} = "";
		} 
	    }
	}
    }
    close(INFILE2);
}

# 
# Based in code from pmstats-0.2 from Tony Lindgren
#
sub read_timer_ticks() {
    my $buf = "";
    open(INFILE3, "/proc/interrupts") or die "Could not open file\n";
    while (<INFILE3>) {
	# It looks for the string 'timer' ...
	if ($_ =~ m/timer/ ) { 
	    $_ =~ s/ +/ /gi;
	    my ($tag, $val) = split(": ", $_ );
	    $tag =~ s/ +//g;
	    ($val) = split(" ", $val);
	    close (INFILE3);
	    return($val);
	}
    }
    close (INFILE3);
    return 0;
}

my $flag = 0;

#
# Main routine. Refresh screen every $interval seconds
#
while (1) {

    read_top_info();

    system("clear");

    print "Timer Top v0.9.3 \n";

    my $ticks = read_timer_ticks();
    my $delta_ticks = ($ticks - $last_ticks) / $refresh_rate;
    if ($last_ticks == 0) {
	$delta_ticks = 0; 
    }
    $last_ticks = $ticks;

    printf "Ticks: %d HZ\n", $delta_ticks;
    print "Address   Count    Freq(Hz)    Function         PID    Command\n";

    my $time_stamp = time();

    # For each function address ...
    while(($item, $value) = each(%top_lines)) {
	if ( $top_lines{$item} ne "" ) {
	    chomp ($numb_func{$item});
	    $addres = $item;
	    $count  = $numb_func{$item};
	    $freq   = $diff_time{$item}/$refresh_rate;
	    $functn = $value;
	    
	    # Search for pids from function addresses
	    while ( ($proc, $data) = each(%pid_2) ) {
		#print "$proc $data\n";
		# If matches function address and they are below time threshould ...
		if ($data eq $item && (($time_st{$proc} + $interval) >= $time_stamp) ) {
		    # Get the pid and command line string and print whole line
		    if ($proc eq 0) {
			$pid_fn = "X";
		    } else { 
			$pid_fn = $proc;
		    }
		    $name_pid = $comm_2{$proc};
		    write();
		}
	    }
	    $flag = 1;
	}
    }
    
    if ($flag eq 0) {
        printf("Please, make sure the current System map file is in the current directory.\n");	
	exit(1);
}
    select(undef, undef, undef, $refresh_rate);
    #sleep $interval;
}

format STDOUT = 
@<<<<<<<<|@<<<<<<<|@####.##|@>>>>>>>>>>>>>>>>>>|@<<<<<|@<<<<<<<<<<<<<<<|
$addres, $count, $freq, $functn, $pid_fn, $name_pid
.

------=_Part_17684_21147916.1126809691993--
