Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286791AbRL1Iln>; Fri, 28 Dec 2001 03:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286790AbRL1Ild>; Fri, 28 Dec 2001 03:41:33 -0500
Received: from mars.nc.orc.ru ([212.48.128.131]:26116 "HELO mail.orc.ru")
	by vger.kernel.org with SMTP id <S286788AbRL1IlX>;
	Fri, 28 Dec 2001 03:41:23 -0500
From: "Eugene M. Indenbom" <medtekh@orc.ru>
To: <linux-kernel@vger.kernel.org>
Subject: Parent death signal
Date: Fri, 28 Dec 2001 11:51:56 +0300
Message-ID: <NEBBJOAKIMKHBNBOHCHNGEPACBAA.medtekh@orc.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear colleagues,

I have tried to use prctl with PR_SET_PDEATHSIG and figured out that signal
is sent from kernel/exit.c
as user process signal (line #168):

			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);

Please, note "0" as last argument. This means that signal delivery is
affected by permission checking.
Hence roughly speaking, if parent process has different uid than its child
the signal will not be delivered.

This seems to be wrong as:
1) Child requested to receive signal. The signal is not actually sent by
parent process.
2) If we should do permission check it should be done reverse: can child can
send signal to parent?
3) Permission check is not needed at all as child can poll to see whether
its parent is still alive: getppid() > 1. This means that no security
related information is given out by sending this signal unconditionally.
4) pdeath_signal do not survive over fork and exec.

The patch to change the behavior is:

--- linux-2.4.17/kernel/exit.c.pdeath	Fri Dec 28 09:13:32 2001
+++ linux-2.4.17/kernel/exit.c	Fri Dec 28 09:13:54 2001
@@ -165,7 +165,7 @@
 			p->exit_signal = SIGCHLD;
 			p->self_exec_id++;
 			p->p_opptr = child_reaper;
-			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
+			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 1);
 		}
 	}
 	read_unlock(&tasklist_lock);

==================================================

Is it possible to incorporate this change into the next version of kernel?
Any other comments?

Regards, Eugene

PS I am sorry for not being on this mailing list. I do not want to get all
of its heavy traffic. Please, CC reply to me as well.

