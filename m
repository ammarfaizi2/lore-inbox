Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUCSNCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUCSNCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:02:36 -0500
Received: from mail501.nifty.com ([202.248.37.209]:32158 "EHLO
	mail501.nifty.com") by vger.kernel.org with ESMTP id S262876AbUCSNCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:02:33 -0500
To: linux-kernel@vger.kernel.org
Subject: Can I share several chroot'ed directories using 'mount --bind'?
From: Tetsuo Handa <a5497108@anet.ne.jp>
Message-Id: <200403192202.GEE75703.892856B1@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Fri, 19 Mar 2004 22:02:10 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm planning to share several chroot'ed directories
on a single patrtition using 'mount --bind'.
Kernel version is 2.4.25.

Currently I need to use three partitions
( /data /jail/apache/data /jail/tomcat/data ).
But I want to use only one partition, for
adding new /jail/*/data requires fdisk,
which is not acceptable.

The following is the plan ...

Step 1: Mount a partition.

mount -t ext3 /dev/hda1 /.data

Step 2: Create directories under /.data .

perm owner.group   dir
----+-------------+-----------------------
0000 root.root     /.data
0700 root.root       /.data/lost+found
0755 root.root       /.data/system
0755 root.root         /.data/system/var
1777 root.root         /.data/system/tmp
0755 root.root       /.data/apache
0755 httpd.httpd       /.data/apache/var
1777 root.root         /.data/apache/tmp
0755 tomcat.tomcat   /.data/tomcat
0755 tomcat.tomcat     /.data/tomcat/work
0755 tomcat.tomcat     /.data/tomcat/temp

Step 3: Run 'mount --bind' as shown below.

mount --bind /.data/system /data
mount --bind /.data/apache /jail/apache/data
mount --bind /.data/tomcat /jail/tomcat/data

Step 4: Create symlinks as shown below. (some are ommitted.)

/var -> /data/var/
/tmp -> /data/tmp/
/jail/tomcat/var/tomcat -> /data/var/tomcat/
/jail/apache/tmp -> /data/tmp/
/jail/apache/var -> /data/var/

Step 5: Run Apache (root=/jail/apache)
        and Tomcat (root=/jail/tomcat).

Now, I want to know whether Apache or Tomcat can
reach to / or /.data/system directories by using '..' references.

As far as I tested, the following rule seems to be true.

Let there be two directories /foo1/bar and /foo2/bar
that are bound by 'mount --bind /foo1/bar /foo2/bar'.
'struct dentry' has a pointer to its parent dentry.
When a dentry (allocated by resolving /foo1/bar or /foo2/bar)
resolves '..', it refers to its parent dentry (foo1 xor foo2).
So a dentry resolving '..' never reaches to /foo2
if the dentry was allocated by resolving /foo1/bar .

When the /.data/system and /data are bound,
unless the process (root=/) refers to /.data/system ,
the process can't reache to /.data/system directory.
Therefore, the process (root=/) can't access to /.data/system/../tomcat
(i.e. /.data/tomcat) by refering to /data/../tomcat .
Also, when the /.data/tomcat and /jail/tomcat/data are bound,
the process (root=/jail/tomcat) can't access to /.data/tomcat/../system
(i.e. /.data/system) by refering to /data/../system .

Please tell me the above rule is true or not.

Regards...

                  Tetsuo Handa
