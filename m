Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWCEWkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWCEWkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEWkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:40:51 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:36535 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751902AbWCEWkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:40:51 -0500
Message-ID: <440B68D7.8060106@tlinx.org>
Date: Sun, 05 Mar 2006 14:40:23 -0800
From: Linda Walsh <xfs@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Xfs <linux-xfs@oss.sgi.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: XFS _apparent_ corruption: "DATA POINT" (worked around); 2.6.15.4-biglowmem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.15.4 with the "biglowmem" patch (to allow using last 128M of 1G
address space w/o calling it HIGHMEM, and using a 3+1G memory split.

System has been _stable_: uptime was 20days+11:04.

I tried doing an 'ls' of a directory and my system hung -- no panic, no 
message.
Had been doing compiles/tests on same disk w/no problems (~26G used, 94G 
total,
68G free).

* Rebooted, went back to same dir -- hung again. 
* Rebooted, unmounted partition
  >  xfs_check claimed a journal needed to play.
  *  Remounted partition -- no problem; unmount;
  >  xfs_check -- claimed journal present
  >  xfs_repair -- claimed journal present
 *>  remount & unmount; xfs_repair still sees journal;
   
* xfs_logprint gave:
----
ls ->hang
fs_logprint:
xfs_logprint: /dev/hde1 contains a mounted and writable filesystem
    data device: 0x2101
    log device: 0x2101 daddr: 100663328 length: 95392

Header 0x3ef wanted 0xfeedbabe
**********************************************************************
* ERROR: header cycle=1007        block=38747                        *
**********************************************************************
Bad log record header
--------
* Decide to delete bad log: run xfs_repair -L /dev/hde1 :
   runs completely through: NO ERRORS;
* run xfs_check again (partition is unmounted(!)):
   output: sb_ifree 47759, counted 47758
* mount partition, try to access bad directory:
 > immediate system hang

*   reboot under earlier kernel (2.6.14.4 - vanilla)
*   go to same directory, ls:
  > NO HANG;
*   unmount and respect with xfs_{check,repair}: expect to see no errors
  > WRONG (sorta): both believe there is a log again:
*    xfs_logprint:
------ (slightly different output)
Bad log record header
xfs_logprint:
    data device: 0x2101
    log device: 0x2101 daddr: 156288352 length: 152624

Header 0x84 wanted 0xfeedbabe
**********************************************************************
* ERROR: header cycle=132         block=52801                        *
**********************************************************************
---------
*    This time, I run xfs_repair with -L; remembering "no errors, and not
     wanting to wait through another full "xfs_fsck", I abort after
     it starts (and after -L has removed problem log).
*   I run xfs_check:
  >  no output (no errors found).

*    To try to avoid problem, I copy the troublesome directory to another
directory name and delete the old directory. 
*    run xfs_check:
   >  no output (no error indicated)

=> Problem seems to have been dealt with; this report is meant as a
datapoint in case other problems come in...

-linda

_
_

