Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314239AbSDRFzO>; Thu, 18 Apr 2002 01:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314240AbSDRFzN>; Thu, 18 Apr 2002 01:55:13 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:478 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314239AbSDRFzM>;
	Thu, 18 Apr 2002 01:55:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15550.24352.446276.774799@gargle.gargle.HOWL>
Date: Thu, 18 Apr 2002 15:52:32 +1000
From: Christopher Yeoh <cyeoh@samba.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, paulus@samba.org,
        davidm@hpl.hp.com
Subject: [PATCH] SIGURG incorrectly delivered to process
X-Mailer: VM 7.03 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a process is sent a SIGURG signal and it is blocking SIGURG
signals, when the process subsequently unblocks SIGURG signals it will
be terminated even if it is set to the default action (SIG_DFL) which
is specified by SUSv3 to ignore that signal.

The following patch fixes the problem:

--- linux-2.4.18/arch/i386/kernel/signal.c~	Thu Mar 21 16:04:30 2002
+++ linux-2.4.18/arch/i386/kernel/signal.c	Thu Apr 18 12:19:37 2002
@@ -658,7 +658,7 @@
 				continue;
 
 			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
+			case SIGCONT: case SIGCHLD: case SIGWINCH: case SIGURG:
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:

A quick browse of the other architectures indicates that most (if not
all) of them also need the same fix applied to their arch specific
signal.c files.

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
