Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVHCKHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVHCKHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVHCKHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:07:00 -0400
Received: from piraten.student.lu.se ([130.235.208.46]:38347 "EHLO
	piraten.student.lu.se") by vger.kernel.org with ESMTP
	id S262181AbVHCKF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:05:27 -0400
Date: Wed, 03 Aug 2005 12:05:27 +0200
From: Johan Veenhuizen <veenhuizen@users.sf.net>
Subject: Re: [PATCH 2.6.12.3] Deny chmod in /proc/<pid>/
In-reply-to: <Pine.LNX.4.61.0508030816150.2263@yvahk01.tjqt.qr>
To: Johan Veenhuizen <veenhuizen@users.sourceforge.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <42f096e7.9SOTOrosbBYB6uCh%veenhuizen@users.sf.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: nail 11.24 7/14/05
References: <42efd43d.ijkrXtpGJUM7deW2%veenhuizen@users.sf.net>
 <Pine.LNX.4.61.0508030816150.2263@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >This patch tries to fix the strange behaviour in /proc/<pid>/,
> >where it is currently possible for the owner of a process to
> >temporarily chmod the entries.
>
> I am on 2.6.13-rc3-git5 and I do not see such behavior:
>
> 08:16 spectre:/proc/21345 # chown 1337 smaps
> 08:16 spectre:/proc/21345 # l -n smaps
> -r--r--r--  1 25121 0   0 Aug  3 08:16 smaps
> 08:16 spectre:/proc/21345 #

Did you mean "chmod"?  And I don't even have "smaps".

I tried this on 2.6.13-rc5 to make sure it hasn't been fixed since
2.6.12.3.  Here is a sample session to illustrate the problem:

	$ uname -sr
	Linux 2.6.13-rc5
	$ ./a.out &
	[2] 181
	$ cd /proc/181
	$ ls -l
	total 0
	-r--------   1 jpv      user            0 Aug  3 11:37 auxv
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 cmdline
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:37 cwd -> ...
	-r--------   1 jpv      user            0 Aug  3 11:37 environ
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:37 exe -> ...
	dr-x------   2 jpv      user            0 Aug  3 11:37 fd
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 maps
	-rw-------   1 jpv      user            0 Aug  3 11:37 mem
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 mounts
	-rw-r--r--   1 jpv      user            0 Aug  3 11:37 oom_adj
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 oom_score
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:37 root -> /
	-rw-------   1 jpv      user            0 Aug  3 11:37 seccomp
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 stat
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 statm
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 status
	dr-xr-xr-x   3 jpv      user            0 Aug  3 11:37 task
	-r--r--r--   1 jpv      user            0 Aug  3 11:37 wchan
	$ chmod 7777 auxv cmdline environ fd m* o* s* task wchan
	$ ls -l
	total 0
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 auxv
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 cmdline
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:37 cwd -> ...
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 environ
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:37 exe -> ...
	drwsrwsrwt   2 jpv      user            0 Aug  3 11:37 fd
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 maps
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 mem
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 mounts
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 oom_adj
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 oom_score
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:37 root -> /
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 seccomp
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 stat
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 statm
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 status
	drwsrwsrwt   3 jpv      user            0 Aug  3 11:37 task
	-rwsrwsrwt   1 jpv      user            0 Aug  3 11:37 wchan
	$ eatmem
	malloc: Cannot allocate memory
	$ ls -l
	total 0
	-r--------   1 jpv      user            0 Aug  3 11:44 auxv
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 cmdline
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:44 cwd -> ...
	-r--------   1 jpv      user            0 Aug  3 11:44 environ
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:44 exe -> ...
	dr-x------   2 jpv      user            0 Aug  3 11:44 fd
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 maps
	-rw-------   1 jpv      user            0 Aug  3 11:44 mem
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 mounts
	-rw-r--r--   1 jpv      user            0 Aug  3 11:44 oom_adj
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 oom_score
	lrwxrwxrwx   1 jpv      user            0 Aug  3 11:44 root -> /
	-rw-------   1 jpv      user            0 Aug  3 11:44 seccomp
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 stat
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 statm
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 status
	dr-xr-xr-x   3 jpv      user            0 Aug  3 11:44 task
	-r--r--r--   1 jpv      user            0 Aug  3 11:44 wchan

> Though, chmod /proc/21345 correctly yielded EPERM.

That's because the /proc/<pid> directories are S_IMMUTABLE, so the
problem doesn't arise there.

	Johan Veenhuizen
