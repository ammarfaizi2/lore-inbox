Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTBIJSf>; Sun, 9 Feb 2003 04:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbTBIJSf>; Sun, 9 Feb 2003 04:18:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25098 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267187AbTBIJSd>; Sun, 9 Feb 2003 04:18:33 -0500
Date: Sun, 9 Feb 2003 09:28:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roland McGrath <roland@redhat.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@digeo.com>, arjanv@redhat.com
Subject: Re: heavy handed exit() in latest BK
Message-ID: <20030209092807.A20121@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Roland McGrath <roland@redhat.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
	arjanv@redhat.com
References: <200302090348.h193mcn05216@magilla.sf.frob.com> <Pine.LNX.4.44.0302082049420.4686-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302082049420.4686-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Feb 08, 2003 at 08:51:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2003 at 08:51:05PM -0800, Linus Torvalds wrote:
> On Sat, 8 Feb 2003, Roland McGrath wrote:
> >
> > Here is the patch vs 2.5.59-1.1007 that I am using now.  gdb seems happy.
> > I have not run a lot of other tests yet.
> 
> Looks like kernel threads still go crazy at shutdown. I saw the migration 
> threads apparently hogging the CPU.

I hope you're aware that alt-sysrq-t has been broken for some time?

include/linux/sched.h:

#define TASK_RUNNING            0
#define TASK_INTERRUPTIBLE      1
#define TASK_UNINTERRUPTIBLE    2
#define TASK_STOPPED            4
#define TASK_ZOMBIE             8
#define TASK_DEAD               16

kernel/sched.c:

        static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };

fs/proc/array.c:

static const char *task_state_array[] = {
        "R (running)",          /*  0 */
        "S (sleeping)",         /*  1 */
        "D (disk sleep)",       /*  2 */
        "T (stopped)",          /*  8 */
        "Z (zombie)",           /*  4 */
        "X (dead)"              /* 16 */
};

So, for one more time, here's another mailing of the same patch to fix
this brokenness.  In addition, we fix the wrong comment in fs/proc/array.c

--- orig/kernel/sched.c	Sun Feb  9 09:16:31 2003
+++ linux/kernel/sched.c	Sun Feb  9 09:23:44 2003
@@ -2037,7 +2037,7 @@
 	unsigned long free = 0;
 	task_t *relative;
 	int state;
-	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
+	static const char * stat_nam[] = { "R", "S", "D", "T", "Z", "W" };
 
 	printk("%-13.13s ", p->comm);
 	state = p->state ? __ffs(p->state) + 1 : 0;
--- orig/fs/proc/array.c	Sun Feb  9 09:17:36 2003
+++ linux/fs/proc/array.c	Sun Feb  9 09:26:00 2003
@@ -126,8 +126,8 @@
 	"R (running)",		/*  0 */
 	"S (sleeping)",		/*  1 */
 	"D (disk sleep)",	/*  2 */
-	"T (stopped)",		/*  8 */
-	"Z (zombie)",		/*  4 */
+	"T (stopped)",		/*  4 */
+	"Z (zombie)",		/*  8 */
 	"X (dead)"		/* 16 */
 };
 


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

