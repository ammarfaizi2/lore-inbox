Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288109AbSAQCaW>; Wed, 16 Jan 2002 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288112AbSAQCaN>; Wed, 16 Jan 2002 21:30:13 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:49233
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288109AbSAQCaB>; Wed, 16 Jan 2002 21:30:01 -0500
Message-Id: <200201170229.g0H2TnY04563@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Problems with O(1) scheduler on non-x86 arch's
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_20994063690"
Date: Wed, 16 Jan 2002 21:29:48 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_20994063690
Content-Type: text/plain

I've been on a bug hunting expedition to try to make the new scheduler work with the voyager architecture port in kernel 2.4.2.  I'm not sure if this is a side effect of the port or an intentional architecture shift.  Some of the architecture ports (mine included) store the physical cpu number in p->processor (now p->cpu) rather than the logical one.  I'm not sure if shifting to logical cpu numbering was behind the name change or not, but anyway, in case this is merely an oversight, the attached patch fixes the problem for me.

James Bottomley
Content-Type: multipart/mixed ;
	boundary="==_Exmh_20997329790"
--==_Exmh_20997329790--
This is a multipart MIME message.

--==_Exmh_20997329790


--==_Exmh_20997329790
Content-Type: text/plain ; name="sched.diff"; charset=us-ascii
Content-Description: sched.diff
Content-Disposition: attachment; filename="sched.diff"

Index: kernel/fork.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.5/kernel/fork.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 fork.c
--- kernel/fork.c	16 Jan 2002 17:25:33 -0000	1.1.1.5
+++ kernel/fork.c	17 Jan 2002 02:18:29 -0000
@@ -650,7 +650,8 @@
 
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < smp_num_cpus; i++)
-			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
+			p->per_cpu_utime[cpu_logical_map(i)] =
+				p->per_cpu_stime[cpu_logical_map(i)] = 0;
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
Index: kernel/sched.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.5/kernel/sched.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 sched.c
--- kernel/sched.c	16 Jan 2002 17:25:33 -0000	1.1.1.4
+++ kernel/sched.c	17 Jan 2002 02:18:29 -0000
@@ -267,7 +267,7 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(i)->nr_running;
+		sum += cpu_rq(cpu_logical_map(i))->nr_running;
 
 	return sum;
 }
@@ -277,7 +277,7 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < smp_num_cpus; i++)
-		sum += cpu_rq(i)->nr_switches;
+		sum += cpu_rq(cpu_logical_map(i))->nr_switches;
 
 	return sum;
 }
@@ -287,7 +287,7 @@
 	unsigned long i, curr, max = 0;
 
 	for (i = 0; i < smp_num_cpus; i++) {
-		curr = cpu_rq(i)->nr_running;
+		curr = cpu_rq(cpu_logical_map(i))->nr_running;
 		if (curr > max)
 			max = curr;
 	}
@@ -327,7 +327,7 @@
 	busiest = NULL;
 	max_load = 0;
 	for (i = 0; i < smp_num_cpus; i++) {
-		rq_tmp = cpu_rq(i);
+		rq_tmp = cpu_rq(cpu_logical_map(i));
 		load = rq_tmp->nr_running;
 		if ((load > max_load) && (load < prev_max_load) &&
 						(rq_tmp != this_rq)) {




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--==_Exmh_20994063690--
