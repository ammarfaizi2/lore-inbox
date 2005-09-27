Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVI0R2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVI0R2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVI0R2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:28:51 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:52611 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965026AbVI0R2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:28:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Content-Disposition:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Message-Id;
  b=cr43zejn8VsZZcy+T6PmpEdIP3lGaS7HLOzHMN//buCymHfdJG3zpLMLOJsO7Ymo5pzMpa/d86EYFCVZM01JBSubL3E9tN5zl255TTvV8iBMbcLHxyR9Jm2hleKngkPlsQdWLjBN7N5cw+KBVB/uLeZYHdbNHpR/yb9xnFDlTDE=  ;
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Fwd: Re: CPUFreq_ondemand: misnamed ignore_nice attribute
Date: Tue, 27 Sep 2005 18:51:00 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0hXODjFuYmy5Wu4"
Message-Id: <200509271851.00914.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0hXODjFuYmy5Wu4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is the original docco patch for cpufreq_ondemand. Note that it doesn't 
document the existing behaviour (yes, it's confusing enough even for the 
author), it documents the future behaviour. ignore_nice should be renamed in 
this doc like in sysfs, i.e. to ignore_nice_load (or ignore_nice_tasks, but I 
prefer the 1st choice).

----------  Forwarded Message  ----------

Subject: Re: CPUFreq_ondemand: misnamed ignore_nice attribute
Date: Friday 02 September 2005 21:14
From: Alexander Clouter <alex@digriz.org.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Dave Jones <davej@redhat.com>

Blaisorblade <blaisorblade@yahoo.it> [20050823 21:08:25 +0200]:
> The "ignore_nice" attribute has indeed a strange (reversed) effect: cpu
> time spent while executing nice tasks is ignored if it is clear, rather
> than if it is set.

Hopefully the patch attached clears everything up? :)  Its a rare patch for
the Linux kernel, and it pained me to write something...so...hidious....so
wrong....so non-coder like :)

It should apply with no problems to a 2.6.13 kernel.  A suitable fix? :)

Cheers

Alex

> I see in the code the current logic makes sense, because setting this
> attribute makes "nice" time be ignored while calculating idle time. But I
> feel that this naming is confusing.

--
 _______________________________
/ No good deed goes unpunished. \

\ -- Clare Booth Luce           /
 -------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\

                ||----w |

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_0hXODjFuYmy5Wu4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="cpufreq-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpufreq-doc.patch"

--- linux-2.6.13.orig/Documentation/cpu-freq/governors.txt	2005-08-29 08:21:27.195275192 +0100
+++ linux-2.6.13/Documentation/cpu-freq/governors.txt	2005-09-02 15:19:44.599267264 +0100
@@ -27,6 +27,7 @@
 2.2  Powersave
 2.3  Userspace
 2.4  Ondemand
+2.5  Conservative
 
 3.   The Governor Interface in the CPUfreq Core
 
@@ -110,9 +111,64 @@
 
 The CPUfreq govenor "ondemand" sets the CPU depending on the
 current usage. To do this the CPU must have the capability to
-switch the frequency very fast.
-
+switch the frequency very quickly.  There are a number of sysfs file
+accessible parameters:
 
+sampling_rate: measured in uS (10^-6 seconds), this is how often you
+want the kernel to look at the CPU usage and to make decisions on
+what to do about the frequency.  Typically this is set to values of
+around '10000' or more.
+
+show_sampling_rate_(min|max): the minimum and maximum sampling rates
+available that you may set 'sampling_rate' to.
+
+up_threshold: defines what the average CPU usaged between the samplings
+of 'sampling_rate' needs to be for the kernel to make a decision on
+whether it should increase the frequency.  For example when it is set
+to its default value of '80' it means that between the checking
+intervals the CPU needs to be on average more than 80% in use to then
+decide that the CPU speed needs to be increased.  
+
+sampling_down_factor: this parameter controls the rate that th CPU
+makes a decision on when to decrease the frequency.  When set to its
+default value of '5' it means that at 1/5 the sampling_rate the kernel
+makes a decision to lower the frequency.  Five "lower" decisions have
+to occur in a row before the CPU frequency is actually lower.  If set
+to '1' then the frequency decreases as quickly as it increases, if set
+to '2' it decreases at half the rate of the increase.
+
+ignore_nice: this parameter takes a value of '0' or '1', when set to its
+default value of '0' then all processes are counted towards towards the
+'cpu utilisation' value.  When set to '1' then processes that are run
+with a 'nice' value will not count (be ignored) in the overal usage
+calculation.  This is useful if you are running a CPU intensive
+calculation on your laptop that you do not care how long it takes to
+complete as you can 'nice' it and prevent it from taking part in the
+deciding process of whether to increase your CPU frequency.
+
+
+2.5 Conservative
+----------------
+
+The CPUfreq governor "conservative", much like the "ondemand"
+governor, sets the CPU depending on the current usage.  It differs in
+behaviour in that it gracefully increases and decreases the CPU speed
+rather than jumping to max speed the moment there is any load on the
+CPU.  This behaviour more suitable in a battery powered environment.
+The governor is tweaked in the same manner as the "ondemand" governor
+however with the addition of:
+
+freq_step: this describes what percentage steps the cpu freq should be
+increased and decreased smoothly by, by default the cpu speed will
+increase in 5% chunks of your maximum cpu speed.  You can change this
+value to anywhere between 0 and 100 where '0' will effectively lock your
+CPU at a speed regardless of its load whilst '100' will, in theory, make
+it behave identically to the "ondemand" governor.
+
+down_threshold: same as the 'up_threshold' found for the "ondemand"
+governor but for the opposite direction.  For example when set to its
+default value of '20' it means that if the CPU usage needs to be below
+20% between samples to have the frequency decreased.
 
 3. The Governor Interface in the CPUfreq Core
 =============================================

--Boundary-00=_0hXODjFuYmy5Wu4--


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
