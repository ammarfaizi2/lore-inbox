Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276647AbRJ3XZe>; Tue, 30 Oct 2001 18:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278736AbRJ3XZP>; Tue, 30 Oct 2001 18:25:15 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:26634 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S274806AbRJ3XZN>; Tue, 30 Oct 2001 18:25:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <wwvady8vhfs.fsf@rjk.greenend.org.uk>
Date: Tue, 30 Oct 2001 23:25:43 +0000
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
From: Richard Kettlewell <rjk@greenend.org.uk>
To: linux-kernel@vger.kernel.org
Subject: problem with ide-scsi and IDE tape drive
X-Mailer: VM 6.92 under 21.4 (patch 1) "Copyleft" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Seagate STT20000A IDE tape drive, which I am trying to use
with the ide-scsi driver.  It worked well enough when moving data
around to repartition recently, but I have discovered a repeatable
problem.

If I try and save a tar to the tape twice in succession, rewinding and
reading forward to the same point each time first, the second attempt
fails (details below).

I originally found this under 2.2.19, and upgraded to 2.4.13 to see if
the problem was still there when running more recent code.  It is.

Here is a script which demonstrates the problem for me:

    #! /bin/sh
    set -e
    TAPE=/dev/nst0
    hsize=512

    set -x

    mt -f $TAPE rewind
    echo "tape 1" | dd conv=sync of=$TAPE bs=$hsize count=1

    for x in 1 2 3; do
      mt -f $TAPE rewind
      dd if=$TAPE of=/dev/null bs=$hsize
      date
      tar -c -b 20 -f $TAPE /boot
    done

Here's what the output looks like:

    sfere# ./t
    + mt -f /dev/nst0 rewind
    + dd conv=sync of=/dev/nst0 bs=512 count=1
    + echo 'tape 1'
    0+1 records in
    1+0 records out
    + mt -f /dev/nst0 rewind
    + dd if=/dev/nst0 of=/dev/null bs=512
    1+0 records in
    1+0 records out
    + date
    Tue Oct 30 23:15:01 GMT 2001
    + tar -c -b 20 -f /dev/nst0 /boot
    tar: Removing leading `/' from absolute path names in the archive
    + mt -f /dev/nst0 rewind
    + dd if=/dev/nst0 of=/dev/null bs=512
    1+0 records in
    1+0 records out
    + date
    Tue Oct 30 23:15:36 GMT 2001
    + tar -c -b 20 -f /dev/nst0 /boot
    tar: Removing leading `/' from absolute path names in the archive
    tar: Cannot write to /dev/nst0: I/O error
    tar: Error is not recoverable: exiting now

The behaviour is extremely consistent - the second invocation of tar
always fails.

I rebuilt st.o and ide-scsi.o with the debugging macros enabled.  The
resulting kernel output is 80Kb long, and rather than fill everyone's
inboxes I've put it at:

ftp://ftp.chiark.greenend.org.uk/users/richardk/tapelog.txt

Some possibly-relevant version numbers:

    sfere# uname -a
    Linux sfere 2.4.13 #1 Sun Oct 28 12:13:17 GMT 2001 i586 unknown
    sfere# tar --version
    tar (GNU tar) 1.12

    Copyright (C) 1988, 92, 93, 94, 95, 96, 97 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Written by John Gilmore and Jay Fenlason.
    sfere# mt --version
    GNU mt version 2.4.2

ttfn/rjk
