Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbTCSEfD>; Tue, 18 Mar 2003 23:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262925AbTCSEfD>; Tue, 18 Mar 2003 23:35:03 -0500
Received: from ext.aurema.com ([203.31.96.4]:42167 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S262924AbTCSEfA>;
	Tue, 18 Mar 2003 23:35:00 -0500
Date: Wed, 19 Mar 2003 15:45:54 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Subject: fluctuations in /proc/stat btime field
Message-ID: <20030319154554.C3492@aurema.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On a dual SMP box running SuSE-2.4.19-79 (United Linux rc4), the boot
time in /proc/stat can vary 1 second when read.  I haven't seen this
on a UP box. Its not a major issue, but I guess its a hindrance if
one's expecting it to never change:

gen2 12:06:52 ~: grep btime /proc/stat
btime 1046838984
gen2 12:07:06 ~: grep btime /proc/stat
btime 1046838984
gen2 12:07:07 ~: grep btime /proc/stat
btime 1046838983
gen2 12:07:07 ~: grep btime /proc/stat
btime 1046838983
gen2 12:07:08 ~: grep btime /proc/stat
btime 1046838983
gen2 12:07:09 ~: grep btime /proc/stat
btime 1046838984
gen2 12:07:10 ~: grep btime /proc/stat
btime 1046838984
gen2 12:07:11 ~: grep btime /proc/stat
btime 1046838983

I'm not familiar with the way IO-APIC timers work or the interrupt
timer itself, so can someone explain why this is the case? I'm
guessing that it might simply be a timing issue between when the
actual interrupt handling updating jiffies in do_timer and the bottom
half updating xtime.tv_sec (see kernel/timer.c). 

Maybe by caching the btime value so that its only calculated once is
the way to go. Attached is the suggested fix, as well as the output
from /proc/cpuinfo & /proc/interrupts.

If someone could get back to me on this it would be much appreciated.

Thanks,
-- 
		Kingsley

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gen2cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 548.544
cache size	: 128 KB
physical id	: 0
threads		: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 1094.45

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 548.544
cache size	: 128 KB
physical id	: 0
threads		: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 1094.45


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gen2interrupts

           CPU0       CPU1       
  0:   61761933   59169714    IO-APIC-edge  timer
  1:        163        212    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        184        160    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
 12:          0          0    IO-APIC-edge  PS/2 Mouse
 14:    3191782    3055354    IO-APIC-edge  ide0
 15:          0          2    IO-APIC-edge  ide1
 16:   12195142   12320072   IO-APIC-level  eth0
NMI:          0          0 
LOC:  120928241  120928231 
ERR:          0
MIS:          0

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="btime.diff"

--- fs/proc/proc_misc.c.old	Wed Mar 19 15:21:20 2003
+++ fs/proc/proc_misc.c	Wed Mar 19 15:31:36 2003
@@ -250,6 +250,7 @@
 static int kstat_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
+	static unsigned long btime = 0UL;
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
@@ -314,12 +315,15 @@
 		}
 	}
 
+	if (!btime)
+		btime = xtime.tv_sec - jif / HZ;
+
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
 		"processes %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - jif / HZ,
+		btime,
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);

--TB36FDmn/VVEgNH/--
