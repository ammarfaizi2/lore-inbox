Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUIOW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUIOW10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIOW1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:27:00 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:2713 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S267648AbUIOWX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:23:59 -0400
Date: Thu, 16 Sep 2004 00:23:58 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Andrew Schretter <schrett@math.duke.edu>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: vfs bug. was: Re: [NFS] 2.6.8.1 kernel NFS client connectathon failure
Message-ID: <20040915222358.GA23118@janus>
References: <200409152054.i8FKsTNV002355@roma.math.duke.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <200409152054.i8FKsTNV002355@roma.math.duke.edu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 15, 2004 at 04:54:29PM -0400, Andrew Schretter wrote:
> 
> On local disk runs, TEMP/BAR still exists (I don't know why though).  On NFS
> runs, it does not exists.  This breaks connectathon's test.

Client: 2.6.8.1, server: 2.4.27 (serving ext3)
/proc/mounts: rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,udp,lock

Behavior I see is identical to that on a local (ext3) fs on 2.6.8.1 and
also on local ext3 on 2.4.27, namely that TEMP/BAR still exists. This
looks like a long standing kernel bug since the rename(2) seems to
succeed:

(snippet from strace):
write(3, "...", 3)                      = 3
close(3)                                = 0
link("FOO", "TEMP/BAR")                 = 0
rename("TEMP/BAR", "FOO")               = 0
unlink("FOO")                           = 0

output:
ls: FOO: No such file or directory
-rw-r--r--    1 fvm      sec             3 Sep 16 00:21 TEMP/BAR


(CC'ed to lkml)

-- 
Frank

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lnk.c"

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/stat.h>

#ifndef MAXPATHLEN
#define MAXPATHLEN	128
#endif

/* maximum number of chars for the message string */
#define STRCHARS	100

main(int ac, char *av[]) {
	int count, fd, slen, lerr, slerr;
	char *fn;
	struct stat sb;
        char str[255];

        if (mkdir("TEMP", 0755)) {
        	perror("mkdir TEMP");
        	exit(0);
        }
	fd = open("FOO", O_RDWR|O_CREAT, 0666);
	if (fd < 0) {
		perror("creat");
		exit(0);
	}
        sprintf(str, "...");
        slen = strlen(str);
	if (write(fd, str, slen) != slen) {
		perror("write");
		(void) close(fd);
		exit(0);
	}
	if (close(fd)) {
		perror("close");
		exit(0);
	}
	if (lerr = link("FOO", "TEMP/BAR")) {
		if (errno != EOPNOTSUPP) {
			perror("link");
			exit(0);
		}
	} else if (rename("TEMP/BAR", "FOO")) {
		perror("rerename");
		exit(0);
	}
	if (unlink("FOO")) {
		perror("unlink 1");
		exit(0);
	}
        system("ls -l FOO TEMP/BAR");
	exit(errno);
}

--azLHFNyN32YCQGCU--
