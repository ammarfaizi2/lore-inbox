Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbRLFAds>; Wed, 5 Dec 2001 19:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbRLFAdj>; Wed, 5 Dec 2001 19:33:39 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:2579 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S284899AbRLFAd2>; Wed, 5 Dec 2001 19:33:28 -0500
From: Peter Benie <pjb1008@myrddin.greenend.org.uk>
Message-ID: <15374.48342.184932.392175@myrddin.sinister.greenend.org.uk>
Date: Thu, 6 Dec 2001 00:33:26 +0000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="L8ZnIE1uso"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2/2.4 write can block in non-blocking write
X-Mailer: VM 6.97 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--L8ZnIE1uso
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

This mail contains four parts.
Part 1 - (This part) Description of the bug
Part 2 - Demonstrates the bug
Part 3 - Patch for 2.2 series kernels
Part 4 - Patch for 2.4 series kernels

When writing to a tty device, a process can block in write(2) even if
the file descriptor is non-blocking. Not many processes rely on
non-blocking writes to terminal devices, however, one process that
does is 'wall'. The bug typically manifests itself as delayed
messages.  (When the terminal that caused the blockage is closed, the
wall process continues and notifies users about events that have long
since past.)

The cause is that do_tty_write takes out the atomic_write lock using
down_interruptible. What it should do is to use down_trylock when the 
non-blocking flag is set.

Peter Benie

--L8ZnIE1uso
Content-Type: text/plain
Content-Description: Demonstration of blocking write bug
Content-Disposition: inline;
	filename="testnonblock.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <sys/wait.h>

void die(const char *msg) 
{fprintf(stderr, "%s: %s\n",msg,strerror(errno)); exit(1);}

void timer_expired(int sig) {}

int main(void)
{
	int pty_master_fd, pty_slave_fd1, pty_slave_fd2, i, err;
	const char *slave_name;
	char data[2048];
	pid_t pid;

	/* Open the master and two slaves. Make one slave non-blocking. */
	if ((pty_master_fd=open("/dev/ptmx", O_RDWR))==-1) die("open ptmx");
	if (grantpt(pty_master_fd)) die("grantpt");
	if (unlockpt(pty_master_fd)) die("unlockpt");
	if (!(slave_name=ptsname(pty_master_fd))) die("ptsname");
	if ((pty_slave_fd1=open(slave_name, O_RDWR))==-1) die(slave_name);
	if ((pty_slave_fd2=open(slave_name, O_RDWR))==-1) die(slave_name);
	if (fcntl(pty_slave_fd1, F_SETFL, O_NONBLOCK)==-1) die("fcntl");

	/* Fill the tty buffer until full */
	memset(data, 0, 2048);
	for (i=0; i<10; i++)
	{
		if (write(pty_slave_fd1, data, 2048)==-1) {
			if (errno==EINTR) continue;
			if (errno==EAGAIN) break;
			die("write");
		}
	}

	/* Fork, and do a blocking write in the child */
	if ((pid=fork())==-1) die("fork");
	if (!pid)
	{
		if (write(pty_slave_fd2, data, 2048)==-1)
			die("write");
		_exit(0);
	}
	sleep(1);
	alarm(0);
	signal(SIGALRM, timer_expired);
	alarm(1);
	errno=0;

	/* In the parent, do a non-blocking write while the atomic_write
	   semaphore is held. */
	if (write(pty_slave_fd1, data, 2048)==-1) {
		if (errno!=EINTR && errno!=EAGAIN) die("write");
	}
	err=errno;
	if (kill(pid, SIGTERM)) die("kill");
		
	switch(errno)
	{
	case EAGAIN:
		printf("write failed with EAGAIN. Good.\n");
		return 0;
	case 0:
		printf("write completed sucessfully. "
			"Bug test failed - run program again.\n");
		return 1;
	case EINTR:
		printf("write failed with EINTR.\n"
			"write blocked despite file descriptor being "
			"non-blocking!\n");
		return 2;
	}
	return 1; /* NOTREACHED */
}

--L8ZnIE1uso
Content-Type: text/plain
Content-Description: tty-nonblock-2.2.patch
Content-Disposition: inline;
	filename="tty-nonblock-2.2.patch"
Content-Transfer-Encoding: 7bit

--- 2.2.19/drivers/char/tty_io.c~	Sun Mar 25 17:31:24 2001
+++ 2.2.19/drivers/char/tty_io.c	Mon Dec  3 23:31:43 2001
@@ -667,9 +667,17 @@
 	struct inode *inode = file->f_dentry->d_inode;
 	
 	up(&inode->i_sem);
-	if (down_interruptible(&tty->atomic_write)) {
-		down(&inode->i_sem);
-		return -ERESTARTSYS;
+	if (file->f_flags & O_NONBLOCK) {
+		if (down_trylock(&tty->atomic_write)) {
+			down(&inode->i_sem);
+			return -EAGAIN;
+		}
+	}
+	else {
+		if (down_interruptible(&tty->atomic_write)) {
+			down(&inode->i_sem);
+			return -ERESTARTSYS;
+		}
 	}
 	if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) )
 		written = write(tty, file, buf, count);

--L8ZnIE1uso
Content-Type: text/plain
Content-Description: tty-nonblock-2.4.patch
Content-Disposition: inline;
	filename="tty-nonblock-2.4.patch"
Content-Transfer-Encoding: 7bit

--- 2.4.14/drivers/char/tty_io.c.orig	Thu Dec  6 00:07:23 2001
+++ 2.4.14/drivers/char/tty_io.c	Thu Dec  6 00:09:41 2001
@@ -697,8 +697,13 @@
 {
 	ssize_t ret = 0, written = 0;
 	
-	if (down_interruptible(&tty->atomic_write)) {
-		return -ERESTARTSYS;
+	if (file->f_flags & O_NONBLOCK) {
+		if (down_trylock(&tty->atomic_write))
+			return -EAGAIN;
+	}
+	else {
+		if (down_interruptible(&tty->atomic_write))
+			return -ERESTARTSYS;
 	}
 	if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) ) {
 		lock_kernel();

--L8ZnIE1uso--
