Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbUDTJIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUDTJIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDTJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:08:51 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:41109 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262244AbUDTJIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:08:35 -0400
Message-ID: <4084E8DA.D63CCFCE@nospam.org>
Date: Tue, 20 Apr 2004 11:09:46 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Dynamic System Calls & System Call Hijacking - demo user program
Content-Type: multipart/mixed;
 boundary="------------86957F57850745DD87CF1375"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------86957F57850745DD87CF1375
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------86957F57850745DD87CF1375
Content-Type: text/plain; charset=us-ascii;
 name="test.c"
Content-Disposition: inline;
 filename="test.c"
Content-Transfer-Encoding: 7bit

#include <linux/sys.h>		/* For NR_syscalls */
#include <asm/unistd.h>		/* For __NR_ni_syscall */
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <asm/fcntl.h>		/* For O_RDONLY */


#define	MY_SYSCALL	"/proc/sys/kernel/dynamic_syscalls/foo"

/*
 * Read out my actual system call number from "/proc/...".
 *
 * On error "-1" is returned and "errno" is set accordingly.
 */
static inline
get_my_syscall_no(void)
{
	int		fd;
	int		tmp;
	char		buff[5];		/* Should be enough :-) */

	if ((fd = open(MY_SYSCALL, O_RDONLY)) < 0){
		errno = ENOSYS;
		return -1;
	}
	tmp = read(fd, buff, sizeof buff - 1);
	close(fd);
	if (tmp != sizeof buff - 1){
		errno = ENOSYS;
		return -1;
	}
	buff[sizeof buff - 1] = '\0';
	tmp = atoi(buff);
	if (tmp < __NR_ni_syscall || tmp >= __NR_ni_syscall + NR_syscalls){
		errno = ENOSYS;
		return -1;
	}
	return tmp;
}


/*
 * Wrapper function for my system call.
 */
long
my_syscall(const int arg, const long arg2, const long arg3, const int arg4,
							const int arg5)
{
	static int	syscall_no = -1;

	if (syscall_no == -1)
		if ((syscall_no = get_my_syscall_no())== -1)
			return -1;
	return syscall(syscall_no, arg, arg2, arg3, arg4, arg5);
}


main()
{
	if (my_syscall(1, 0, 1, 0, 2) == -1)
		perror("my syscall");
	if (my_syscall(2, 3, 4, 5, 6) == -1)
		perror("my syscall");
}


--------------86957F57850745DD87CF1375--

