Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSGBO7A>; Tue, 2 Jul 2002 10:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSGBO67>; Tue, 2 Jul 2002 10:58:59 -0400
Received: from pc-62-30-72-191-ed.blueyonder.co.uk ([62.30.72.191]:26242 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316548AbSGBO66>; Tue, 2 Jul 2002 10:58:58 -0400
Date: Tue, 2 Jul 2002 16:01:18 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: broken flock()
Message-ID: <20020702160118.C4711@redhat.com>
References: <3D1C96C3.9000500@blue-labs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D1C96C3.9000500@blue-labs.org>; from david+cert@blue-labs.org on Fri, Jun 28, 2002 at 01:02:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jun 28, 2002 at 01:02:59PM -0400, David Ford wrote:
 
> NOTE: Linux appears to have broken flock() again.  Unless
> 	the bug is fixed before sendmail 8.13 is shipped,
> 	8.13 will change the default locking method to
> 	fcntl() for Linux kernel 2.4 and later.  You may
> 	want to do this in 8.12 by compiling with
> 	-DHASFLOCK=0.  Be sure to update other sendmail
> 	related programs to match locking techniques.
 
> Is it really broken or is sendmail smoking crack like when they said
> that itimers in Linux didn't work?

It really is broken, and sendmail triggers it (at least their
commercial binaries do).  I've already been talking to willy about the
problem.

The trouble is the accounting: if one process opens a fd and then
fork()s, it is possible for the lock to be taken in the parent and
released in the child (or vice versa) --- unless there's an explicit
flock(LOCK_UN), then the lock will be released implicitly when the
last reference to the fd is closed.

When this happens, we get the lock count incremented in one task and
decremented in another.  That can wrap the lock count backwards to -1
(or rather ~0UL), which causes the locks rlimit check to think we've
exceeded the lock quota and new lock requests will fail.  It's easy to
reproduce this: try the attached prog.  It produces an erroneous
ENOLCK due to the bug.

Cheers,
 Stephen

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="locklim.c"

#include <sys/types.h>
#include <sys/wait.h>
#include <sys/file.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>



int lock_file(int fd, int l_options) {

	int ret;
	
	ret = flock(fd, l_options);

	if (ret) 
		perror("flock error");
	return ret;
}

int main() {

	int fd;
	char *filename = "/tmp/lockf1";
	pid_t pid;
	int syncpipe[2];
	char c;

	pipe(syncpipe);
	
	fd = open(filename, O_CREAT | O_RDWR, 0666);
	if(fd < 0) {
		perror("parent could not open file");
		exit(1);
	}

	pid = fork();

	if(pid < 0) {
		perror("fork failed");
		exit(1);
	}
	
	if (pid) {
		lock_file(fd, LOCK_EX);
		if (close(fd))
			perror("parent: error closing file");
		write(syncpipe[1], &c, 1);
	} else {
		/* Wait until the parent has taken the lock */
		read(syncpipe[0], &c, 1);
		
		lock_file(fd, LOCK_UN);
                lock_file(fd, LOCK_EX);
                if(close(fd))
			perror("child: error closing file");
		exit(0);
	}

	wait(NULL);
	return 0;
	
}



--ZGiS0Q5IWpPtfppv--
