Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVF1IjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVF1IjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVF1IOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:14:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36583 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261930AbVF1ILP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:11:15 -0400
Date: Tue, 28 Jun 2005 10:10:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050628081053.GC7368@elte.hu>
References: <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org> <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org> <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu> <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu> <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org> <20050627081542.GA15096@elte.hu> <Pine.LNX.4.58.0506272001190.5720@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506272001190.5720@echo.lysdexia.org>
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


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* William Weston <weston@sysex.net> wrote:

> OK.  Running on -50-25 now.  The burnP6 starvation doesn't seem to 
> affect the whole system, but comes close enough to require the reset 
> button every time.  I usually, but not always, lose network, X, the 
> keyboard, mouse, and serial console.  I'm still unable to get any sort 
> of a trace from these lockups, since it's looking more like a bunch of 
> processes starving than a kernel crash or a full lockup.
> 
> Once, with VLC (viewing a 5mbit/s mcast/udp stream) and two burnP6 
> instances running, I was able to fire up top on the serial console and 
> found out that the IRQ thread for the ns83820 nic was using 99% of one 
> CPU.

aha! that's an important clue. It seems you've got a screaming interrupt 
or some other loop in ns83820 irq handling. Could you do this:

	chrt -o 0 -p `pidof 'IRQ 18'`

(assuming your ns83820 device is still on IRQ18) To check the command 
was effective, enter the following command:

	chrt -o -p `pidof 'IRQ 18'`

and you should see output like:

	pid 748's current scheduling policy: SCHED_OTHER
	pid 748's current scheduling priority: 0

i.e. the thread is not SCHED_FIFO anymore.

this will not fix the ns83820 problem for you, but will make it more 
debuggable - you will still probably lose networking, but keyboard and 
the local console should work fine. You should see a 99% CPU-time 
looping ns83820 IRQ thread when the condition triggers. To debug the 
condition further, could you do something like:

	vmstat 1

what kind of interrupt rate ('in' field) does it report? If it's very 
high then it's a screaming interrupt, if it's low then the IRQ thread is 
looping for some other reason. (but both would be bugs of the -RT 
kernel.)

also, could you try to get a trace of what the IRQ thread is doing. I've 
attached trace-it.c, just run it as root (on a LATENCY_TRACING-enabled 
-RT kernel) to get a finegrained trace of what's going on in the system. 
Whenever the thread-spinning occurs, just run this utility:

	trace-it > trace.txt

and you should get a couple of milliseconds worth of system activity.  
The trace output should look like a really long latency-trace. (The 
latency traces usually compress really well with bzip2 -9, so you can 
attach it to public replies too, if compressed - that way others can 
have a look too.)

