Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVGHJ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVGHJ4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVGHJ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:56:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53922 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262447AbVGHJ41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:56:27 -0400
Date: Fri, 8 Jul 2005 11:56:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
Message-ID: <20050708095600.GA5910@elte.hu>
References: <1119375988.28018.44.camel@cmn37.stanford.edu> <1120256404.22902.46.camel@cmn37.stanford.edu> <20050703133738.GB14260@elte.hu> <1120428465.21398.2.camel@cmn37.stanford.edu> <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org> <20050707194914.GA1161@elte.hu> <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org> <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org> <20050708085253.GA1177@elte.hu> <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <28798.195.245.190.94.1120815616.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OTOH, I'll take this chance to show you something that is annoying me 
> for quite some time. Just look to the attached chart where I've marked 
> the spot with an arrow and a question mark. Its just one example of a 
> strange behavior/phenomenon while running the jack_test4.2 test on 
> PREEMPT_RT kernels: the CPU usage, which stays normally around 50%, 
> suddenly jumps to 60% steady, starting at random points in time but 
> always some time after the test has been started. Note that this 
> randomness surely adds to the the slight differences found on the 
> above results.

how long does this condition persist? Firstly, please upgrade to the 
-51-16 kernel, previous kernels had a condition where interrupt storms 
(or repeat interrupts) could occur. (Your irqs/sec values dont suggest 
such a condition, but it could still occur.)

Then could you enable profiling (CONFIG_PROFILING=y and profile=1 boot 
parameter), and create a script like this to capture a kernel profile 
for a fixed amount of time:

 #!/bin/bash

 readprofile -r          # reset profile
 sleep 10
 readprofile -n -m /home/mingo/System.map | sort -n

and start it manually when the anomaly triggers. Also start it during a 
'normal' period of the test. The output should give us a rough idea of 
what is happening. This type of profiling is very low-overhead so it 
wont disturb the condition.

Note that you can increase the frequency and the quality of profiling by 
enabling the NMI watchdog (LOCAL_APIC in the .config and nmi_watchdog=2 
boot option), in the -RT kernel it will automatically switch the 
profiling tick to occur from NMI context. Such tracing will also show 
overhead occuring in irqs-off functions.

a more intrusive method would be to capture a trace of the anomalous 
workload. For that you'll need to enable WAKEUP_TIMING+LATENCY_TRACING 
(this is the lowest-overhead tracing variant), and run the attached 
trace-it utility during the anomaly:

	trace-it > anomaly.log

and during the normal period as well:

	trace-it > normal.log

note that to capture a significant amount of system activity you might 
need to increase MAX_TRACE in kernel/latency.c (e.g. 8-fold should be 
enough to capture a second worth of system activity). If you generate 
such large traces then please bzip2 them and send them to me privately.  
You might also need to increase the usleep() period in trace-it.c, to 
capture longer periods of time.

note that the enabling of tracing could also make the anomalous 
condition go away, so it might not be the right method.

	Ingo

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace-it.c"


/*
 * Copyright (C) 1999, Ingo Molnar <mingo@redhat.com>
 */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <linux/unistd.h>

int main (int argc, char **argv)
{
	int ret;

	if (getuid() != 0) {
		fprintf(stderr, "needs to run as root.\n");
		exit(1);
	}
	ret = system("cat /proc/sys/kernel/mcount_enabled >/dev/null 2>/dev/null");
	if (ret) {
		fprintf(stderr, "CONFIG_LATENCY_TRACING not enabled?\n");
		exit(1);
	}
	system("echo 1 > /proc/sys/kernel/trace_all_cpus");
	system("echo 1 > /proc/sys/kernel/trace_enabled");
	system("echo 0 > /proc/sys/kernel/trace_freerunning");
	system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
	system("echo 1 > /proc/sys/kernel/trace_user_triggered");
	system("echo 0 > /proc/sys/kernel/trace_verbose");
	system("echo 0 > /proc/sys/kernel/preempt_max_latency");
	system("echo 0 > /proc/sys/kernel/preempt_thresh");
	system("[ -e /proc/sys/kernel/wakeup_timing ] && echo 0 > /proc/sys/kernel/wakeup_timing");
	system("echo 1 > /proc/sys/kernel/mcount_enabled");

	gettimeofday(0, 1);
	usleep(100000);
	gettimeofday(0, 0);

	system("cat /proc/latency_trace");

	return 0;
}



