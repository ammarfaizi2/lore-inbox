Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270942AbRHNXlM>; Tue, 14 Aug 2001 19:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270943AbRHNXlB>; Tue, 14 Aug 2001 19:41:01 -0400
Received: from rockover.demon.co.uk ([158.152.81.109]:52484 "HELO
	rockover.demon.co.uk") by vger.kernel.org with SMTP
	id <S270942AbRHNXkp>; Tue, 14 Aug 2001 19:40:45 -0400
Date: Wed, 15 Aug 2001 00:40:53 +0100 (BST)
From: Mike Fleetwood <mike@rockover.demon.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: crontab -e scuppered by non-updated mtime.  fstat64() lied!
Message-ID: <Pine.LNX.4.33.0108150035360.1427-100000@rockover.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have found an unexpected behaviour of fstat64() I hope someone here
can explain.  I used crontab -e but after making a change I got the
following error:
    crontab: no changes made to crontab.

The crontab process calls fstat() just before handing a temporary file
to your favourite editor and just after.  It compares the st_mtime
value to see it you made a change and updates your crontab if required.
The problem is I did make a change but crontab didn't see one.  I did
the following:

    strace -v crontab -e 2> /tmp/crontab.strace
    ^Z  (Suspended Vim)
    stat /tmp/crontab.812
    fg
    (Made a change and wrote the file)
    ^Z
    stat /tmp/crontab.812   (mtime had been updated)
    fg
    (Quit Vim)
    crontab: no changes made to crontab.


The strace file showed that fstat64() returned exactly the same data
before and after, seeing no change!

fstat64() now becomes inconsistent, if I change my editor to the
following shell script (/tmp/edit):

    sleep 2
    echo "# edit $$ was here!" >> "$1"

and run it with:

    EDITOR=/tmp/edit strace -v crontab -e 2> /tmp/crontab.strace-2


everything works as expected.  The strace file showed that fstat64()
reported different mtimes and crontab did its job as expected.

I got the same results with kernel 2.4.8 and RedHat patched 2.4.3-12.
All file-systems are ext2.

Can anybody else reproduce this behaviour?
It something broken?

Mike

