Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVATAXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVATAXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVATAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:20:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:7892 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262000AbVATAQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:16:26 -0500
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
	scheduling
From: utz lehmann <lkml@s2y4n2c.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
In-Reply-To: <41EEE1B1.9080909@kolivas.org>
References: <41EEE1B1.9080909@kolivas.org>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 01:16:17 +0100
Message-Id: <1106180177.4036.27.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con

On Thu, 2005-01-20 at 09:39 +1100, Con Kolivas wrote:
> This is version 2 of the SCHED_ISO patch with the yield bug fixed and 
> code cleanups.

Thanks for the update.


@@ -2406,6 +2489,10 @@ void scheduler_tick(void)
 	task_t *p = current;
 
 	rq->timestamp_last_tick = sched_clock();
+	if (iso_task(p) && !rq->iso_refractory)
+		inc_iso_ticks(rq, p);
+	else 
+		dec_iso_ticks(rq, p);

scheduler_tick() is not only called by the timer interrupt but also form
the fork code. Is this intended? I think the accounting for
iso_refractory is wrong. Isn't calling it from
timer.c::update_process_times() better?

And shouldn't real RT task also counted? If RT tasks use 40% cpu you can
lockup the system as unprivileged user with SCHED_ISO because it doesn't
reach the 70% cpu limit.

Futher on i see a fundamental problem with this accounting for
iso_refractory. What if i manage as unprivileged user to run a SCHED_ISO
task which consumes all cpu and only sleeps very short during the timer
interrupt? I think this will nearly lockup or very slow down the system.
The iso_cpu limit can't guaranteed.


My simple yield DoS don't work anymore. But i found another way.
Running this as SCHED_ISO:

#include <stdio.h>
#include <unistd.h>
#include <sched.h>
#include <sys/time.h>
#include <sys/resource.h>

struct timeval tv;
int a, b, i0, i1;

int cpuusage ()
{
	struct rusage ru;

	getrusage(RUSAGE_SELF, &ru);
	return ru.ru_utime.tv_usec + ru.ru_stime.tv_usec;
}

int main ()
{
	while(1) {
		a = tv.tv_sec;
		b = tv.tv_usec;
		gettimeofday(&tv, 0);
		i0 = i1;
		i1 = cpuusage();
		if (i0 != i1) {
//			printf("%d.%06d\t%d.%06d\t%d\t%d\n",
//			       a, b, (int)tv.tv_sec, (int)tv.tv_usec, i0, i1);
		}
	}
}

It stalled the system for a few seconds and the drop it to SCHED_OTHER.
Then start a additional SCHED_OTHER cpu hog (while true; do : ; done).
The system locks up after a few seconds.
sysrq-n causes a reboot.


utz


