Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285098AbRL0Aum>; Wed, 26 Dec 2001 19:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285110AbRL0Auc>; Wed, 26 Dec 2001 19:50:32 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:2312 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S285098AbRL0AuQ>; Wed, 26 Dec 2001 19:50:16 -0500
Date: Wed, 26 Dec 2001 19:50:11 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>
Subject: readdir() loses entries on ramfs and tmpfs
Message-ID: <Pine.LNX.4.43.0112261932350.26802-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got a report that GNU Midnight Commander fails to erase some directories 
on tmpfs from the first attempt.  However, it succeeds the next time.

I could reproduce the problem on 2.4.18-pre1 compiled with gcc-2.96 from
RedHat 7.2.

I have reduced the problem to a simple test.  This script creates 
directories dir, dir/0, ... dir/168

=========================
#!/bin/sh
rm -rf dir
mkdir dir
i=0
while test $i != 169; do
  mkdir dir/$i
  i=$(($i+1))
done
=========================

And this C program tries to remove all subdirectories under "dir":

=========================
#include <stdio.h>
#include <unistd.h>
#include <dirent.h>
int main()
{
    DIR *dir;
    struct dirent *d;
    if (chdir("dir") != 0)
	return 1;
    dir = opendir(".");
    if (!dir)
	return 2;
    while ((d = readdir(dir)) != NULL) {
	printf("%s\n", d->d_name);
	rmdir(d->d_name);
    }
    closedir(dir);
    return 0;
}
=========================

This program succeeds on vfat and ext3 but it fails to remove "dir/0" on 
ramfs and tmpfs.

169 is not a random number.  It's the minimal number required to reproduce 
the problem.  Maybe other systems need another value.

Basically, removing a subdirectory in a directory open with opendir() 
causes an entry (file or directory) 168 entries later to be skipped by 
readdir().

I'm sorry, I cannot elaborate more, but the issue seems to be very 
serious.

-- 
Regards,
Pavel Roskin

