Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUICHvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUICHvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUICHtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:49:51 -0400
Received: from asplinux.ru ([195.133.213.194]:54280 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269339AbUICHtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:49:33 -0400
Message-ID: <413824B9.8080600@sw.ru>
Date: Fri, 03 Sep 2004 12:00:57 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: INIT hangs with tonight BK pull (2.6.9-rc1+)
References: <200409030204.11806.dtor_core@ameritech.net>
In-Reply-To: <200409030204.11806.dtor_core@ameritech.net>
Content-Type: multipart/mixed;
 boundary="------------030601090606070406080409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030601090606070406080409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> After doing BK pull last night INIT gets stuck in do_tty_hangup after
> executing rc.sysinit. Was booting fine with pull from 2 days ago...
> 
> Anyone else seeing this?
> 
> I suspect pidhash patch because it touched tty_io.c, but I have not tried
> reverting it as it is getting too late here... So I apologize in advance
> if I am pointing finger at the innocent ;)

Oops, you are right. These do_each_task_pid()/while_each_task_pid() do 
loop 4ever with 'continue' inside.
Strange, that I haven't faced the problem on my machine before sending 
the patch... :(

Sorry for the inconvinience. Patch is inside.

Kirill

--------------030601090606070406080409
Content-Type: text/plain;
 name="diff-pid-sent2-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-pid-sent2-fix"

--- ./include/linux/pid.h.pid2	2004-09-03 11:52:27.510664040 +0400
+++ ./include/linux/pid.h	2004-09-03 11:40:33.616192496 +0400
@@ -46,10 +46,10 @@ extern void switch_exec_pids(struct task
 		do {
 
 #define while_each_task_pid(who, type, task)				\
-			task = pid_task((task)->pids[type].pid_list.next,\
-						type);			\
-			prefetch((task)->pids[type].pid_list.next);	\
-		} while (hlist_unhashed(&(task)->pids[type].pid_chain));\
+		} while (task = pid_task((task)->pids[type].pid_list.next,\
+						type),			\
+			prefetch((task)->pids[type].pid_list.next),	\
+			hlist_unhashed(&(task)->pids[type].pid_chain));	\
 	}								\
 
 #endif /* _LINUX_PID_H */

--------------030601090606070406080409--

