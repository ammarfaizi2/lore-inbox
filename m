Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291301AbSBSLpg>; Tue, 19 Feb 2002 06:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291305AbSBSLp1>; Tue, 19 Feb 2002 06:45:27 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:6151 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S291301AbSBSLpK>; Tue, 19 Feb 2002 06:45:10 -0500
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: gnome-terminal acts funny in recent 2.5 series
In-Reply-To: <3C719641.3040604@oracle.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 19 Feb 2002 20:44:39 +0900
In-Reply-To: <3C719641.3040604@oracle.com>
Message-ID: <87d6z11ys8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Alessandro Suardi <alessandro.suardi@oracle.com> writes:

> Running Ximian-latest for rh72/i386, latest 2.5 kernels (including
>   2.5.4-pre2, 2.5.4, 2.5.5-pre1).
> 
> Symptom:
>    - clicking on the panel icon for gnome-terminal shows a flicker
>       of the terminal window coming up then the window disappears.
>      No leftover processes.
> 
> What works 100%:
>    - regular xterm in 2.5.x
>    - gnome-terminal in 2.4.x (x in .17, .18-pre9, .18-rc2)
> 
> More info:
>    - doesn't happen 100% of the time, but close
>    - trying to start gnome-terminal either vanilla or with the
>       parameters in the icon from an xterm causes
>        * gnome-terminal window comes up, but no shell prompt; the
>           window *does not* disappear and program is in a CPU loop
>        * program detaches from calling xterm even when '&' is
>           not used
>        * calling xterm's tty is left in a funny state (sometimes
>           stty sane^J is required, sometimes tput reset)
> 
> Any ideas would be quite welcome - I can go back and try and narrow
>   down what kernel breaks gnome-terminal if nothing comes up.

Probably, this problem had occurred in libzvt which gnome-terminal is
using.

libzvt was using file descriptor passing via UNIX domain socket for
pseudo terminal. Then because ->passcred was not initialized in
sock_alloc(), unexpected credential data was passing to libzvt.

The following patch fixed this problem, but I'm not sure.
Could you review the patch? (attached file are test program)

--- socket.c.orig	Mon Feb 11 18:21:59 2002
+++ socket.c	Tue Feb 19 16:20:18 2002
@@ -501,6 +501,8 @@ struct socket *sock_alloc(void)
 	sock->ops = NULL;
 	sock->sk = NULL;
 	sock->file = NULL;
+//	init_waitqueue_head(&sock->wait);	this is needed?
+	sock->passcred = 0;
 
 	sockets_in_use[smp_processor_id()].counter++;
 	return sock;

Regards
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=test.c

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

static void client(int fd)
{
	int send_fd;
	struct msghdr msg;
	struct iovec iov[1];
	char buf[1];
	union {
		struct cmsghdr cm;
		char cntl[CMSG_SPACE(sizeof(int))];
	} cntl_u;
	struct cmsghdr *cmsgptr;

	send_fd = open("/dev/null", O_RDWR);
	
	iov[0].iov_base = buf;
	iov[0].iov_len = 1;
	msg.msg_iov = iov;
	msg.msg_iovlen = 1;
	msg.msg_name = NULL;
	msg.msg_namelen = 0;

	msg.msg_control = cntl_u.cntl;
	msg.msg_controllen = sizeof(cntl_u.cntl);

	cmsgptr = CMSG_FIRSTHDR(&msg);
	cmsgptr->cmsg_len = CMSG_LEN(sizeof(int));
	cmsgptr->cmsg_level = SOL_SOCKET;
	cmsgptr->cmsg_type = SCM_RIGHTS;
	*((int *)CMSG_DATA(cmsgptr)) = send_fd;

	if (sendmsg(fd, &msg, 0) <= 0)
		perror("sendmsg");
}

static void server(int fd)
{
	int recv_fd;
	struct stat statbuf;
	struct msghdr msg;
	struct iovec iov[1];
	char buf[1];
	union {
		struct cmsghdr cm;
		char cntl[CMSG_SPACE(sizeof(int))];
	} cntl_u;
	struct cmsghdr *cmsgptr;

	iov[0].iov_base = buf;
	iov[0].iov_len = 1;
	msg.msg_iov = iov;
	msg.msg_iovlen = 1;
	msg.msg_name = NULL;
	msg.msg_namelen = 0;

	msg.msg_control = cntl_u.cntl;
	msg.msg_controllen = sizeof(cntl_u.cntl);
	
	if (recvmsg(fd, &msg, 0) <= 0) {
		perror("recvmsg");
		exit(1);
	}
	cmsgptr = CMSG_FIRSTHDR(&msg);
	if (cmsgptr == NULL) {
		fprintf(stderr, "no control message\n");
		exit(1);
	}
	if (cmsgptr->cmsg_len != CMSG_LEN(sizeof(int)))
		fprintf(stderr, "bad length: %d\n", cmsgptr->cmsg_len);
	if (cmsgptr->cmsg_level != SOL_SOCKET)
		fprintf(stderr, "not SOL_SOCKET: %d\n", cmsgptr->cmsg_level);
	if (cmsgptr->cmsg_type != SCM_RIGHTS)
		fprintf(stderr, "not SCM_RIGHTS: %d\n", cmsgptr->cmsg_type);
	recv_fd = *((int *)CMSG_DATA(cmsgptr));
	if (fstat(recv_fd, &statbuf) == -1) {
		perror("stat");
		exit(1);
	}

	printf("fd: %d, dev: %llx, mode: %o\n",
	       recv_fd, statbuf.st_rdev, statbuf.st_mode);
}

int main()
{
	pid_t pid;
	int status, fd[2];

	if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd) == -1) {
		perror("socketpair");
		exit(1);
	}

	pid = fork();
	if (pid == -1) {
		perror("fork");
		exit(1);
	}
	if (pid == 0) {
		close(fd[1]);
		client(fd[0]);
		exit(0);
	}

	close(fd[0]);
	if (waitpid(pid, &status, 0) != pid) {
		perror("waitpid");
		exit(1);
	}
	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
		fprintf(stderr, "client abnormal end\n");
		exit(1);
	}

	server(fd[1]);

	return 0;
}

--=-=-=--