--liOOAslEiF7prFVr
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=trace-it
Content-Transfer-Encoding: base64

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
di9udWxsAABDT05GSUdfTEFURU5DWV9UUkFDSU5HIG5vdCBlbmFibGVkPwoAAAAAZWNobyAx
ID4gL3Byb2Mvc3lzL2tlcm5lbC90cmFjZV9hbGxfY3B1cwAAAABlY2hvIDEgPiAvcHJvYy9z
eXMva2VybmVsL3RyYWNlX2VuYWJsZWQAZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC90cmFj
ZV9mcmVlcnVubmluZwBlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL3RyYWNlX3ByaW50X2F0
X2NyYXNoAABlY2hvIDEgPiAvcHJvYy9zeXMva2VybmVsL3RyYWNlX3VzZXJfdHJpZ2dlcmVk
AABlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL3RyYWNlX3ZlcmJvc2UAZWNobyAwID4gL3By
b2Mvc3lzL2tlcm5lbC9wcmVlbXB0X21heF9sYXRlbmN5AAAAZWNobyAwID4gL3Byb2Mvc3lz
L2tlcm5lbC9wcmVlbXB0X3RocmVzaAAAAABbIC1lIC9wcm9jL3N5cy9rZXJuZWwvd2FrZXVw
X3RpbWluZyBdICYmIGVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvd2FrZXVwX3RpbWluZwAA
AABlY2hvIDEgPiAvcHJvYy9zeXMva2VybmVsL21jb3VudF9lbmFibGVkAGNhdCAvcHJvYy9s
YXRlbmN5X3RyYWNlAAAAAAAAAAD/////AAAAAP////8AAAAAAAAAAAEAAAAkAAAADAAAAFyD
BAgNAAAAvIYECAQAAABIgQQIBQAAAEyCBAgGAAAAjIEECAoAAACPAAAACwAAABAAAAAVAAAA
AAAAAAMAAAA8mgQIAgAAADgAAAAUAAAAEQAAABcAAAAkgwQIEQAAABSDBAgSAAAAEAAAABMA
AAAIAAAA/v//b/SCBAj///9vAQAAAPD//2/cggQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHCZBAgAAAAAAAAAAIqDBAiagwQIqoMECLqD
BAjKgwQI2oMECOqDBAgAAAAAAAAAAGiZBAgAR0NDOiAoR05VKSAzLjQuMSAyMDA0MDgzMSAo
UmVkIEhhdCAzLjQuMS0xMCkAAEdDQzogKEdOVSkgMy40LjEgMjAwNDA4MzEgKFJlZCBIYXQg
My40LjEtMTApAABHQ0M6IChHTlUpIDMuNC4xIDIwMDQwODMxIChSZWQgSGF0IDMuNC4xLTEw
KQAAR0NDOiAoR05VKSAzLjQuMSAyMDA0MDgzMSAoUmVkIEhhdCAzLjQuMS0xMCkAAEdDQzog
KEdOVSkgMy40LjEgMjAwNDA4MzEgKFJlZCBIYXQgMy40LjEtMTApAABHQ0M6IChHTlUpIDMu
NC4xIDIwMDQwODMxIChSZWQgSGF0IDMuNC4xLTEwKQAALnN5bXRhYgAuc3RydGFiAC5zaHN0
cnRhYgAuaW50ZXJwAC5ub3RlLkFCSS10YWcALmhhc2gALmR5bnN5bQAuZHluc3RyAC5nbnUu
dmVyc2lvbgAuZ251LnZlcnNpb25fcgAucmVsLmR5bgAucmVsLnBsdAAuaW5pdAAudGV4dAAu
ZmluaQAucm9kYXRhAC5laF9mcmFtZQAuY3RvcnMALmR0b3JzAC5qY3IALmR5bmFtaWMALmdv
dAAuZ290LnBsdAAuZGF0YQAuYnNzAC5jb21tZW50AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAGwAAAAEAAAACAAAAFIEECBQBAAATAAAAAAAAAAAAAAABAAAA
AAAAACMAAAAHAAAAAgAAACiBBAgoAQAAIAAAAAAAAAAAAAAABAAAAAAAAAAxAAAABQAAAAIA
AABIgQQISAEAAEQAAAAEAAAAAAAAAAQAAAAEAAAANwAAAAsAAAACAAAAjIEECIwBAADAAAAA
BQAAAAEAAAAEAAAAEAAAAD8AAAADAAAAAgAAAEyCBAhMAgAAjwAAAAAAAAAAAAAAAQAAAAAA
AABHAAAA////bwIAAADcggQI3AIAABgAAAAEAAAAAAAAAAIAAAACAAAAVAAAAP7//28CAAAA
9IIECPQCAAAgAAAABQAAAAEAAAAEAAAAAAAAAGMAAAAJAAAAAgAAABSDBAgUAwAAEAAAAAQA
AAAAAAAABAAAAAgAAABsAAAACQAAAAIAAAAkgwQIJAMAADgAAAAEAAAACwAAAAQAAAAIAAAA
dQAAAAEAAAAGAAAAXIMECFwDAAAXAAAAAAAAAAAAAAAEAAAAAAAAAHAAAAABAAAABgAAAHSD
BAh0AwAAgAAAAAAAAAAAAAAABAAAAAQAAAB7AAAAAQAAAAYAAAD0gwQI9AMAAMgCAAAAAAAA
AAAAAAQAAAAAAAAAgQAAAAEAAAAGAAAAvIYECLwGAAAaAAAAAAAAAAAAAAAEAAAAAAAAAIcA
AAABAAAAAgAAANiGBAjYBgAAfQIAAAAAAAAAAAAABAAAAAAAAACPAAAAAQAAAAIAAABYiQQI
WAkAAAQAAAAAAAAAAAAAAAQAAAAAAAAAmQAAAAEAAAADAAAAXJkECFwJAAAIAAAAAAAAAAAA
AAAEAAAAAAAAAKAAAAABAAAAAwAAAGSZBAhkCQAACAAAAAAAAAAAAAAABAAAAAAAAACnAAAA
AQAAAAMAAABsmQQIbAkAAAQAAAAAAAAAAAAAAAQAAAAAAAAArAAAAAYAAAADAAAAcJkECHAJ
AADIAAAABQAAAAAAAAAEAAAACAAAALUAAAABAAAAAwAAADiaBAg4CgAABAAAAAAAAAAAAAAA
BAAAAAQAAAC6AAAAAQAAAAMAAAA8mgQIPAoAACgAAAAAAAAAAAAAAAQAAAAEAAAAwwAAAAEA
AAADAAAAZJoECGQKAAAMAAAAAAAAAAAAAAAEAAAAAAAAAMkAAAAIAAAAAwAAAHCaBAhwCgAA
CAAAAAAAAAAAAAAABAAAAAAAAADOAAAAAQAAAAAAAAAAAAAAcAoAABQBAAAAAAAAAAAAAAEA
AAAAAAAAEQAAAAMAAAAAAAAAAAAAAIQLAADXAAAAAAAAAAAAAAABAAAAAAAAAAEAAAACAAAA
AAAAAAAAAAC8EAAAwAQAABsAAAAsAAAABAAAABAAAAAJAAAAAwAAAAAAAAAAAAAAfBUAAKsC
AAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUgQQIAAAAAAMAAQAAAAAA
KIEECAAAAAADAAIAAAAAAEiBBAgAAAAAAwADAAAAAACMgQQIAAAAAAMABAAAAAAATIIECAAA
AAADAAUAAAAAANyCBAgAAAAAAwAGAAAAAAD0ggQIAAAAAAMABwAAAAAAFIMECAAAAAADAAgA
AAAAACSDBAgAAAAAAwAJAAAAAABcgwQIAAAAAAMACgAAAAAAdIMECAAAAAADAAsAAAAAAPSD
BAgAAAAAAwAMAAAAAAC8hgQIAAAAAAMADQAAAAAA2IYECAAAAAADAA4AAAAAAFiJBAgAAAAA
AwAPAAAAAABcmQQIAAAAAAMAEAAAAAAAZJkECAAAAAADABEAAAAAAGyZBAgAAAAAAwASAAAA
AABwmQQIAAAAAAMAEwAAAAAAOJoECAAAAAADABQAAAAAADyaBAgAAAAAAwAVAAAAAABkmgQI
AAAAAAMAFgAAAAAAcJoECAAAAAADABcAAAAAAAAAAAAAAAAAAwAYAAAAAAAAAAAAAAAAAAMA
GQAAAAAAAAAAAAAAAAADABoAAAAAAAAAAAAAAAAAAwAbAAEAAAAYhAQIAAAAAAIADAARAAAA
AAAAAAAAAAAEAPH/HAAAAFyZBAgAAAAAAQAQACoAAABkmQQIAAAAAAEAEQA4AAAAbJkECAAA
AAABABIARQAAAGyaBAgAAAAAAQAWAEkAAAB0mgQIAQAAAAEAFwBVAAAAPIQECAAAAAACAAwA
awAAAHCEBAgAAAAAAgAMABEAAAAAAAAAAAAAAAQA8f93AAAAYJkECAAAAAABABAAhAAAAGiZ
BAgAAAAAAQARAJEAAABYiQQIAAAAAAEADwCfAAAAbJkECAAAAAABABIAqwAAAJiGBAgAAAAA
AgAMAMEAAAAAAAAAAAAAAAQA8f/MAAAAAAAAADwAAAASAAAA3gAAAHCZBAgAAAAAEQATAOcA
AADYhgQIBAAAABEADgDuAAAAAAAAACEAAAASAAAAAQEAAFyZBAgAAAAAEALx/xIBAABomgQI
AAAAABECFgAfAQAAVIYECEIAAAASAAwALwEAAAAAAAB/AAAAEgAAAEEBAABcgwQIAAAAABIA
CgBHAQAAcJoECAQAAAARABcAWQEAAPSDBAgAAAAAEgAMAGABAABcmQQIAAAAABAC8f9zAQAA
AIYECFIAAAASAAwAgwEAAHCaBAgAAAAAEADx/48BAACchAQIYwEAABIADACUAQAAAAAAAO8A
AAASAAAAsQEAAFyZBAgAAAAAEALx/8IBAABkmgQIAAAAACAAFgDNAQAAAAAAAFEAAAASAAAA
3wEAALyGBAgAAAAAEgANAOUBAAAAAAAAOgAAABIAAAD9AQAAXJkECAAAAAAQAvH/EQIAAAAA
AADZAAAAEgAAACECAABwmgQIAAAAABAA8f8oAgAAPJoECAAAAAARABUAPgIAAHiaBAgAAAAA
EADx/0MCAABcmQQIAAAAABAC8f9WAgAA3IYECAQAAAARAA4AZQIAAGSaBAgAAAAAEAAWAHIC
AAAAAAAAAAAAACAAAACGAgAAXJkECAAAAAAQAvH/nAIAAAAAAAAAAAAAIAAAAABjYWxsX2dt
b25fc3RhcnQAY3J0c3R1ZmYuYwBfX0NUT1JfTElTVF9fAF9fRFRPUl9MSVNUX18AX19KQ1Jf
TElTVF9fAHAuMABjb21wbGV0ZWQuMQBfX2RvX2dsb2JhbF9kdG9yc19hdXgAZnJhbWVfZHVt
bXkAX19DVE9SX0VORF9fAF9fRFRPUl9FTkRfXwBfX0ZSQU1FX0VORF9fAF9fSkNSX0VORF9f
AF9fZG9fZ2xvYmFsX2N0b3JzX2F1eAB0cmFjZS1pdC5jAHVzbGVlcEBAR0xJQkNfMi4wAF9E
WU5BTUlDAF9mcF9odwBmcHJpbnRmQEBHTElCQ18yLjAAX19maW5pX2FycmF5X2VuZABfX2Rz
b19oYW5kbGUAX19saWJjX2NzdV9maW5pAHN5c3RlbUBAR0xJQkNfMi4wAF9pbml0AHN0ZGVy
ckBAR0xJQkNfMi4wAF9zdGFydABfX2ZpbmlfYXJyYXlfc3RhcnQAX19saWJjX2NzdV9pbml0
AF9fYnNzX3N0YXJ0AG1haW4AX19saWJjX3N0YXJ0X21haW5AQEdMSUJDXzIuMABfX2luaXRf
YXJyYXlfZW5kAGRhdGFfc3RhcnQAZ2V0dWlkQEBHTElCQ18yLjAAX2ZpbmkAZ2V0dGltZW9m
ZGF5QEBHTElCQ18yLjAAX19wcmVpbml0X2FycmF5X2VuZABleGl0QEBHTElCQ18yLjAAX2Vk
YXRhAF9HTE9CQUxfT0ZGU0VUX1RBQkxFXwBfZW5kAF9faW5pdF9hcnJheV9zdGFydABfSU9f
c3RkaW5fdXNlZABfX2RhdGFfc3RhcnQAX0p2X1JlZ2lzdGVyQ2xhc3NlcwBfX3ByZWluaXRf
YXJyYXlfc3RhcnQAX19nbW9uX3N0YXJ0X18A

--liOOAslEiF7prFVr--
