Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129802AbQKMRoN>; Mon, 13 Nov 2000 12:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbQKMRoD>; Mon, 13 Nov 2000 12:44:03 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:12050 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129802AbQKMRnx>; Mon, 13 Nov 2000 12:43:53 -0500
Message-ID: <3A102916.ACD71F76@mvista.com>
Date: Mon, 13 Nov 2000 09:47:02 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Keith Owens <kaos@ocs.com.au>, John Kacur <jkacur@home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 compile error undefined reference to `bust_spinlocks' 
 WHAT?!
In-Reply-To: <23569.973832900@kao2.melbourne.sgi.com> <3A0C2D4A.83C75D4B@mvista.com> <3A0C90FD.CB645430@uow.edu.au>
Content-Type: multipart/mixed;
 boundary="------------C57DA6ACE5DCFF17B5814DA1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C57DA6ACE5DCFF17B5814DA1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
> George Anzinger wrote:
> >
> > The notion of releasing a spin lock by initializing it seems IMHO, on
> > the face of it, way off.  Firstly the protected area is no longer
> > protected which could lead to undefined errors/ crashes and secondly,
> > any future use of spinlocks to control preemption could have a lot of
> > trouble with this, principally because the locker is unknown.
> >
> > In the case at hand, it would seem that an unlocked path to the console
> > is a more correct answer that gives the system a far better chance of
> > actually remaining viable.
> >
> 
> Does bust_spinlocks() muck up the preemptive kernel's spinlock
> counting?  Would you prefer spin_trylock()/spin_unlock()?
> It doesn't matter - if we call bust_spinlocks() the kernel is
> known to be dead meat and there is a fsck in your near future.

Well, actually this fails just as badly as the locker is not unlocking
and the preemption counts are task local... BUT, see below.
> 
> We are still trying to find out why kumon@fujitsu's 8-way is
> crashing on the test10-pre5 sched.c.  Looks like it's fixed
> in test11-pre2 but we want to know _why_ it's fixed.  And at
> present each time he hits the bug, his printk() deadlocks.
> 
> So bust_spinlocks() is a RAS feature :)  A very important one -
> it's terrible when your one-in-a-trillion bug happens and there
> are no diagnostics.
>
I agree, this is why, in the preemption patch, we have an "unlocked"
printk.  Attached is the relevant portion of the preemption patch for
test9.

I think it still suffers from the console lock, but it is a bit further
down the road.

The patch also illustrates why I am looking for a way to pass var args
to the next function down the line.  If I had this the patch would be
WAY simple and would not duplicate the body of printf.

George
 
> It's a work-in-progress.  There are a lot of things which
> can cause printk to deadlock:
> 
> - console_lock
> - timerlist_lock
> - global_irq_lock (console code does global_cli)
> - log_wait.lock
> - tasklist_lock (printk does wake_up) (*)
> - runqueue_lock (printk does wake_up)
> 
> I'll be proposing a better patch for this in a few days.
> 
> (*) Keith: this explains why you can't do a printk() in
> __wake_up_common: printk calls wake_up().  Duh.
--------------C57DA6ACE5DCFF17B5814DA1
Content-Type: text/plain; charset=iso-8859-15;
 name="printk_unlocked-2.4.0-test9.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printk_unlocked-2.4.0-test9.patch"

diff -urP -X patch.exclude linux-2.4.0-test9-kb-rts/kernel/printk.c linux/kernel/printk.c
--- linux-2.4.0-test9-kb-rts/kernel/printk.c	Wed Jul  5 11:00:21 2000
+++ linux/kernel/printk.c	Thu Nov  2 10:17:20 2000
@@ -312,6 +312,64 @@
 	return i;
 }
 
+#if defined(CONFIG_KGDB) && defined(CONFIG_PREEMPT)
+asmlinkage int printk_unlocked(const char *fmt, ...)
+{
+	va_list args;
+	int i;
+	char *msg, *p, *buf_end;
+	int line_feed;
+	static signed char msg_level = -1;
+
+	va_start(args, fmt);
+	i = vsprintf(buf + 3, fmt, args); /* hopefully i < sizeof(buf)-4 */
+	buf_end = buf + 3 + i;
+	va_end(args);
+	for (p = buf + 3; p < buf_end; p++) {
+		msg = p;
+		if (msg_level < 0) {
+			if (
+				p[0] != '<' ||
+				p[1] < '0' || 
+				p[1] > '7' ||
+				p[2] != '>'
+			) {
+				p -= 3;
+				p[0] = '<';
+				p[1] = default_message_loglevel + '0';
+				p[2] = '>';
+			} else
+				msg += 3;
+			msg_level = p[1] - '0';
+		}
+		line_feed = 0;
+		for (; p < buf_end; p++) {
+			log_buf[(log_start+log_size) & LOG_BUF_MASK] = *p;
+			if (log_size < LOG_BUF_LEN)
+				log_size++;
+			else
+				log_start++;
+
+			logged_chars++;
+			if (*p == '\n') {
+				line_feed = 1;
+				break;
+			}
+		}
+		if (msg_level < console_loglevel && console_drivers) {
+			struct console *c = console_drivers;
+			while(c) {
+				if ((c->flags & CON_ENABLED) && c->write)
+					c->write(c, msg, p - msg + line_feed);
+				c = c->next;
+			}
+		}
+		if (line_feed)
+			msg_level = -1;
+	}
+	return i;
+}
+#endif
 void console_print(const char *s)
 {
 	struct console *c;

--------------C57DA6ACE5DCFF17B5814DA1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
