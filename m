Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130901AbQLCSJo>; Sun, 3 Dec 2000 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131024AbQLCSJe>; Sun, 3 Dec 2000 13:09:34 -0500
Received: from www1.ExperTeam.de ([195.138.53.252]:21372 "EHLO
	www1.ExperTeam.de") by vger.kernel.org with ESMTP
	id <S130901AbQLCSJ2>; Sun, 3 Dec 2000 13:09:28 -0500
Message-Id: <200012031740.SAA05520@www1.ExperTeam.de>
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
X-Face: "7u#"=sUEnmXhasPDW#QwNqMOaW5JQ2,rqy\Yt"a1yk9LI640Mv9g!TLQpp/tatO@T`=S:S
 xuqEDD30%F#fw>|!oX?g24"P/fr%)/]LhB~9++.hNy]}X/@q(XPGn:~p[q:n_[.B-SE;?J,%gHIq;N
 bl+of~~UF8/A9Jat?P!=Y%Q18tk
Organization: ExperTeam AG
Subject: Bug in implementation of fcntl64 syscall?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Dec 2000 18:34:33 +0100
From: Roderich Schupp <rsch@ExperTeam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to investigate why my apache compiled with
-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 (and glibc 2.2
build against 2.4.0-test10 headers) immediately dies with

[emerg] (11)Resource temporarily unavailable: fcntl: 
F_SETLKW: Error getting accept lock, exiting! 

This happens while trying to get the file lock to serialize accept.
The first child gets the lock, the other should block.
However, fnctl(fd, F_SETLKW, ...) returns with EAGAIN
(which shouldn't be possible, it would be correct for F_SETLK).
Note that for the above compile flags, libc's F_SETLKW is 14 (on i386)
which in the kernel is F_SETLKW64 (kernel's F_SETLKW is 7).
strace shows that the actual system call used by libc is fcntl64. 
For 2.4.0-test11, fs/fcntl.c has the following code:

asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg
)
{       
	...
        switch (cmd) {
                case F_GETLK64:
                        err = fcntl_getlk64(fd, (struct flock64 *) arg);
                        break;
                case F_SETLK64:
                        err = fcntl_setlk64(fd, cmd, (struct flock64 *) arg);
                        break;
                case F_SETLKW64:
                        err = fcntl_setlk64(fd, cmd, (struct flock64 *) arg);
                        break
	...

i.e. fcntl_setlk64() is called with cmd==F_SETLKW64, 
but in fs/locks.c:

int fcntl_setlk64(unsigned int fd, unsigned int cmd, struct flock64 *l)
{
	...
        error = posix_lock_file(filp, file_lock, cmd == F_SETLKW);
                                                        ^^^^^^^^

where the last argumet to posix_lock_file governs 
wait vs. immediate return. 


Cheers, Roderich	





-- 
      "Thou shalt not follow the NULL pointer 
       for chaos and madness await thee at its end."

Roderich Schupp 		mailto:rsch@ExperTeam.de
ExperTeam GmbH			http://www.experteam.de/
Munich, Germany

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
