Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315203AbSDWKDx>; Tue, 23 Apr 2002 06:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSDWKDw>; Tue, 23 Apr 2002 06:03:52 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52228 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315138AbSDWKDv>; Tue, 23 Apr 2002 06:03:51 -0400
Message-Id: <200204231001.g3NA0xX14915@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mark Hahn <hahn@physics.mcmaster.ca>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: user/system/nice accounting
Date: Tue, 23 Apr 2002 13:03:24 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I modified proc_misc.c (see patch) to close small race
and to have jiffies printed too as a debugging aid.
But I still see 'idle' going backwards.
This happens very rarely but:

       user  n syste idle   jiffies
....
1 cpu  13560 0 26994 746329 786883
2 cpu  13560 0 26995 746330 786885
3 cpu  13560 0 26997 746329 786886 <<<
4 cpu  13561 0 26997 746329 786887
5 cpu  13561 0 26998 746330 786889
6 cpu  13561 0 26999 746330 786890
....

I am trying to explain what we see here:
3) Two ticks were accounted as system time,
   but reported jiffy is only incremented once
   (A race? 'Real' jiffy is 786887?)
4) One tick got accounted as user time,
   jiffy is incremented once too.
   Race theory falls apart here: we should see jiffies+=2:
   4 cpu  13561 0 26997 746330 786888
   unless we lose race here two times in a row: highly improbable!

BTW, IMHO I closed the race in /proc/stat generation,
and jiffy is ++'ed before system/user/nice stats in timer interrupt,
so it cannot race there too.

Do we have other places where we do system/user/nice accounting
except timer int?!

Kernel is 2.4.18 _UP_. That is, uniprocessor.

Can anybody explain this?
--
vda

# diff -u proc_misc.c.orig proc_misc.c
--- proc_misc.c.orig    Wed Nov 21 03:29:09 2001
+++ proc_misc.c Tue Apr 23 09:23:01 2002
@@ -240,7 +240,7 @@
 {
        int i, len;
        extern unsigned long total_forks;
-       unsigned long jif = jiffies;
+       unsigned long jif;
        unsigned int sum = 0, user = 0, nice = 0, system = 0;
        int major, disk;

@@ -256,8 +256,10 @@
 #endif
        }

-       len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-                     jif * smp_num_cpus - (user + nice + system));
+       jif = jiffies;
+       len = sprintf(page, "cpu  %u %u %u %lu %lu\n", user, nice, system,
+                     jif * smp_num_cpus - (user + nice + system),
+                     jif);
        for (i = 0 ; i < smp_num_cpus; i++)
                len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
                        i,



test_badidle2
=============
#!/bin/sh
prev=0
while true; do cat /proc/stat; done | \
grep -F 'cpu  ' | \
while read line; do
    next=`echo "$line" | cut -d ' ' -f 6`
    diff=$(($next-$prev))
    if test $diff -lt 0; then
        echo "$line <<<"
    else
        echo "$line"
    fi
    prev=$next
done
