Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUEUFbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUEUFbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 01:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265360AbUEUFbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 01:31:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29070 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265214AbUEUFbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 01:31:43 -0400
Message-ID: <40AE3D15.3838AED7@us.ibm.com>
Date: Fri, 21 May 2004 12:32:05 -0500
From: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re:[WTF] CIFS bugs galore
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fs/cifs/dir.c::build_path_from_dentry() goes from dentry to fs root
> counting path length.  Then it does kmalloc().  Then it proceeds
> to build said path in the buffer it had just allocated.
...
> buffer overrun in kernel mode with user-controlled contents"?
Not obvious at first glance that it buffer overruns since as it goes
through each path component the strcpy of the next component won't
happen if namelen is going negative. I agree that the path could end up
invalid due to an overlapping rename request of a longer name e.g. while
this task is waiting for kmalloc to complete.   In CIFS full path names
(not path components relative to an inode or dentry) must be presented
to the server, and the server can not be locked,  so a parent directory
can get renamed from another client while our open is going on too.   I
doubt that I want to lock the client kernel across this common call
(build a full path from the dentry), is there a sem I should be taking
across this (seems impractical to take i_sems for the parents to prevent
rename)?

>While we are at it, what exactly would happen if I do lookup on a\\b?
The server likely will reject that ... so I would expect a path not
found or invalid path error to be returned by the server and the lookup
will fail.

> Speaking of which, what exactly happens if rename() happens between
> the time when we build the pathname and time when we send it to
Path not found (or file not found) error will be returned by the server,
so the open will fail.  This does not automatically invalidate dentries
for the parent directory(ies) - which may have been the thing renamed,
but the dentries (presumably similar to NFS in this respect) will time
out in a short period and revalidate will invalidate them then.

> BTW, what the hell is your ->open() doing checking if ->private_data
>is non-NULL?
I have now removed the check.   This is an unnecessary, but harmless
check now that this function is only used from the vfs_open path (and is
not used to reopen existing files after server failure)

> In cifs_partialpagewrite() you have
I now have fixed that pointer use before pointer check problem.

> if you can read the fragments like
I have a rewrite of that function that is much easier to read and better
structured - the cifs readdir code you is, as you noted, hard to read
and too long.   I have not submitted the change yet, since I first would
like to try experiments with two different approaches to readdir to see
if I want to abandon the approach I am using.    Readdir is very hard to
implement using the CIFS protocol, not just due to the protocols use of
"resume keys" but more importantly because the server can't usually give
me unique inode numbers, and also because there are tradeoffs in whether
to request the minimal amount of information (file name, type) or all
inode information (to improve performance) - and these tradeoffs are
different depending on the protocol dialect negotiated.   In addition
the directory contents can also change in the middle of the search which
can also affect CIFS search resumption..   The NFS approach of having a
private readdir cache (in effect) may be best.

Thanks for pointing these issues out.  CIFS (especially to non-Samba
servers and NAS filers) is hard to map to POSIX semantics.

At the moment I am getting network errors trying to checkin a few of
your suggested changes to the development tree at
bk://cifs.bkbits.net/linux-2.5cifs , but when I get back Saturday will
try again.

