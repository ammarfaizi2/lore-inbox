Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKENCo>; Sun, 5 Nov 2000 08:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbQKENCf>; Sun, 5 Nov 2000 08:02:35 -0500
Received: from mail.SerNet.DE ([193.159.217.66]:55055 "EHLO mail.SerNet.DE")
	by vger.kernel.org with ESMTP id <S129061AbQKENCU>;
	Sun, 5 Nov 2000 08:02:20 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Lutz Pressler <lp@SerNet.DE>
Newsgroups: lists.linux.kernel
Subject: 2.4.(0-test10): /proc security hole
Date: 5 Nov 2000 13:02:14 GMT
Organization: Service Network GmbH, Goettingen, Germany
Message-ID: <8u3lom$5es$1@server1.GoeNet.DE>
NNTP-Posting-Host: otto.sernet.de
X-Trace: server1.GoeNet.DE 973429334 5596 193.159.216.40 (5 Nov 2000 13:02:14 GMT)
X-Complaints-To: news@news.SerNet.DE
NNTP-Posting-Date: 5 Nov 2000 13:02:14 GMT
User-Agent: tin/pre-1.4-19990805 ("Preacher Man") (UNIX) (Linux/2.2.15pre15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I do not think that the following behaviour (2.4.0-test10 on i386, also
tested with 2.4.0-test8) is intended: 

testuser@vax:~ > id
uid=503(testuser) gid=100(users) Gruppen=100(users)
testuser@vax:~ > ls -lad .
drwx------   7 testuser users        4096 Nov  5 13:38 .

testuser@vax:~ > cd dir
testuser@vax:~/dir > ls -la 
insgesamt 16
drwxr-xr-x   3 testuser users        4096 Nov  5 13:39 .
drwx------   7 testuser users        4096 Nov  5 13:38 ..
-rw-r--r--   1 testuser users           7 Nov  5 13:39 file
drwxrwxr-x   2 testuser users        4096 Nov  5 13:39 subdir


Myself (lpressl, uid=500) cannot change into /home/testuser/dir,
as expected:
lpressl@vax:~ > cd ~testuser/dir
bash: cd: /home/testuser/dir: Permission denied

BUT: let testuser be logged in and have a process (bash) with cwd
/home/testuser/dir. Then
lpressl@vax:~ > ps uax |grep testuser
yields
...
testuser   588  0.0  2.1  2256 1360 tty2     S    13:38   0:00 -bash
...

lpressl@vax:~ > cd /proc/588
lpressl@vax:/proc/588 > ls -la
total 0
dr-xr-xr-x   3 testuser users     0 Nov  5 13:49 .
dr-xr-xr-x  59 root     root      0 Nov  5 13:34 ..
-r--r--r--   1 testuser users     0 Nov  5 13:49 cmdline
lrwxrwxrwx   1 testuser users     0 Nov  5 13:49 cwd -> /home/testuser/dir
-r--------   1 testuser users     0 Nov  5 13:49 environ
lrwxrwxrwx   1 testuser users     0 Nov  5 13:49 exe -> /bin/bash
dr-x------   2 testuser users     0 Nov  5 13:49 fd
-r--r--r--   1 testuser users     0 Nov  5 13:49 maps
-rw-------   1 testuser users     0 Nov  5 13:49 mem
lrwxrwxrwx   1 testuser users     0 Nov  5 13:49 root -> /
-r--r--r--   1 testuser users     0 Nov  5 13:49 stat
-r--r--r--   1 testuser users     0 Nov  5 13:49 statm
-r--r--r--   1 testuser users     0 Nov  5 13:49 status

cd cwd shouldn't be possible, should it? But let's see:
lpressl@vax:/proc/588 > cd cwd
lpressl@vax:/proc/588/cwd > 

Oops....

lpressl@vax:/proc/588/cwd > ls -la
total 16
drwxr-xr-x   3 testuser users        4096 Nov  5 13:39 .
drwx------   7 testuser users        4096 Nov  5 13:38 ..
-rw-r--r--   1 testuser users           7 Nov  5 13:39 file
drwxrwxr-x   2 testuser users        4096 Nov  5 13:39 subdir

lpressl@vax:/proc/588/cwd > cat file
secret
lpressl@vax:/proc/588/cwd > cd subdir
lpressl@vax:/proc/588/cwd/subdir > 
lpressl@vax:/proc/588/cwd/subdir > echo ohoh > newfile
lpressl@vax:/proc/588/cwd/subdir > ls -la
total 12
drwxrwxr-x   2 testuser users        4096 Nov  5 13:53 .
drwxr-xr-x   3 testuser users        4096 Nov  5 13:39 ..
-rw-r--r--   1 lpressl  users           5 Nov  5 13:53 newfile


This is bad. 2.2 kernels don't show this behavior. There _any_
/proc/PID/cwd "directory" has no group or world permissions
at all.

I haven't looked at the code at all yet. Anybody with a fix?


Regards,
  Lutz
  


-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
