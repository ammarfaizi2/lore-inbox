Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269338AbTCDOwJ>; Tue, 4 Mar 2003 09:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269339AbTCDOwJ>; Tue, 4 Mar 2003 09:52:09 -0500
Received: from smtp-4.hut.fi ([130.233.228.94]:1681 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id <S269338AbTCDOwH>;
	Tue, 4 Mar 2003 09:52:07 -0500
Date: Tue, 4 Mar 2003 17:02:35 +0200 (EET)
From: Dmitrii Tisnek <dima@cc.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: n_r3964 -- ad hoc async io vs. multithreading
Message-ID: <Pine.OSF.4.50.0303041409260.29616-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (smtp-4.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 3964(r) line discipline in one of the projects and I discovered
that it is not well suited for multithreaded programs, basically because:

n_r3964 relies on the pid of the process that initialised the line
discipline on the tty in question.

as a consequence of this, it is not possible to init this ldisc in one
thread and then read/write/etc in the other - fork() never gets to the
line discipline so it cannot know the child pid, and it happily denies
all access by any pid other than it knows (through open).

I'm still looking in the code and I must admit I don't have full
understanding of the reasons behind using the pid. So far I figured out
that this line discipline offers such an api to the programmer that
several processes could open the same tty (say serial port) initialise
3964(r) line discipline thereon and register different callbacks.
Thus one process would be a "writer" and another a "reader".
The callbacks available are transmission completed (whether successfully
or not) and frame received (allowing to read the content). The code can
also send a signal to the process(es) with these notifications.

Personally I'd much rather prefer an api that allows use by multithreaded
programs and a driver that doesn't know any pid's for any reason.

I'm sure I can hack it up in such a way that I can use it, no problem
here. Should I, on the other hand, be willing to make it "right", I would
like to know:

1. is there anyone who really know why n_r3964 is coded this way and how
   it handles timeouts?
2. is there a realistic way of providing the current api through something
   like FIOASYNC or some such?
3. is there someone out there but me who should be doing this?

Thanx,
dima
