Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317090AbSEXFw1>; Fri, 24 May 2002 01:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSEXFw0>; Fri, 24 May 2002 01:52:26 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:26591 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317090AbSEXFwZ>;
	Fri, 24 May 2002 01:52:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.54530.985761.952723@gargle.gargle.HOWL>
Date: Fri, 24 May 2002 15:52:02 +1000
From: Christopher Yeoh <cyeoh@samba.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] SUSv2 semctl compliance
X-Mailer: VM 7.05 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The semctl call with SETVAL currently does not set sempid (at the
moment sempid is only set during a successful semop call). An
explanation from Geoff Clare of the Open Group regarding why sempid
should be set during the semctl call:

"The spec isn't very clear, but there is a statement on the semget()
page which I think justifies the assumption made by the test.  It says
that upon creation, the data structure associated with each semaphore
in the set is not initialised, and that the semctl() function with
SETVAL or SETALL can be used to initialise each semaphore.

Therefore semctl() with SETVAL has to set sempid to *something*, and
since sempid contains the "process ID of the last operation", setting
it to anything other than the pid of the calling process would mean
that sempid contained misleading information.  It could be argued that
setting it to zero would not be misleading, but zero cannot be the
process ID of a process, and so is not a valid value for sempid anyway."

The following patch changes semctl so when called with SETVAL
sempid is set to the pid of the calling process:

--- ipc/sem.c.orig	Fri May 24 15:32:44 2002
+++ ipc/sem.c	Fri May 24 15:22:44 2002
@@ -643,6 +643,7 @@
 		for (un = sma->undo; un; un = un->id_next)
 			un->semadj[semnum] = 0;
 		curr->semval = val;
+		curr->sempid = current->pid;
 		sma->sem_ctime = CURRENT_TIME;
 		/* maybe some queued-up processes were waiting for this */
 		update_queue(sma);

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
