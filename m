Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313260AbSD3LzM>; Tue, 30 Apr 2002 07:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313264AbSD3LzL>; Tue, 30 Apr 2002 07:55:11 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:12548 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313260AbSD3LzL>; Tue, 30 Apr 2002 07:55:11 -0400
Message-ID: <20020430115510.26880.qmail@web10404.mail.yahoo.com>
Date: Tue, 30 Apr 2002 04:55:10 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: SMP race condition on startup with patch
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I found a smp race condition on startup
of the 2.4.18 kernel when I put a printk
in schedule.


See the comment below in 
/init/main.c
/*
 * We need to finalize in a non-__init function or
else race conditions
 * between the root thread and the init thread may
cause start_kernel to
 * be reaped by free_initmem before the root thread
has proceeded to
 * cpu_idle.
 */
static void rest_init(void)

Note that init_idle the first thing  called from
cpu_idle.
& it is freed from 
free_initmem in the init function in main.c
which may be called before the cpu
gets into cpu_idle.


Here is the patch.

--- linux.orig/kernel/sched.c   Fri Dec 21 17:42:04
2001
+++ linux/kernel/sched.c        Tue Apr 30 12:22:02
2002
@@ -1299,7 +1299,7 @@

 extern unsigned long wait_init_idle;

-void __init init_idle(void)
+void init_idle(void)
 {
        struct schedule_data * sched_data;
        sched_data =
&aligned_data[smp_processor_id()].schedule_data;


=====
D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie 
Home: +353-22-47196.
Work: +353-91-758353

__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
