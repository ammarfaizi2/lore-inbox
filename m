Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280116AbRJaJXV>; Wed, 31 Oct 2001 04:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280117AbRJaJXM>; Wed, 31 Oct 2001 04:23:12 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:33295 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S280116AbRJaJW5>; Wed, 31 Oct 2001 04:22:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <wwvg080macs.fsf@rjk.greenend.org.uk>
Date: Wed, 31 Oct 2001 09:23:31 +0000
X-Face: h[Hh-7npe<<b4/eW[]sat,I3O`t8A`(ej.H!F4\8|;ih)`7{@:A~/j1}gTt4e7-n*F?.Rl^
     F<\{jehn7.KrO{!7=:(@J~]<.[{>v9!1<qZY,{EJxg6?Er4Y7Ng2\Ft>Z&W?r\c.!4DXH5PWpga"ha
     +r0NzP?vnz:e/knOY)PI-
X-Boydie: NO
From: Richard Kettlewell <rjk@greenend.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <3BDF45B6.5B7FA397@fc.hp.com>
In-Reply-To: <mailman.1004484541.12716.linux-kernel2news@redhat.com>
	<200110302359.f9UNxht09639@devserv.devel.redhat.com>
	<3BDF45B6.5B7FA397@fc.hp.com>
X-Mailer: VM 6.92 under 21.4 (patch 1) "Copyleft" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz writes:
> Pete Zaitcev wrote:

>> Try "mt fsf" instead dd, see if that helps.
> 
> dd is not guaranteed toposition you beyond the filemark after the
> first record. You have to be positioned beyond the filemark to start
> writing.  Pete's suggestion is a good one. "mt fsf" will position
> the tape beyond the filemark and writing to the tape should work at
> that point.

Thankyou for the suggestions.  However, mt reports that the tape is
positioned beyond the filemark before the failed write.  Using "mt
fsf" doesn't make any difference - the problem still occurs.

    sfere# cat t
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
      mt -f $TAPE status
      tar -c -b 20 -f $TAPE /boot
    done
    sfere# ./t
    + mt -f /dev/nst0 rewind
    + echo 'tape 1'
    + dd conv=sync of=/dev/nst0 bs=512 count=1
    0+1 records in
    1+0 records out
    + mt -f /dev/nst0 rewind
    + dd if=/dev/nst0 of=/dev/null bs=512
    1+0 records in
    1+0 records out
    + date
    Wed Oct 31 09:06:24 GMT 2001
    + mt -f /dev/nst0 status
    drive type = Generic SCSI-2 tape
    drive status = 1191182848
    sense key error = 0
    residue count = 0
    file number = 1
    block number = 0
    Tape block size 512 bytes. Density code 0x47 (unknown).
    Soft error count since last status=0
    General status bits on (81010000):
     EOF ONLINE IM_REP_EN
    + tar -c -b 20 -f /dev/nst0 /boot
    tar: Removing leading `/' from absolute path names in the archive
    + mt -f /dev/nst0 rewind
    + dd if=/dev/nst0 of=/dev/null bs=512
    1+0 records in
    1+0 records out
    + date
    Wed Oct 31 09:06:59 GMT 2001
    + mt -f /dev/nst0 status
    drive type = Generic SCSI-2 tape
    drive status = 1191182848
    sense key error = 0
    residue count = 0
    file number = 1
    block number = 0
    Tape block size 512 bytes. Density code 0x47 (unknown).
    Soft error count since last status=0
    General status bits on (81010000):
     EOF ONLINE IM_REP_EN
    + tar -c -b 20 -f /dev/nst0 /boot
    tar: Removing leading `/' from absolute path names in the archive
    tar: Cannot write to /dev/nst0: I/O error
    tar: Error is not recoverable: exiting now

    sfere# cat ./t
    #! /bin/sh
    set -e
    TAPE=/dev/nst0
    hsize=512

    set -x

    mt -f $TAPE rewind
    echo "tape 1" | dd conv=sync of=$TAPE bs=$hsize count=1

    for x in 1 2 3; do
      mt -f $TAPE rewind
    #  dd if=$TAPE of=/dev/null bs=$hsize
      mt -f $TAPE fsf
      date
      mt -f $TAPE status
      tar -c -b 20 -f $TAPE /boot
    done
    sfere# ./t
    + mt -f /dev/nst0 rewind
    + echo 'tape 1'
    + dd conv=sync of=/dev/nst0 bs=512 count=1
    0+1 records in
    1+0 records out
    + mt -f /dev/nst0 rewind
    + mt -f /dev/nst0 fsf
    + date
    Wed Oct 31 09:14:16 GMT 2001
    + mt -f /dev/nst0 status
    drive type = Generic SCSI-2 tape
    drive status = 1191182848
    sense key error = 0
    residue count = 0
    file number = 1
    block number = 0
    Tape block size 512 bytes. Density code 0x47 (unknown).
    Soft error count since last status=0
    General status bits on (81010000):
     EOF ONLINE IM_REP_EN
    + tar -c -b 20 -f /dev/nst0 /boot
    tar: Removing leading `/' from absolute path names in the archive
    + mt -f /dev/nst0 rewind
    + mt -f /dev/nst0 fsf
    + date
    Wed Oct 31 09:14:52 GMT 2001
    + mt -f /dev/nst0 status
    drive type = Generic SCSI-2 tape
    drive status = 1191182848
    sense key error = 0
    residue count = 0
    file number = 1
    block number = 0
    Tape block size 512 bytes. Density code 0x47 (unknown).
    Soft error count since last status=0
    General status bits on (81010000):
     EOF ONLINE IM_REP_EN
    + tar -c -b 20 -f /dev/nst0 /boot
    tar: Removing leading `/' from absolute path names in the archive
    tar: Cannot write to /dev/nst0: I/O error
    tar: Error is not recoverable: exiting now
    sfere# 

ttfn/rjk
