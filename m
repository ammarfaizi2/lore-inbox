Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVFWTHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVFWTHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVFWTGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:06:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46230 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262687AbVFWTFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:05:09 -0400
Date: Fri, 24 Jun 2005 00:32:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: syrius.ml@no-log.org
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, bero@arklinux.org, rjw@sisk.pl,
       sharyath@in.ibm.com
Subject: Re: 2.6.12-mm1: BUG() in fd_install, RCU related?
Message-ID: <20050623190218.GA4999@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050621083424.GA2076@elf.ucw.cz> <20050621090721.GA7976@in.ibm.com> <874qbpwbae.873br9wbae@871x6twbae.message.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874qbpwbae.873br9wbae@871x6twbae.message.id>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 01:50:11PM +0200, syrius.ml@no-log.org wrote:
> Dipankar Sarma <dipankar@in.ibm.com> writes:
> 
> > Some things are common - always with fcntl() or fcntl64() and with
> > a daemon. Does your box come up at all ? If so, can you get me an
> > strace on the process that triggers this ? If I can narrow it
> > down to a small testcase, it would be a lot easier. Also, does
> > switching off CONFIG_PREEMPT fix this problem ?
> 
> I haven't read about this thread. I hope u'll find a way to reproduce
> it. here debian/sid i386 (.config sent in an earlier message), it 100%
> reproducible when restarting bind9. (it also happens on its own on
> different occasion)
> 
> 
> then i restart the daemon:
> 
> end of a strace -f /etc/init.d/bind9 start
> 6541  rt_sigaction(SIGPIPE, {0xb7ca2a70, [], 0}, {SIG_IGN}, 8) = 0
> 6541  send(3, "<30>Jun 23 00:51:35 named[6540]:"..., 82, 0) = 82
> 6541  rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
> 6541  socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 10
> 6541  fcntl64(10, F_DUPFD, 20)          = 32
> 6541  close(10)                         = 0
> 6541  fcntl64(32, F_GETFL)              = 0x2 (flags O_RDWR)
> 6541  fcntl64(32, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> 6541  setsockopt(32, SOL_SOCKET, SO_TIMESTAMP, [1], 4) = 0
> 6541  setsockopt(32, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> 6541  bind(32, {sa_family=AF_INET, sin_port=htons(53),
> sin_addr=inet_addr("172.16.254.1")}, 16) = 0
> 6541  socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 10
> 6541  fcntl64(10, F_DUPFD, 20

Aha, this has been extremely helpful. Could you all please try the
following (untested) patch ? This should fix the problem, or
atleast one problem that I can see.

Thanks
Dipankar


locate_fd() may expand fdtable, so the fdtable pointer must be
reloaded after locate_fd().

Signed-of-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 fs/fcntl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/fcntl.c~fix-dupfd-reacquire-fdt fs/fcntl.c
--- linux-2.6.12-mm1-fix/fs/fcntl.c~fix-dupfd-reacquire-fdt	2005-06-25 14:56:58.000000000 +0530
+++ linux-2.6.12-mm1-fix-dipankar/fs/fcntl.c	2005-06-25 14:58:26.000000000 +0530
@@ -118,9 +118,10 @@ static int dupfd(struct file *file, unsi
 	int fd;
 
 	spin_lock(&files->file_lock);
-	fdt = files_fdtable(files);
 	fd = locate_fd(files, file, start);
 	if (fd >= 0) {
+		/* locate_fd() may have expanded fdtable, load the ptr */
+		fdt = files_fdtable(files);
 		FD_SET(fd, fdt->open_fds);
 		FD_CLR(fd, fdt->close_on_exec);
 		spin_unlock(&files->file_lock);

_
