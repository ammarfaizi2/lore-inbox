Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTBILZL>; Sun, 9 Feb 2003 06:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTBILZL>; Sun, 9 Feb 2003 06:25:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16270 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267212AbTBILZJ>;
	Sun, 9 Feb 2003 06:25:09 -0500
Date: Sun, 9 Feb 2003 12:40:32 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302091130.h19BU2107744@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302091236590.4454-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland,

there are two bugs in the signal code still:

 - a read_lock(&tasklist_lock) is missing around the group_send_sig_info()
   in send_sig_info().

 - session-IDs and group-IDs are set outside the tasklist lock. This
   causes breakage in the USB code. The correct fix is to do this:

void __set_special_pids(pid_t session, pid_t pgrp)
{
        struct task_struct *curr = current;

        if (curr->session != session) {
                detach_pid(curr, PIDTYPE_SID);
                curr->session = session;
                attach_pid(curr, PIDTYPE_SID, session);
        }
        if (curr->pgrp != pgrp) {
                detach_pid(curr, PIDTYPE_PGID);
                curr->pgrp = pgrp;
                attach_pid(curr, PIDTYPE_PGID, pgrp);
        }
}

void set_special_pids(pid_t session, pid_t pgrp)
{
        write_lock_irq(&tasklist_lock);
        __set_special_pids(session, pgrp);
        write_unlock_irq(&tasklist_lock);
}

and then update all places that do:

-	current->session = 1;
-	current->pgrp = 1;

to:

+	set_special_pids(1, 1);

otherwise we change the PIDs without properly rehashing them.

	Ingo

