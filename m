Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRCRD2A>; Sat, 17 Mar 2001 22:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRCRD1v>; Sat, 17 Mar 2001 22:27:51 -0500
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:30659 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S129359AbRCRD1e>; Sat, 17 Mar 2001 22:27:34 -0500
Message-ID: <3AB42AFA.A38BD693@bigfoot.com>
Date: Sat, 17 Mar 2001 19:26:50 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: Re: [PATCH] /proc/uptime on SMP machines
In-Reply-To: <15027.62364.751528.388435@siemens.ikp.physik.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At present the idle value in /proc/uptime is only the idle time for the first
> processor. With 2.4, processes seam "stickier" for my, and e.g "yes
> >/dev/null" on an otherwise idle machine can stay for a long time on one
> processor of my (intel) SMP machine. That way, the present output of
> /proc/uptime can lead to a wrong conclusion.

Same for 2.2.19p17

[tim@smp ~]# cat /proc/uptime
19262.25 18487.44
[tim@smp ~]# cat /proc/stat | grep cpu
cpu  108661 0 24741 3719438
cpu0 65697 0 11814 1848909
cpu1 42964 0 12927 1870529

--- 2.2.19pre17/fs/proc/array.c Fri Mar 16 04:09:41 2001
+++ 2.2.19pre17/fs/proc/array.c.idle    Sat Mar 17 19:20:22 2001
@@ -339,9 +339,16 @@
 {
        unsigned long uptime;
        unsigned long idle;
+       int i;
 
        uptime = jiffies;
+#ifdef CONFIG_SMP
+       for (idle =0,i = 0; i < smp_num_cpus; i++)
+       idle += (init_tasks[i]->times.tms_utime +
+               init_tasks[i]->times.tms_stime)/smp_num_cpus;
+#else
        idle = task[0]->times.tms_utime + task[0]->times.tms_stime;
+#endif
 
        /* The formula for the fraction parts really is ((t * 100) / HZ)
% 100, but
           that would overflow about every five days at HZ == 100.


--
