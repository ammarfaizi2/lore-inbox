Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTIZWmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTIZWmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:42:21 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:7946 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261684AbTIZWmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:42:19 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: suid bit behaviour modification in 2.6.0-test5
Date: Fri, 26 Sep 2003 23:41:29 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bill davidsen <davidsen@tmr.com>
References: <3F6CF491.9030205@free.fr> <bkpuur$e63$1@gatekeeper.tmr.com> <20030923195449.A1572@pclin040.win.tue.nl>
In-Reply-To: <20030923195449.A1572@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309262341.32000.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 Sep 2003 18:54, Andries Brouwer wrote:
> On Tue, Sep 23, 2003 at 05:12:59PM +0000, bill davidsen wrote:
> > Well, if ls gets that bit as still set, what would happen if someone
> > actually ran the program before the sync was done? COuld the file be
> > modified and then run? Is there a window? Still smells bugish.
>
> I don't know why you people continue the debate - is anything wrong
> with the fix I sent?

This is the fix that went into test5-bk11?  Now that i2c seems to be 
initilising properly again I've been able to test it in bk13.  I get exactly 
the same results as before the patch.  BTW, something I should have mentioned 
before is that this is on an XFS partition.

Just did a slightly different test and got this from it...

$ uname -a
Linux iahastie 2.6.0-test5-bk13-athlon #1 Fri Sep 26 19:26:30 BST 2003 i686 
GNU/Linux
$ touch suid_test
$ ls -l
total 0
-rw-r--r--    1 ianh     ianh            0 Sep 26 23:16 suid_test

# chown root suid_test
# chmod 4775 suid_test

$ ls -l
total 0
-rwsrwxr-x    1 root     ianh            0 Sep 26 23:16 suid_test
$ cp /usr/bin/id suid_test
$ ls -l
total 16
-rwsrwxr-x    1 root     ianh        13880 Sep 26 23:16 suid_test
$ ./suid_test
uid=1000(ianh) gid=1000(ianh) euid=0(root) groups=1000(ianh), ...

Note it *does* come up as euid root.

$ sync
$ ls -l
total 16
-rwxrwxr-x    1 root     ianh        13880 Sep 26 23:16 suid_test
$ ./suid_test
uid=1000(ianh) gid=1000(ianh) groups=1000(ianh), ...

But not after it has been synced.  Odd, but that's how it works.

As I said before it seems to me that this is coming from an old cached version 
of the directory entry.  As such that version will need to be cleared from 
the cache at the same time as updating the s(ug)id data on the file system 
itself.

-- 
Ian.