> Once, with a normal desktop load and a yum update, this came across on 
> the serial console:
> 
> cat/2100[CPU#1]: BUG in update_out_trace at kernel/latency.c:587

on SMP this could occur if the TSCs of different CPUs are too apart from 
each other. I'll probably put an automatic check for this into the 
/proc/latency_trace code.

	Ingo

--/9DWx/yDrRhgMJTb
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



--/9DWx/yDrRhgMJTb
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=trace-it
Content-Transfer-Encoding: base64

f0VMRgEBAQAAAAAAAAAAAAIAAwABAAAA9IMECDQAAABcDAAAAAAAADQAIAAHACgAHAAZAAYA
AAA0AAAANIAECDSABAjgAAAA4AAAAAUAAAAEAAAAAwAAABQBAAAUgQQIFIEECBMAAAATAAAA
BAAAAAEAAAABAAAAAAAAAACABAgAgAQIXAkAAFwJAAAFAAAAABAAAAEAAABcCQAAXJkECFyZ
BAgUAQAAHAEAAAYAAAAAEAAAAgAAAHAJAABwmQQIcJkECMgAAADIAAAABgAAAAQAAAAEAAAA
KAEAACiBBAgogQQIIAAAACAAAAAEAAAABAAAAFHldGQAAAAAAAAAAAAAAAAAAAAAAAAAAAYA
AAAEAAAAL2xpYi9sZC1saW51eC5zby4yAAAEAAAAEAAAAAEAAABHTlUAAAAAAAIAAAACAAAA
BQAAAAMAAAAMAAAACwAAAAgAAAAJAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAABAAAAAUA
AAAHAAAAAwAAAAYAAAAKAAAAAAAAAAAAAAAAAAAAAAAAAC4AAAAAAAAAPAAAABIAAABDAAAA
AAAAACEAAAASAAAAPAAAAAAAAAB/AAAAEgAAAFgAAABwmgQIBAAAABEAFwBzAAAAAAAAAO8A
AAASAAAANQAAAAAAAABRAAAAEgAAAEsAAAAAAAAAOgAAABIAAABfAAAAAAAAANkAAAASAAAA
ZAAAANyGBAgEAAAAEQAOAAEAAAAAAAAAAAAAACAAAAAVAAAAAAAAAAAAAAAgAAAAAF9Kdl9S
ZWdpc3RlckNsYXNzZXMAX19nbW9uX3N0YXJ0X18AbGliYy5zby42AHVzbGVlcABnZXR1aWQA
c3lzdGVtAGZwcmludGYAZ2V0dGltZW9mZGF5AHN0ZGVycgBleGl0AF9JT19zdGRpbl91c2Vk
AF9fbGliY19zdGFydF9tYWluAEdMSUJDXzIuMAAAAAACAAIAAgACAAIAAgACAAIAAQAAAAAA
AQABACQAAAAQAAAAAAAAABBpaQ0AAAIAhQAAAAAAAAA4mgQIBgsAAHCaBAgFBAAASJoECAcB
AABMmgQIBwIAAFCaBAgHAwAAVJoECAcFAABYmgQIBwYAAFyaBAgHBwAAYJoECAcIAABVieWD
7AjosQAAAOgEAQAA6CcDAADJwwD/NUCaBAj/JUSaBAgAAAAA/yVImgQIaAAAAADp4P////8l
TJoECGgIAAAA6dD/////JVCaBAhoEAAAAOnA/////yVUmgQIaBgAAADpsP////8lWJoECGgg
AAAA6aD/////JVyaBAhoKAAAAOmQ/////yVgmgQIaDAAAADpgP///zHtXonhg+TwUFRSaFSG
BAhoAIYECFFWaJyEBAjon/////SQkFWJ5VPoAAAAAFuBwxsWAABSi4P8////hcB0Av/QWFvJ
w5CQkFWJ5YPsCIA9dJoECAB0D+sfjXYAg8AEo2yaBAj/0qFsmgQIixCF0nXrxgV0mgQIAcnD
ifZVieWD7AihbJkECIXAdBm4AAAAAIXAdBCD7AxobJkECP/Qg8QQjXYAycOQkFWJ5YPsCIPk
8LgAAAAAg8APg8APwegEweAEKcToB////4XAdCCD7Aho4IYECP81cJoECOjA/v//g8QQg+wM
agHoA////4PsDGj4hgQI6Lb+//+DxBCJRfyDffwAdCCD7AhoNIcECP81cJoECOiH/v//g8QQ
g+wMagHoyv7//4PsDGhchwQI6H3+//+DxBCD7AxoiIcECOht/v//g8QQg+wMaLCHBAjoXf7/
/4PEEIPsDGjchwQI6E3+//+DxBCD7AxoDIgECOg9/v//g8QQg+wMaDyIBAjoLf7//4PEEIPs
DGhkiAQI6B3+//+DxBCD7AxolIgECOgN/v//g8QQg+wMaMCIBAjo/f3//4PEEIPsDGgUiQQI
6O39//+DxBCD7AhqAWoA6A7+//+DxBCD7AxooIYBAOiu/f//g8QQg+wIagBqAOjv/f//g8QQ
g+wMaD2JBAjor/3//4PEELgAAAAAycOQVYnlV1ZTg+wM6AAAAABbgcMuFAAA6EL9//+NgyD/
//+NkyD///+JRfAp0DH2wfgCOcZzFonXifb/FLKLTfAp+UbB+QI5zon6cu6DxAxbXl/Jw4n2
VYnlV1ZT6AAAAABbgcPdEwAAjYMg////jbsg////KfjB+AKD7AyNcP/rBZD/FLdOg/7/dffo
LgAAAIPEDFteX8nDkJBVieVTUrtcmQQIoVyZBAjrCo12AIPrBP/QiwOD+P919FhbycNVieVT
6AAAAABbgcN3EwAAUOhq/f//WVvJwwAAAwAAAAEAAgBuZWVkcyB0byBydW4gYXMgcm9vdC4K
AABjYXQgL3Byb2Mvc3lzL2tlcm5lbC9tY291bnRfZW5hYmxlZCA+L2Rldi9udWxsIDI+L2Rl
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

--/9DWx/yDrRhgMJTb--
