Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266584AbUGPQ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUGPQ7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 12:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUGPQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 12:59:04 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42699 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266584AbUGPQ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 12:59:00 -0400
Subject: pty master close and SIGHUP
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: aebr@win.tue.nl
Content-Type: text/plain
Organization: 
Message-Id: <1089988282.1231.378.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jul 2004 10:31:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is wrong with the kernel, or maybe with this:
http://www.win.tue.nl/~aeb/linux/lk/lk-12.html#ss10.3.4

As I recall, the SIGHUP is sent by the kernel itself when 
the master is closed or the session leader dies. I think
there is a credentials problem in the kernel now, with the
signal being sent as if the master-side process or session
leader had sent it. I do indeed find a check_kill_permission()
call that ought not be made AFAIK. The TTY code makes an
effort to force the SIGHUP, but this gets ignored. Maybe
some "cleanup" tried to share common code?

Here's an example. First, I start an xterm. Then in that
xterm, I use "su -" to become root and I start "top".
The processes now look like this:

$ ps -p 7204 -t pts/25 -o euid,ruid,tty,sess,pgrp,ppid,pid,tpgid,stat,pcpu,comm
 EUID  RUID TT        SESS  PGRP  PPID   PID TPGID STAT %CPU COMMAND
 1000  1000 ?         7196  7204     1  7204    -1 S     0.0 xterm  
 1000  1000 pts/25    7205  7205  7204  7205  7218 Ss    0.0 bash   
    0     0 pts/25    7205  7213  7205  7213  7218 S     0.0 bash   
    0     0 pts/25    7205  7218  7213  7218  7218 S+    1.3 top

As you can see, the session leader is bash #7204 and top
is the sole process in the foreground process group.

Now I close the xterm. It dies. The session leader also dies.
This should then cause all processes in the foreground process
group to get SIGHUP. If top gets SIGHUP, it shuts down. This
all works great normally, but see what happens when top is
running as root:

$ ps -p 7204 -s 7205 -o euid,ruid,tty,sess,pgrp,ppid,pid,tpgid,stat,pcpu,comm
 EUID  RUID TT        SESS  PGRP  PPID   PID TPGID STAT %CPU COMMAND
    0     0 ?         7205  7213     1  7213    -1 S     0.0 bash
    0     0 ?         7205  7218  7213  7218    -1 R    51.4 top

The SIGHUP is never delivered.

Now I know it isn't really clean to let top spin calling select()
when the tty goes away, but SIGHUP should take care of that.
Where is my SIGHUP?

I recall the rules being even looser traditionally, pretty much
allowing you to send signals (at least some of them) to anything
on your tty or in your session. Was there a SysV/BSD/POSIX
disagreement over this?


