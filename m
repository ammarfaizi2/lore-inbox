Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTDXLpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDXLpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:45:00 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:10500 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263434AbTDXLo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:44:58 -0400
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16039.53523.533498.354359@chiark.greenend.org.uk>
Date: Thu, 24 Apr 2003 12:57:07 +0100
To: linux-kernel@vger.kernel.org
Subject: rename("a","b") succeeds multiple times race
X-Mailer: VM 7.03 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.2.25 on a dual PIII; I have a program that processes
mail messages which are left in a queue directory as uniquely named
files.  The queue runners each `claim' a message by renaming it away
from the initial filename, so that only one queue runner works on each
message.

However, this does not work because Linux erroneously allows several
processes to simultaneously and `successfully' rename the same file.
The filesystem in question is ext2.

I ran the system under strace, and saw (for example) the following, in
five straces of five different processes:

 02:11:47.293131 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
 02:11:47.354497 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
 02:11:47.412207 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
 02:11:47.414376 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0
 02:11:47.414559 rename("q1988na-000xqY", "proc.1988na-000xqY") = 0

The q... filename was created by Exim 3.35, which did this (for
another message; I can't run the whole of the mail system under
strace):

open("/var/lib/news/mail2news2//temp.2223.chiark.greenend.org.uk", O_WRONLY|O_CREAT, 0660) = 6
[ fiddles with permissions of the file, writes data ]
stat("/var/lib/news/mail2news2//temp.2223.chiark.greenend.org.uk", {st_dev=makedev(8, 2), st_ino=201893, st_mode=S_IFREG|066
0, st_nlink=1, st_uid=9, st_gid=9, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2003/04/23-11:32:14, st_mtime=2003/04/2
3-11:32:14, st_ctime=2003/04/23-11:32:14}) = 0
[...]
close(6)                                = 0
rename("/var/lib/news/mail2news2//temp.2223.chiark.greenend.org.uk", "/var/lib/news/mail2news2//q198HXy-000qWL") = 0

The q... filename is constructed by base-62-encoding the time and the
inode number.

So my questions are:

* Is this a known bug ?  Is it fixed in 2.4 ?

* I can perhaps work around it by having the queue runner rename the
  file to a name which also depends on its own pid, and then check
  that that file exists.  (This will come naturally because it only
  opens the file after renaming it.)  Will this work ?  Will it trash
  my filesystem or my kernel data structures ?

chiark:~> uname -av
Linux chiark 2.2.25 #2 SMP Wed Apr 23 13:05:23 BST 2003 i686 unknown
chiark:~> cat /proc/version
Linux version 2.2.25 (ian@chiark) (gcc version 2.7.2.3) #2 SMP Wed Apr 23 13:05:23 BST 2003
chiark:~>

My kernel is a stock 2.2.25 with patches to:
 * increase NR_TASKS to 2048
 * #define DEBUG 1 in st.c

The distribution is Debian woody; the queue runner software is my own,
written in Perl.

Ian.
