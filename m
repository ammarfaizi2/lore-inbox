Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTLFEs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTLFEs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:48:56 -0500
Received: from web20021.mail.yahoo.com ([216.136.225.12]:42165 "HELO
	web20021.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264887AbTLFEsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:48:53 -0500
Message-ID: <20031206044852.26806.qmail@web20021.mail.yahoo.com>
Date: Fri, 5 Dec 2003 20:48:52 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: [NFS client] NFS locks not released on abnormal process termination
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a up-to-date RH9 (kernel 2.4.20-24.9, nfs utils 1.0.1-3.9) I'm using as
an NFS client (the server is a NetApp), and I'm trying to use advisory locking
of a file.
If the process that locks the file exits normally, the lock is released, and
everything is fine.
However, if the process aborts, the lock is left with no clear way to remove
it.  I must remove the file to get rid of the lock.

Details:
Here is a test case:
int main()
{
  int fd = open("file", O_RDWR);
  if (lockf( fd, F_TLOCK, 0 ) < 0)
....  print error message query owner
  pause();
  close( fd );
}

If I run this, when it gets to the pause(), I can clearly see in /proc/locks
the process owning the lock.
If I then kill -ABRT <pid>, the entry in /proc/locks goes away, but the lock is
not removed from the server.
When I run the program a second time, the lock acquire failes, and it says the
(now defunct) old process still owns the lock.  Since I cannot easily make
another process with the id of the original, I seem to have no way to
explicitly release the lock.

I even ran ethereal to watch which NLM requests were being made.  No unlock
request was ever sent, so I don't think this can be a server issue.

Any ideas?  Is it supposed to work this way?

thanks,
-Kenny


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
