Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268330AbRGWTIt>; Mon, 23 Jul 2001 15:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268331AbRGWTIk>; Mon, 23 Jul 2001 15:08:40 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:42379 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268330AbRGWTIY>; Mon, 23 Jul 2001 15:08:24 -0400
To: roel@grobbebol.xs4all.nl
Cc: bug-sh-utils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: who command misses tty1..kernel or sh-utils ?
In-Reply-To: <20010719084740.A3717@grobbebol.xs4all.nl>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 23 Jul 2001 15:04:20 -0400
In-Reply-To: "Roeland Th. Jansen"'s message of "Thu, 19 Jul 2001 08:47:40 +0000"
Message-ID: <m2elr7h3gr.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

--=-=-=

>>>>> "Roeland" == Roeland Th Jansen <bengel@grobbebol.xs4all.nl> writes:

 Roeland> who (GNU sh-utils) 2.0 Written by Joseph Arceneaux and David
 Roeland> MacKenzie.
[snip]
 Roeland> who seems to loose interest in the fact that tty1 is also
 Roeland> being used.
[snip]
 Roeland> I have seen this with many, if not all 2.4 kernels. this is
 Roeland> 2.4.6.  tty1 _is_ active :

I have discussed this with Roeland offline and we are both using XFree
4.02.  I start my system with runlevel 3 (and so does Roeland?) and
then we run `startx &'.  It is only after this that the `utmp' file
gets stomped.  I am not quite sure how this could be a kernel problem.
I don't know where the code would be that touches `utmp'.  I have sh-utils
versin 2.0 (freshly compiled) with Linux 2.4.7.  I also wrote this code,

    #include <stdio.h>
    #include <stdlib.h>
    #include <utmp.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <unistd.h>

    int main(int argc, char *argv[])
    {
        int fd;
        struct utmp loginEntry;

        fd = open(_PATH_UTMP,O_RDONLY);
        if(fd >= 0) {
            while(read(fd,&loginEntry,sizeof(loginEntry))) {
                printf("type %d, ", loginEntry.ut_type);
                printf("pid %d, ", loginEntry.ut_pid);
                printf("line %s, ", loginEntry.ut_line);
                printf("id  %s, ", loginEntry.ut_id);
                printf("user %s, ", loginEntry.ut_user);
                printf("host %s\n", loginEntry.ut_host);
            }
            close(fd);
        }
        else {
            printf("Cann't open " _PATH_UTMP);
        }

        return 0;
    }

I have attached the output of this code and my `ps -ef'.  You can see
from the ps output that there is a user logged on tty1.  I use lkml,
but not the sh-utils... feel free to contact me if you wish additional
information.  I always see this after running `X', never before.

regards,
Bill Pringlemeir.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=who.out
Content-Description: who_test output.

type 8, pid 12, line , id  si, user , host 
type 1, pid 20019, line ~, id  ~~, user runlevel, host 
type 8, pid 116, line , id  l3, user , host 
type 8, pid 506, line , id  ud, user , host 
type 8, pid 507, line , id  c2, user , host 
type 8, pid 511, line , id  c3, user , host 
type 8, pid 513, line , id  c4, user , host 
type 8, pid 515, line , id  c5, user , host 
type 8, pid 517, line , id  c6, user , host 
type 8, pid 609, line pts/1, id  1, user bpringle, host :0.0
type 8, pid 610, line pts/2, id  2, user bpringle, host :0.0
type 5, pid 521, line , id  3, user , host 
type 6, pid 522, line tty4, id  4, user LOGIN, host 
type 6, pid 523, line tty5, id  5, user LOGIN, host 
type 6, pid 524, line tty6, id  6, user LOGIN, host 
type 7, pid 1005, line pts/1, id  ts/1bpringle, user bpringle, host work
type 7, pid 1076, line pts/2, id  ts/2bpringle, user bpringle, host work

--=-=-=



--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=ps.out
Content-Description: ps -ef output.

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 06:26 ?        00:00:04 init [3] 
root         2     1  0 06:26 ?        00:00:00 [keventd]
root         3     1 95 06:26 ?        07:57:51 [kapm-idled]
root         4     0  0 06:26 ?        00:00:00 [ksoftirqd_CPU0]
root         5     0  0 06:26 ?        00:00:00 [kswapd]
root         6     0  0 06:26 ?        00:00:00 [kreclaimd]
root         7     0  0 06:26 ?        00:00:00 [bdflush]
root         8     0  0 06:26 ?        00:00:00 [kupdated]
root        11     1  0 06:26 ?        00:00:00 [khubd]
root       133     1  0 06:26 ?        00:00:00 /usr/sbin/apmd -p 10 -w 5 -W
root       228     1  0 06:26 ?        00:00:00 [eth1]
root       289     1  0 06:26 ?        00:00:00 syslogd
root       299     1  0 06:26 ?        00:00:00 klogd
root       314     1  0 06:26 ?        00:00:00 crond
root       329     1  0 06:26 ?        00:00:00 inetd
root       366     1  0 06:26 ?        00:00:00 gpm -t ps/2
root       402     1  0 06:26 ?        00:00:00 /bin/sh /usr/sbin/adsl-connect
root       427   402  0 06:26 ?        00:00:00 /usr/sbin/pppd pty /usr/sbin/ppp
root       428   427  0 06:26 ?        00:00:03 /usr/sbin/pppoe -p /var/run/pppo
root       504     1  0 06:27 ?        00:00:02 /usr/sbin/sshd
root       520     1  0 06:27 tty2     00:00:00 /sbin/mingetty tty2
root       521     1  0 06:27 tty3     00:00:00 /sbin/mingetty tty3
root       522     1  0 06:27 tty4     00:00:00 /sbin/mingetty tty4
root       523     1  0 06:27 tty5     00:00:00 /sbin/mingetty tty5
root       524     1  0 06:27 tty6     00:00:00 /sbin/mingetty tty6
root       563     1  0 07:23 tty1     00:00:00 login -- bpringle     
bpringle   580   563  0 08:05 tty1     00:00:00 -bash
root      1004   504  0 14:08 ?        00:00:01 /usr/sbin/sshd
bpringle  1005  1004  0 14:08 pts/1    00:00:00 -bash
root      1037  1005  0 14:17 pts/1    00:00:00 su
root      1038  1037  0 14:17 pts/1    00:00:00 bash
root      1045  1038  0 14:17 pts/1    00:00:04 emacs utmp
root      1075   504  0 14:25 ?        00:00:00 /usr/sbin/sshd
bpringle  1076  1075  0 14:25 pts/2    00:00:00 /bin/sh
root      1478  1038  0 14:48 pts/1    00:00:00 ps -ef

--=-=-=








--=-=-=--

