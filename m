Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVJFNqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVJFNqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVJFNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:46:31 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:6122 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1750948AbVJFNqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:46:30 -0400
Subject: select(0,NULL,NULL,NULL,&t1) used for delay
From: "Madhu K.S." <madhu.subbaiah@wipro.com>
Reply-To: madhu.subbaiah@wipro.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Wipro technologies
Message-Id: <1128606546.14385.26.camel@penguin.madhu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 Oct 2005 19:19:06 +0530
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 13:46:27.0439 (UTC) FILETIME=[5963B7F0:01C5CA7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


In many application we use select() system call for delay.

example:
select(0,NULL,NULL,NULL,&t1);


select() for delay is very inefficient. I modified sys_select() code for
efficiency .Here are the changes to fs/select.c.

Please suggest on these changes. 

I know nanosleep() can be used instead of select(), but please suggest
on my changes.


file : fs/select.c
function : sys_select()




                          timeout += sec * (unsigned long) HZ;
                }
        }
-
+
+
        ret = -EINVAL;
        if (n < 0)
                goto out_nofds;
-
+       if ( (n == 0) && (inp == NULL) && (outp == NULL) &&
		(exp==	NULL)){
+                printf("\n I am inside new select condition timeout
			%d\n",timeout);
+                set_current_state(TASK_INTERRUPTIBLE);
+                ret = 0;
+                timeout = schedule_timeout(timeout);
+                if (signal_pending(current))
+                        ret = -ERESTARTNOHAND;
+                if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
+                        time_t sec = 0, usec = 0;
+                        if (timeout) {
+                                sec = timeout / HZ;
+                                usec = timeout % HZ;
+                                usec *= (1000000/HZ);
+                        }
+                        put_user(sec, &tvp->tv_sec);
+                        put_user(usec, &tvp->tv_usec);
+                }
+                current->state = TASK_RUNNING;
+                goto out_nofds;
+        }
+
        /* max_fdset can increase, so grab it once to avoid race */
        max_fdset = current->files->max_fdset;
        if (n > max_fdset)



Thank you very much.
Thanks for your assistances.

Madhu K.S.

