Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTFDSqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFDSqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:46:23 -0400
Received: from ishtar.tlinx.org ([64.81.58.33]:51383 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S261959AbTFDSqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:46:21 -0400
From: "linda w." <lkml@tlinx.org>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: reading links in proc - permission denied
Date: Wed, 4 Jun 2003 11:59:47 -0700
Message-ID: <000301c32acb$783a7310$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm misunderstanding something about links in proc. 

I thought 'ps', 'top' et al used /proc to display processes, command lines, etc.

Since neither ps nor top are suid root, they are running with my permissions.

However, if I try to do an ls -l on /proc/<number>/exe, I get a

"ls: cannot read symbolic link /proc/16714/exe: Permission denied"

message.

Now the process is owned by 'named', but the entries in diriectory are 
owned by root (is that right?), thus:

# ll /proc/16714 
total 0
dr-xr-xr-x    3 named    named           0 Jun  4 11:39 ./
dr-xr-xr-x   95 root     root            0 May 30 15:38 ../
-r--r--r--    1 root     root            0 Jun  4 11:39 cmdline
-r--r--r--    1 root     root            0 Jun  4 11:39 cpu
lrwxrwxrwx    1 root     root            0 Jun  4 11:39 cwd -> /var/named/
-r--------    1 root     root            0 Jun  4 11:39 environ
lrwxrwxrwx    1 root     root            0 Jun  4 11:39 exe -> /usr/sbin/named*
dr-x------    2 root     root            0 Jun  4 11:39 fd/
-r--r--r--    1 root     root            0 Jun  4 11:39 maps
-rw-------    1 root     root            0 Jun  4 11:39 mem
-r--r--r--    1 root     root            0 Jun  4 11:39 mounts
lrwxrwxrwx    1 root     root            0 Jun  4 11:39 root -> //
-r--r--r--    1 root     root            0 Jun  4 11:39 stat
-r--r--r--    1 root     root            0 Jun  4 11:39 statm
-r--r--r--    1 root     root            0 Jun  4 11:39 status
---
	Purely from a 'cleanliness' standpoint, is the environment owned by
the user-id, or is it a common piece of public, kernel (root) owned data?

	From observation of other /proc entries, it appears that 'named' has
some unique features in that it is started as root, but then reverts to uid/gid named sometime after startup.  Should some (or all) of the UID's
in proc change ownership to the new UID or are they still considered to
be owned by the old UID?  (Would seem a bit inconsistent -- I wonder if
it could be security exploitable?)

	Now, here's the part that is bugging me.  Running as user 'foo',
I can't read that link -- yet the permissions say rxw for group and other.
So why am I getting the permission error?  The binary it is pointing to
/usr/sbin/named is also publicly readable, so that can't be the problem.

	So why can't I follow the link of 'exe' to see what image the process
is executing while programs like 'ps' and 'top' seem to not have this
difficulty?

	I'm sure it's some silly misconfiguration on my part, but I guess I want
to know how I got here.  This isn't my beautiful kernel, it's not my beautiful /proc...(etc...).

	I'm running a xfs-patched kernel, V2.4.20/SMP.

Thanks for any insights...I'm trying to write a simple script looking for
a running process (by looking at what 'exe' is pointing to).  I would 
find it kludgey to achieve the objective by running 'ps' and doing 
appropriate filtering. 

-linda
     

