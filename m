Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTDUPEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTDUPEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:04:13 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:28153 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP id S261312AbTDUPEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:04:10 -0400
Message-ID: <3EA40B34.E3B91D43@zip.com.au>
Date: Tue, 22 Apr 2003 01:16:04 +1000
From: Darren Tucker <dtucker@zip.com.au>
X-Mailer: Mozilla 4.8 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.0 kernels: bogus cmsg_type returned when passing descriptor
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
2.0 kernels: bogus cmsg_type returned when passing descriptor

[2.] Full description of the problem/report:
I'm trying to nail down some reported OpenSSH bugs on Linux 2.0
kernels.  The one I'm currently looking at relates to the use of
descriptor passing when the UsePrivilegeSeparation feature is enabled in
sshd.  Reported in 2.0.36, observed by me in 2.0.38 and 2.0.40-rc6.

sshd passes a descriptor over a socket pair and checks to make sure the
cmsg_type returned when receiving the descriptor is SCM_RIGHTS.  This is
fine on most platforms but fails on Linux 2.0 kernels, where cmsg_type
(and cmsg_level) contain insane values.

I think this is a kernel bug and I would like to confirm this.  I don't
mind if no-one intends fixing it.

I have subscribed to the list (pending, request forwarded to list
owner).  I would appreciate it if replies were CC'ed.

[3.] Keywords (i.e., modules, networking, kernel):
File descriptor passing, cmsg_type.

[4.] Kernel version (from /proc/version):
Linux version 2.0.38 (root@lollypop) (gcc version 2.7.2.3) #2 Thu Dec 9
04:30:31 PST 1999
also tested 2.0.40-rc6 (the file was patch-2.0.40-rc6.gz, not sure why
this reports -rc5):
Linux version 2.0.40-rc5 (root@wombat) (gcc version 2.7.2.3) #3 Mon Apr
21 23:59:07 EST 2003

[6.] A small shell script or example program which triggers the
     problem (if possible)

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <iovec.h>      /* comment out for 2.4 kernels */

int
main()
{
        int pid, pair[2];
        char tmp[CMSG_SPACE(sizeof(int))];
        struct cmsghdr *cmsg;
        struct msghdr msg;
        struct iovec vec;
        char ch = '\0';

        socketpair(AF_UNIX, SOCK_STREAM, 0, pair);
        memset(&msg, 0, sizeof(msg));
        msg.msg_control = (caddr_t)tmp;
        msg.msg_controllen = CMSG_LEN(sizeof(int));
        cmsg = CMSG_FIRSTHDR(&msg);
        cmsg->cmsg_len = CMSG_LEN(sizeof(int));

        vec.iov_base = &ch;
        vec.iov_len = 1;
        msg.msg_iov = &vec;
        msg.msg_iovlen = 1;

        if (fork() == 0) { /* child, send fd */
                cmsg->cmsg_level = SOL_SOCKET;
                cmsg->cmsg_type = SCM_RIGHTS;
                *(int *)CMSG_DATA(cmsg) = 2; /* send stderr descriptor
*/
                sendmsg(pair[0], &msg, 0);
                exit(0);
        } else { /* parent, receive fd */
                recvmsg(pair[1], &msg, 0);
                if (cmsg->cmsg_type != SCM_RIGHTS)
                        printf("test failed, expected cmsg_type %d got
%d\n",
                            SCM_RIGHTS, cmsg->cmsg_type);
                else
                        printf("test passed, cmsg_type %d\n",
cmsg->cmsg_type);
        }
}

Running this test program on 2.0.38 gives:
$ ./a.out 
test failed, expected type 1 got 1074415852
while 2.0.40-rc6 gives:
$ ./a.out 
test failed, expected type 1 got -1073742828

Running it on 2.4.18 passes.  Running the binary compiled on 2.4 with
gcc-3.2 on a 2.0 machine also fails, so I don't think it's related to
the version of gcc.

Note that the test does not work if optimization is enabled on gcc 2.7.x
(no idea why).

[7.] Environment
Debian slink, GCC 2.7.2.3, binutils 2.9.1.

$ sh ver_linux
Linux wombat 2.0.38 #2 Thu Dec 9 04:30:31 PST 1999 i586 unknown
 
Gnu C                  2.7.2.3
Gnu make               3.77
binutils               2.9.1.0.19
ver_linux: fdformat: command not found
mount                  2.9g
module-init-tools      2.1.121
e2fsprogs              1.12
Linux C Library        2.0.7
ldd: version 1.9.10
Procps                 1.2.9
Net-tools              1.45
Kbd                    0.96
Sh-utils               1.16
Modules Loaded         appletalk ipx nfs serial eepro100

[X.] Other notes, patches, fixes, workarounds:
OpenSSH bug: http://bugzilla.mindrot.org/show_bug.cgi?id=544
Debian bug: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=150976

Thanks for your time.

		-Daz.

-- 
Darren Tucker (dtucker at zip.com.au)
GPG key 8FF4FA69 / D9A3 86E9 7EEE AF4B B2D4  37C9 C982 80C7 8FF4 FA69
    Good judgement comes with experience. Unfortunately, the experience
usually comes from bad judgement.
