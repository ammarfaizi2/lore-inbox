Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRABVoc>; Tue, 2 Jan 2001 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRABVoW>; Tue, 2 Jan 2001 16:44:22 -0500
Received: from fungus.teststation.com ([212.32.186.211]:33006 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129413AbRABVoI>; Tue, 2 Jan 2001 16:44:08 -0500
Date: Tue, 2 Jan 2001 22:13:25 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Hans-Joachim Baader <hjb@pro-linux.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: Thread problem with smbfs
In-Reply-To: <20001220204151.E4FAE3479B1@grumbeer.hjb.de>
Message-ID: <Pine.LNX.4.21.0101022126540.31967-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Hans-Joachim Baader wrote:

> Then run the program. It should copy the files to the current
> directory. Then run it under gdb. It should hang until you kill
> gdb.

Hello again
(Sorry for the long response time but this really is the busiest time of
 the year, or maybe it's the food and drink that is slowing me down :)

Anyway,
gdb is doing strange things to your testprogram on ext2 as well. Does it
work for you? I have not been able to reproduce a gdb hang (you do know
that there is a while(1); in main ... ;-), but it generates a lot of smbfs
messages and in one case made smbfs stop working.

Your program modified to take path as argument and print a message on
entry/exit of the copy function. Here run with files on ext2.

GNU gdb 5.0
...
(gdb) run tmp
Starting program: /home/puw/src/smbfs/thread-test tmp
[New Thread 1024 (LWP 2456)]
[New Thread 2049 (LWP 2463)]
[New Thread 1026 (LWP 2464)]
copy()  tmp/file1 -> out/file1
copy() -- exit
[New Thread 2051 (LWP 2465)]

Program exited normally.
(gdb) quit

	Hmm, strange. Why does it only copy one file? Looking at the last
	process gives a sleeping process in rt_sigsuspend, like you
	reported in your strace. Am I using gdb incorrectly?

% ps -lw 2465
  F S   UID   PID  PPID  C PRI  NI ADDR    SZ WCHAN  TTY        TIME CMD
040 S   501  2465     1  0  60   0    -  1366 rt_sig pts/3      0:00 /home/puw/src/smbfs/thread-test tmp


The patch below vs 2.2.18 should remove the -512 (-ERESTARTSYS) errors.

But I don't like it at all. It blocks all signals, including SIGKILL, for
a while. The problem is that tcp_recvmsg checks if there is a signal (any
signal) and aborts with -ERESTARTSYS (a comment says it only cares about
SIGURG, maybe that could be changed instead).

Could you test if this fixes the gdb problem? And try gdb with all files
on ext2 too. For me there is no difference between that and smbfs vs a
NT4.

/Urban


--- linux-2.2.18-orig/fs/smbfs/sock.c	Wed Dec 13 21:27:44 2000
+++ linux/fs/smbfs/sock.c	Tue Jan  2 21:19:03 2001
@@ -30,11 +30,13 @@
 
 static int
 _recvfrom(struct socket *socket, unsigned char *ubuf, int size,
-	  unsigned flags)
+	  unsigned rflags)
 {
 	struct iovec iov;
 	struct msghdr msg;
 	struct scm_cookie scm;
+	sigset_t old_set;
+	unsigned long flags;
 
 	msg.msg_name = NULL;
 	msg.msg_namelen = 0;
@@ -43,11 +45,33 @@
 	msg.msg_control = NULL;
 	iov.iov_base = ubuf;
 	iov.iov_len = size;
-	
+
 	memset(&scm, 0,sizeof(scm));
-	size=socket->ops->recvmsg(socket, &msg, size, flags, &scm);
-	if(size>=0)
-		scm_recv(socket,&msg,&scm,flags);
+
+	/*
+	 * block all signals to avoid -ERESTARTSYS problem in recvmsg
+	 *
+	 * FIXME: changing the signal mask is done elsewhere too.
+	 * This code removes the ability to SIGKILL a process that has hung in
+	 * recvmsg (does it? I'm guessing ...).
+	 * Use poll/timeout to ensure progress?
+	 */
+	spin_lock_irqsave(&current->sigmask_lock, flags);
+	old_set = current->blocked;
+	siginitsetinv(&current->blocked, 0);
+	recalc_sigpending(current);
+	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+
+	size = socket->ops->recvmsg(socket, &msg, size, rflags, &scm);
+	if (size >= 0)
+		scm_recv(socket, &msg, &scm, rflags);
+
+	/* restore old signal mask */
+	spin_lock_irqsave(&current->sigmask_lock, flags);
+	current->blocked = old_set;
+	recalc_sigpending(current);
+	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+
 	return size;
 }
 
@@ -529,7 +553,7 @@
 				buf_len = server->packet_size;
 			buf_len = smb_round_length(buf_len);
 			if (buf_len > SMB_MAX_PACKET_SIZE)
-				goto out_no_mem;
+				goto out_too_long;
 
 			rcv_buf = smb_vmalloc(buf_len);
 			if (!rcv_buf)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
