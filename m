Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRAGM4K>; Sun, 7 Jan 2001 07:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131622AbRAGM4A>; Sun, 7 Jan 2001 07:56:00 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:13331 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131476AbRAGMzw>; Sun, 7 Jan 2001 07:55:52 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A586352.5286D6A@yahoo.com>
Date: Sun, 07 Jan 2001 07:38:42 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: BJerrick@easystreet.com
CC: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 500 ms offset in i386 Real Time Clock setting
In-Reply-To: <200101061935.f06JZqx18624@enzo.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BJerrick@easystreet.com wrote:
> 
>     Neither hwclock nor the /dev/rtc driver takes the following comment from
> set_rtc_mmss() in arch/i386/kernel/time.c into account.  As a result, using
> hwclock --systohc or --adjust always leaves the Hardware Clock 500 ms ahead of
> the System Clock:

[...]

> Shouldn't there be some kernel interface that hides this machine-dependency
> from user-level code; i.e., that sets time more precisely?

I don't have a problem with the rtc driver delaying 500ms before setting the
time since that is in fact a feature of the hardware, and it probably should
have done this from the beginning.  However I would have a problem with the 
rtc driver using system time (kernel xtime) to synchronize the start of that
delay - the user may want to synchronize the rtc with some external source.

Simple patch (2.4.0) to add the delay follows, along with a $0.02 test prog 
I used to make sure things behave as desired.  (I guess hwclock will still
require its own delay for when /dev/rtc isn't present and it goes direct.)

Paul.

--- drivers/char/rtc.c~	Sat Jan  6 05:40:24 2001
+++ drivers/char/rtc.c	Sun Jan  7 07:17:39 2001
@@ -40,6 +40,7 @@
  *	1.10b	Andrew Morton: SMP lock fix
  *	1.10c	Cesar Barros: SMP locking fixes and cleanup
  *	1.10d	Paul Gortmaker: delete paranoia check in rtc_exit
+ *	1.10e	Paul Gortmaker: wait 0.5s before writing time to rtc.
  */
 
 #define RTC_VERSION		"1.10d"
@@ -414,6 +415,13 @@
 			BIN_TO_BCD(mon);
 			BIN_TO_BCD(yrs);
 		}
+
+		/* The second for which the clock is set is only 0.5s long */
+		spin_unlock_irq(&rtc_lock);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ/2);
+		set_current_state(TASK_RUNNING);
+		spin_lock_irq(&rtc_lock);
 
 		save_control = CMOS_READ(RTC_CONTROL);
 		CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);

   ----------------------8<-------------------8<-----------------------
/* 
 * set RTC when system time ticks over, and then read system time on
 * ten RTC interrupts.  An offset of 500,000 usec (0.5sec) will appear
 * for rtc drivers that don't schedule_timeout(HZ/2) before setting rtc
 * time, since the second for which the rtc is set is only 1/2 sec long.
 * With schedule_timeout(), it will be between (n-1)990,000 and (n)10,000
 * (Assumes RTC=UTC; change gmtime() to localtime() if not the case)
 */

#include <stdio.h>
#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <time.h>
 
void main(void)

{

int i, fd, retval;
unsigned long data;
struct tm *tm;

struct timezone tz = {0,};
struct timeval start, now;

fd = open ("/dev/rtc", O_RDONLY);

if (fd ==  -1) {
	perror("/dev/rtc");
	exit(errno);
}
 
printf("ZZZzzz. Waiting for next second...\n");
gettimeofday(&start, &tz);
do {
	gettimeofday(&now, &tz);
} while (now.tv_sec == start.tv_sec);

tm = gmtime(&start.tv_sec);

retval = ioctl(fd, RTC_SET_TIME, tm);	/* need root */
if (retval == -1) {
	perror("ioctl");
	exit(errno);
}

ioctl(fd, RTC_UIE_ON);
printf("10 gettimeofday values (sec, usec) exactly when RTC updates:\n");

gettimeofday(&start, &tz);
for (i=0;i<10;i++){
	read(fd, &data, sizeof(unsigned long));    /* this blocks */
	gettimeofday(&now, &tz);
	printf("\t%ld\t%ld\n", now.tv_sec-start.tv_sec, now.tv_usec);
}

}
 





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
