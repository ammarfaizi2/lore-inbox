Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSDXOH4>; Wed, 24 Apr 2002 10:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSDXOHz>; Wed, 24 Apr 2002 10:07:55 -0400
Received: from air-2.osdl.org ([65.201.151.6]:39172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312248AbSDXOHy>;
	Wed, 24 Apr 2002 10:07:54 -0400
Date: Wed, 24 Apr 2002 07:07:06 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: user/system/nice accounting
In-Reply-To: <200204231001.g3NA0xX14915@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0204240659460.31651-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis-

Yes, kstat_read_proc() in linux/fs/proc/proc_misc.c is
racing with the timer tick interrupt handler,
especially given your test_badidle2 script..
(I modified it to print only "error" conditions.)

I don't know how important it is to fix this, but
adding a lock at the beginning of kstat_read_proc()
allows it to run overnight with a problem [for me,
on UP].

BTW, idle shouldn't be blamed for going backwards,
since it's just the leftover time after adding
user + nice + system.  ;)

I don't recall what kernel version you are using, but
here's a patch to 2.4.18.


--- linux-2418/fs/proc/proc_misc.c.JIF	Tue Nov 20 21:29:09 2001
+++ linux-2418/fs/proc/proc_misc.c	Wed Apr 24 07:50:43 2002
@@ -235,14 +235,20 @@
 };
 #endif

+extern rwlock_t xtime_lock;
+
 static int kstat_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
+	unsigned long jif;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
+	unsigned long flags;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	jif = jiffies;

 	for (i = 0 ; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i), j;
@@ -256,8 +262,9 @@
 #endif
 	}

-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+	read_unlock_irqrestore(&xtime_lock, flags);
+ 	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
+ 		      jif * smp_num_cpus - (user + nice + system));
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
 			i,


HTH.
~Randy


On Tue, 23 Apr 2002, Denis Vlasenko wrote:

| I modified proc_misc.c (see patch) to close small race
| and to have jiffies printed too as a debugging aid.
| But I still see 'idle' going backwards.
| This happens very rarely but:
|
|        user  n syste idle   jiffies
| ....
| 1 cpu  13560 0 26994 746329 786883
| 2 cpu  13560 0 26995 746330 786885
| 3 cpu  13560 0 26997 746329 786886 <<<
| 4 cpu  13561 0 26997 746329 786887
| 5 cpu  13561 0 26998 746330 786889
| 6 cpu  13561 0 26999 746330 786890
| ....
|
| I am trying to explain what we see here:
| 3) Two ticks were accounted as system time,
|    but reported jiffy is only incremented once
|    (A race? 'Real' jiffy is 786887?)
| 4) One tick got accounted as user time,
|    jiffy is incremented once too.
|    Race theory falls apart here: we should see jiffies+=2:
|    4 cpu  13561 0 26997 746330 786888
|    unless we lose race here two times in a row: highly improbable!
|
| BTW, IMHO I closed the race in /proc/stat generation,
| and jiffy is ++'ed before system/user/nice stats in timer interrupt,
| so it cannot race there too.
|
| Do we have other places where we do system/user/nice accounting
| except timer int?!

No.

| Kernel is 2.4.18 _UP_. That is, uniprocessor.
|
| Can anybody explain this?
| --

