Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbTBELcg>; Wed, 5 Feb 2003 06:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTBELcf>; Wed, 5 Feb 2003 06:32:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:53412 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267923AbTBELce>; Wed, 5 Feb 2003 06:32:34 -0500
Date: Wed, 5 Feb 2003 14:42:06 +0300
From: Oleg Drokin <green@namesys.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       jdike@karaya.com
Subject: use 64 bit jiffies broke HZ=100 case (and fix)
Message-ID: <20030205144206.A25320@namesys.com>
References: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Feb 02, 2003 at 11:55:40PM +0100, Tim Schmielau wrote:
> Just a note that I have rediffed for 2.5.55 the patches that use the 64
> bit jiffies value to avoid uptime and process start time wrap after
> 49.5 days. I will push them Linus-wards when he's back.
> They can be retrieved from
>   http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33a.patch.gz
>     (1/3: infrastructure)
>   http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33b.patch.gz
>     (2/3: fix uptime wrap)
>   http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33c.patch.gz
>     (3/3: 64 bit process start time)

Unfortunatelly your changes in fs/proc/proc_misc.c broke every arch that
still uses HZ=100 (e.g. UML), because there is no "times" field in task
struct.
See this part:

+       {
+               unsigned long idle = init_task.times.tms_utime
+                                    + init_task.times.tms_stime;

In order to get UML to compile again (and pretty much any other HZ=100 arch)
I need to apply this patch below:

===== fs/proc/proc_misc.c 1.63 vs edited =====
--- 1.63/fs/proc/proc_misc.c	Tue Nov 12 12:37:55 2002
+++ edited/fs/proc/proc_misc.c	Wed Feb  5 14:28:50 2003
@@ -121,8 +121,7 @@
 	}
 #else
 	{
-		unsigned long idle = init_task.times.tms_utime
-		                     + init_task.times.tms_stime;
+		unsigned long idle = init_task.utime + init_task.stime;
 
 		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime,

Bye,
    Oleg
