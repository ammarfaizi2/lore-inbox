Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTLZC6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 21:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLZC6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 21:58:01 -0500
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:61374 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S264457AbTLZC5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 21:57:55 -0500
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in reading some files in /proc/PID/
Date: Fri, 26 Dec 2003 11:54:02 +0900
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312261154.02338.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following test program could not detect Bad address
with /proc/<PID>/cmdline, stat, statm, ...

ex.

    # ./a.out /proc/1/stat
    Success: 214 

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
    ret = read(fd, 0, 4*1024); // Bad address
    printf("%s: %d\n", strerror(errno), ret);
}

--- linux-2.4.23/fs/proc/base.c.orig    2003-12-26 11:34:19.000000000 +0900
+++ linux-2.4.23/fs/proc/base.c 2003-12-26 11:34:41.000000000 +0900
@@ -357,7 +357,10 @@ static ssize_t proc_info_read(struct fil
        if (count + *ppos > length)
                count = length - *ppos;
        end = count + *ppos;
-       copy_to_user(buf, (char *) page + *ppos, count);
+       if (copy_to_user(buf, (char *) page + *ppos, count)) {
+               free_page(page);
+               return -EFAULT;
+       }
        *ppos = end;
        free_page(page);
        return count;

