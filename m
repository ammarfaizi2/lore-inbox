Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWACSlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWACSlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWACSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:41:05 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:12247 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932405AbWACSlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:41:04 -0500
Subject: Re: 2.6.15-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060103161356.4e1b47e0@mango.fruits.de>
References: <20060103094720.GA16497@elte.hu>
	 <20060103153317.26a512fa@mango.fruits.de>
	 <20060103161356.4e1b47e0@mango.fruits.de>
Content-Type: multipart/mixed; boundary="=-YR9Q7n6NG+QIWLbN15x5"
Date: Tue, 03 Jan 2006 13:40:52 -0500
Message-Id: <1136313652.6039.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YR9Q7n6NG+QIWLbN15x5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-01-03 at 16:13 +0100, Florian Schmidt wrote:

> 
> i rejoiced too early. It just took a while to show up:

Yep.

Ingo,  I guess we have a problem.  There must be a reason not to hold
the rtc_lock and call the {add,mod,del}_timer functions, but your change
only makes the race condition less likely to happen, and not prevent it.
The attached program run on an SMP machine will eventually trigger the
race. 

$ gcc -o rtc_ioctl rtc_ioctl.c -lpthread
$ while : ; do ./rtc_ioctl ; done

The race is here:

	case RTC_PIE_ON:	/* Allow periodic ints		*/
	{

		/*
		 * We don't really want Joe User enabling more
		 * than 64Hz of interrupts on a multi-user machine.
		 */
		if (!kernel && (rtc_freq > rtc_max_user_freq) &&
			(!capable(CAP_SYS_RESOURCE)))
			return -EACCES;

		if (!(rtc_status & RTC_TIMER_ON)) {

// Another thread preempts here and turns the timer on.

			spin_lock_irq (&rtc_lock);
			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
			rtc_status |= RTC_TIMER_ON;
			spin_unlock_irq (&rtc_lock);

// now that the timer is pending, the add_timer will BUG.

			add_timer(&rtc_irq_timer);
		}
		set_rtc_irq_bit(RTC_PIE);

Should we create another lock to protect only the {add,mod,del}_timer?
Like the following patch?

-- Steve

Index: linux-2.6.15-rt1/drivers/char/rtc.c
===================================================================
--- linux-2.6.15-rt1.orig/drivers/char/rtc.c	2006-01-03 07:41:48.000000000 -0500
+++ linux-2.6.15-rt1/drivers/char/rtc.c	2006-01-03 13:25:47.000000000 -0500
@@ -205,6 +205,7 @@
  * rtc_task_lock nests inside rtc_lock.
  */
 static DEFINE_SPINLOCK(rtc_task_lock);
+static DEFINE_SPINLOCK(rtc_timer_lock);
 static rtc_task_t *rtc_callback = NULL;
 #endif
 
@@ -392,7 +393,8 @@
 	 *	the last read in the remainder of rtc_irq_data.
 	 */
 
-	spin_lock (&rtc_lock);
+	spin_lock(&rtc_timer_lock);
+	spin_lock(&rtc_lock);
 	rtc_irq_data += 0x100;
 	rtc_irq_data &= ~0xff;
 	if (is_hpet_enabled()) {
@@ -410,9 +412,10 @@
 	if (rtc_status & RTC_TIMER_ON)
 		mod = 1;
 
-	spin_unlock (&rtc_lock);
+	spin_unlock(&rtc_lock);
 	if (mod)
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+	spin_unlock(&rtc_timer_lock);
 
 	/* Now do the rest of the actions */
 	spin_lock(&rtc_task_lock);
@@ -506,10 +509,10 @@
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 		
-		spin_lock_irq (&rtc_lock);
+		spin_lock_irq(&rtc_lock);
 		data = rtc_irq_data;
 		rtc_irq_data = 0;
-		spin_unlock_irq (&rtc_lock);
+		spin_unlock_irq(&rtc_lock);
 
 		if (data != 0)
 			break;
@@ -541,7 +544,7 @@
 
 static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
 {
-	struct rtc_time wtime; 
+	struct rtc_time wtime;
 
 #ifdef RTC_IRQ
 	if (rtc_has_irq == 0) {
@@ -573,17 +576,23 @@
 	}
 	case RTC_PIE_OFF:	/* Mask periodic int. enab. bit	*/
 	{
+		int del = 0;
 		mask_rtc_irq_bit(RTC_PIE);
+		spin_lock_irq(&rtc_timer_lock);
+		spin_lock(&rtc_lock);
 		if (rtc_status & RTC_TIMER_ON) {
-			spin_lock_irq (&rtc_lock);
+			del = 1;
 			rtc_status &= ~RTC_TIMER_ON;
-			spin_unlock_irq (&rtc_lock);
-			del_timer(&rtc_irq_timer);
 		}
+		spin_unlock(&rtc_lock);
+		if (del)
+			del_timer(&rtc_irq_timer);
+		spin_unlock_irq(&rtc_timer_lock);
 		return 0;
 	}
 	case RTC_PIE_ON:	/* Allow periodic ints		*/
 	{
+		int add = 0;
 
 		/*
 		 * We don't really want Joe User enabling more
@@ -593,13 +602,17 @@
 			(!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;
 
+		spin_lock_irq(&rtc_timer_lock);
+		spin_lock(&rtc_lock);
 		if (!(rtc_status & RTC_TIMER_ON)) {
-			spin_lock_irq (&rtc_lock);
+			add = 1;
 			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
 			rtc_status |= RTC_TIMER_ON;
-			spin_unlock_irq (&rtc_lock);
-			add_timer(&rtc_irq_timer);
 		}
+		spin_unlock(&rtc_lock);
+		if (add)
+			add_timer(&rtc_irq_timer);
+		spin_unlock_irq(&rtc_timer_lock);
 		set_rtc_irq_bit(RTC_PIE);
 		return 0;
 	}
@@ -863,7 +876,7 @@
  * needed here. Or anywhere else in this driver. */
 static int rtc_open(struct inode *inode, struct file *file)
 {
-	spin_lock_irq (&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 
 	if(rtc_status & RTC_IS_OPEN)
 		goto out_busy;
@@ -872,11 +885,11 @@
 	rtc_status |= RTC_IS_OPEN;
 
 	rtc_irq_data = 0;
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 	return 0;
 
 out_busy:
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 	return -EBUSY;
 }
 
@@ -900,7 +913,8 @@
 	 * in use, and clear the data.
 	 */
 
-	spin_lock_irq(&rtc_lock);
+	spin_lock_irq(&rtc_timer_lock);
+	spin_lock(&rtc_lock);
 	if (!hpet_mask_rtc_irq_bit(RTC_PIE | RTC_AIE | RTC_UIE)) {
 		tmp = CMOS_READ(RTC_CONTROL);
 		tmp &=  ~RTC_PIE;
@@ -914,9 +928,10 @@
 		rtc_status &= ~RTC_TIMER_ON;
 		del = 1;
 	}
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock(&rtc_lock);
 	if (del)
 		del_timer(&rtc_irq_timer);
+	spin_unlock_irq(&rtc_timer_lock);
 
 	if (file->f_flags & FASYNC) {
 		rtc_fasync (-1, file, 0);
@@ -924,10 +939,10 @@
 no_irq:
 #endif
 
-	spin_lock_irq (&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 	rtc_irq_data = 0;
 	rtc_status &= ~RTC_IS_OPEN;
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 	rtc_close_event();
 	return 0;
 }
@@ -943,9 +958,9 @@
 
 	poll_wait(file, &rtc_wait, wait);
 
-	spin_lock_irq (&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 	l = rtc_irq_data;
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
 	if (l != 0)
 		return POLLIN | POLLRDNORM;
@@ -995,11 +1010,13 @@
 	unsigned char tmp;
 	int del;
 
-	spin_lock_irq(&rtc_lock);
+	spin_lock_irq(&rtc_timer_lock);
+	spin_lock(&rtc_lock);
 	spin_lock(&rtc_task_lock);
 	if (rtc_callback != task) {
 		spin_unlock(&rtc_task_lock);
-		spin_unlock_irq(&rtc_lock);
+		spin_unlock(&rtc_lock);
+		spin_unlock_irq(&rtc_timer_lock);
 		return -ENXIO;
 	}
 	rtc_callback = NULL;
@@ -1020,9 +1037,10 @@
 	}
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock(&rtc_task_lock);
+	spin_unlock(&rtc_lock);
 	if (del)
 		del_timer(&rtc_irq_timer);
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irq(&rtc_timer_lock);
 	return 0;
 #endif
 }
@@ -1282,10 +1300,12 @@
 	unsigned long freq;
 	int mod;
 
-	spin_lock_irq (&rtc_lock);
+	spin_lock_irq(&rtc_timer_lock);
+	spin_lock(&rtc_lock);
 
 	if (hpet_rtc_dropped_irq()) {
-		spin_unlock_irq(&rtc_lock);
+		spin_unlock(&rtc_lock);
+		spin_unlock_irq(&rtc_timer_lock);
 		return;
 	}
 
@@ -1300,9 +1320,10 @@
 
 	freq = rtc_freq;
 
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock(&rtc_lock);
 	if (mod)
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+	spin_unlock_irq(&rtc_timer_lock);
 
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 


--=-YR9Q7n6NG+QIWLbN15x5
Content-Disposition: attachment; filename=rtc_ioctl.c
Content-Type: text/x-csrc; name=rtc_ioctl.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <sched.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <linux/rtc.h>

#define RTC "/dev/rtc"

int run = 1;
#define NR_THREADS 3

void *func(void *dat)
{
	int fd = (int)dat;
	unsigned long data;


	while (run) {
		ioctl(fd, RTC_PIE_ON, 0);
		read(fd, &data, sizeof(data));
		ioctl(fd, RTC_PIE_OFF, 0);

		printf("%08lx\n",data);
	}
	return NULL;
}

int main(int argc, char **argv)
{
	int fd;
	int i;
	pthread_t t[NR_THREADS];

	if ((fd = open(RTC, O_RDONLY|O_NONBLOCK)) < 0) {
		perror(RTC);
		exit(0);
	}
	
	ioctl(fd, RTC_IRQP_SET, 1024);

	for (i=0; i < NR_THREADS; i++) {
		if (pthread_create(&t[i],NULL,func, (void*)fd)) {
			perror("pthread_creat");
			exit(-1);
		}
	}

	sched_yield();
	run = 0;
	for (i=0; i < NR_THREADS; i++)
		pthread_join(t[i], NULL);


	close (fd);
	exit(0);
}

--=-YR9Q7n6NG+QIWLbN15x5--

