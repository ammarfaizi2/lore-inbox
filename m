Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUAGFPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbUAGFPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:15:16 -0500
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:17573 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S266132AbUAGFPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:15:10 -0500
From: Akinobu Mita <mita@miraclelinux.com>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4][RESEND] Bug in reading some files in /proc/<pid>/
Date: Wed, 7 Jan 2004 14:10:22 +0900
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071410.22490.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I found the bug in 2.4. this problem has already been fixed in 2.6.

The following program could not detect Bad address
with /proc/<pid>/cmdline, stat, statm, ...

-----
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char **argv)
{
    int fd, ret;

    fd = open(argv[1], O_RDONLY);
    ret = read(fd, NULL, 4*1024); // Bad address
    printf("%s: %d\n", strerror(errno), ret);
}
-----

For example.

    $ ./a.out a.out
    Bad Address: -1

This result could be expected.
but..

    $ ./a.out /proc/1/stat
    Success: 214 


--- linux-2.4.x/fs/proc/base.c.orig	2003-12-26 11:34:19.000000000 +0900
+++ linux-2.4.x/fs/proc/base.c	2004-01-07 13:32:12.000000000 +0900
@@ -357,8 +357,10 @@ static ssize_t proc_info_read(struct fil
 	if (count + *ppos > length)
 		count = length - *ppos;
 	end = count + *ppos;
-	copy_to_user(buf, (char *) page + *ppos, count);
-	*ppos = end;
+	if (copy_to_user(buf, (char *) page + *ppos, count))
+		count = -EFAULT;
+	else
+		*ppos = end;
 	free_page(page);
 	return count;
 }


