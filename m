Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVHHOpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVHHOpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVHHOpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:45:47 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:18626 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750912AbVHHOpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:45:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=E5L+g+iaTnwtlAGcWVWQP+NQ2Aa7CxVEejmda+DeBVnpJmC5U1RUU1Q9uBT7t0RONv8IlMY/IdtMC/RYVqQCDHPGGVz83+UZ3svCSRj5xWhNYBNAHISUQLTgRcpVgbFjHyVdB0tOlI88YjfgPX/brqnKdvrzRJi70YNbRYYyv+A=
Message-ID: <9268368b050808074579501f86@mail.gmail.com>
Date: Mon, 8 Aug 2005 10:45:45 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Timertop - update
Cc: tony@atomide.com, Con Kolivas <kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4279_26165804.1123512345426"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4279_26165804.1123512345426
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here we have a slightly update for timertop script, it now shows the
ticks in Hz (borrowed from Tony's pmstats - let me know if I shouldn't
:-) ) and some cleanups.

The timertop kernel patch is the same, tested for 2.6.13-rc5-dtck-5.patch.

I'm open to suggestions on what to aggregate in that utility.

In my system, a Dell Latitude D600, dyn tick is working ok. IT has 50
ticks in complete desktop environment.

Regards,

Daniel
--=20
10LE - Linux
INdT - Manaus - Brazil

------=_Part_4279_26165804.1123512345426
Content-Type: text/x-patch; name=timer_top3-20050805.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="timer_top3-20050805.patch"

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
+++ linux-dyn-tick/kernel/timer_top.c	2005-08-05 09:28:38.000000000 -0400
@@ -0,0 +1,108 @@
+/*
+ * kernel/timer_top.c
+ *
+ * Export Timers information to /proc/top_info
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
+ * Written by Daniel Petrini <d.pensator@gmail.com>
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
+
+static LIST_HEAD(timer_list);
+
+struct timer_top_info {
+	unsigned int		func_pointer;
+	unsigned long		counter;
+	struct list_head 	list;      	
+};
+
+struct timer_top_info top_info;
+
+static spinlock_t timer_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long flags;
+
+
+int account_timer(unsigned int function, struct timer_top_info * top_info)
+{
+	struct timer_top_info *top;
+
+	spin_lock_irqsave(&timer_lock, flags);
+
+	list_for_each_entry(top, &timer_list, list) {
+		/* if it is in the list increment its count */
+		if (top->func_pointer == function) {
+			top->counter++;
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
+struct top_info_poll {
+	char value[18];
+};
+
+static struct top_info_poll top_info_poll_dt;
+static struct proc_dir_entry *top_info_file;
+
+static int proc_read_top_info(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	char aux[18];
+	struct timer_top_info *top;
+
+	struct top_info_poll *info_poll_data=(struct top_info_poll *)data;
+
+	sprintf(page, "Function counter - %s\n", info_poll_data->value);
+
+	list_for_each_entry(top, &timer_list, list) {
+		sprintf(aux, "%x %lu\n", top->func_pointer, top->counter);
+		strcat(page, aux);
+	}
+
+	return strlen(page);
+} 
+
+static int init_top_info(void)
+{
+	top_info_file = create_proc_entry("top_info", 0666, NULL);
+	if (top_info_file == NULL) {
+		return -ENOMEM;
+	}
+
+	strcpy(top_info_poll_dt.value, "Timer Top v0.9.1");
+
+	top_info_file->data = &top_info_poll_dt;
+	top_info_file->read_proc = &proc_read_top_info;
+	top_info_file->owner = THIS_MODULE;
+	
+	return 0;
+}
+
+module_init(init_top_info);
+//module_exit();

------=_Part_4279_26165804.1123512345426
Content-Type: application/x-perl; name=timer_top.pl
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="timer_top.pl"

#
# timer_top.pl
#
# Timer Top: gets timers info exported by kernel in /proc/top_info and
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
#!/usr/bin/perl

open (INFILE, "System.map") || die ("cannot open file\n");

my ($interval) = $ARGV[0];

if ($interval eq "") {
    printf("Usage: %s interval_in_seconds\n", $0);	
    exit(1);
}

%sys_map_lines=();
%top_lines=();
%numb_func=();
%diff_time=();

while(<INFILE>) {
    chomp $_;
    if( $_ ne "" ) {
	$sys_map_line = substr($_, 0, 8);	
	$sys_map_lines{$sys_map_line}=substr($_, 10, length($_));
    }
}
close(INFILE);


sub read_top_info {

    open (INFILE2, "/proc/top_info") || die ("cannot open file\n");

    while(<INFILE2>){
	if( $_ !~ m/^Function\scounter/ ){
	    $func_top = substr( $_, 0, 8);
	    $numb_top = substr( $_, 9, 8);
	    if( $sys_map_lines{$func_top} ne "" ){
		# Check if there is variation for that timer function
		if ( ($numb_top) != ($numb_func{$func_top})  ) {
		    $top_lines{$func_top} = $sys_map_lines{$func_top};
		    $diff_time{$func_top} = $numb_top - $numb_func{$func_top};	#Get the difference
		    $numb_func{$func_top} = $numb_top;
	    	} else {
		    $top_lines{$func_top} = "";
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
	    $_ =~ s/ +/ /g;
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

#
# Main routine. Refresh screen every $interval seconds
#
while (1) {

    read_top_info();

    system("clear");

    print "Timer Top v0.9.2 \n";

    my $ticks = read_timer_ticks();
    my $delta_ticks = ($ticks - $last_ticks) / $interval;
    if ($last_ticks == 0) {
	$delta_ticks = 0; 
    }
    $last_ticks = $ticks;

    printf "Ticks: %d HZ\n", $delta_ticks;
    print "Address      Count   Freq(Hz)   Function\n";

    while(($item, $value) = each(%top_lines)) {
	if ( $top_lines{$item} ne "" ) {
	    chomp ($numb_func{$item});
	    printf "%s|%10s|%9.2f|%s\n", $item, $numb_func{$item}, $diff_time{$item}/$interval, $value;
	}
    }
    sleep $interval;
}

------=_Part_4279_26165804.1123512345426--
