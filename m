Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280096AbRKEB64>; Sun, 4 Nov 2001 20:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280106AbRKEB6q>; Sun, 4 Nov 2001 20:58:46 -0500
Received: from gear.torque.net ([204.138.244.1]:47879 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S280096AbRKEB6Z>;
	Sun, 4 Nov 2001 20:58:25 -0500
Message-ID: <3BE5F238.6121972C@torque.net>
Date: Sun, 04 Nov 2001 20:58:16 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
I getting repeatable lockups on my SMP box (dual Celeron
Abit hack) after sg does direct IO in this new version.

This sequence using sg_rbuf from my sg3_utils package
(www.torque.net/sg) locks at the end of the transfer
just before returning:
   $ echo 1 > /proc/scsi/sg/allow_dio
   $ sg_rbuf -d -b=512 /dev/sg0
# /dev/sg0 is a fast disk.
# this executes multiple READ BUFFER commands each 512 KB

The box is still usable but the "sg_rbuf" process is
unkillable and ps locks just before it would have 
listed the damaged process. Alt-SysRq-T shows that
the sg_rbuf task in "D" state. The stack backtrace is:
  write_chan
  rwsem_down_write_failed
  ????
  ret_from_fork

This is with sg version 3.2.21 utilising alloc_kiovec_sz()
and friend. I didn't see this "feature" when I tested it
against ac4 before submitting it to you. Changing the "nbhs"
value from 0 to 256 doesn't make any difference. I have
just retested with ac4+sg3.1.21 and it works.

When normal double buffering is used (i.e. no "-d" switch
to the above sg_rbuf) there is no lockup.

Doug Gilbert
