Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132146AbRDIAzY>; Sun, 8 Apr 2001 20:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRDIAzO>; Sun, 8 Apr 2001 20:55:14 -0400
Received: from gear.torque.net ([204.138.244.1]:51717 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131348AbRDIAzC>;
	Sun, 8 Apr 2001 20:55:02 -0400
Message-ID: <3AD1084F.A916D361@torque.net>
Date: Sun, 08 Apr 2001 20:54:39 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alex Q Chen <aqchen@us.ibm.com>, linux-scsi@vger.kernel.org
Subject: Re: Zero Copy IO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alex Q Chen" <aqchen@us.ibm.com> wrote:

> I am trying to find a way to pin down user space 
> memory from kernel, so that these user space buffer 
> can be used for direct IO transfer or otherwise 
> known as "zero copying IO".  Searching through the 
> Internet and reading comments on various news groups, 
> it would appear that most developers including Linus 
> himself doesn't believe in the benefit of "zero 
> copying IO".  Most of the discussion however was based 
> on network card drivers.  For certain other drivers 
> such as SCSI Tape driver, which need to handle great 
> deal of data transfer, it would seemed still be more
> advantageous to enable zero copy IO than copy_from_user() 
> and copy_to_user() all the data.  Other OS such as AIX 
> and OS2 have kernel functions that can be used to 
> accomplish such a task.  Has any ground work been done 
> in Linux 2.4 to enable "zero copying IO"?

Alex,
The kiobufs mechanism in the 2.4 series is the appropriate
tool for avoiding copy_from_user() and copy_to_user().
The definitive driver is in drivers/char/raw.c which
does synchronous IO to block devices such as disks
(but is probably not appropriate for tapes).

The SCSI generic (sg) driver supports direct IO. The driver
in lk 2.4.3 has the direct IO code commented out while
a version that I'm currently testing (sg 3.1.18 at
www.torque.net/sg) has its direct IO code activated. I have
a web page comparing throughput times and CPU utilizations
at http://www.torque.net/sg/rbuf_tbl.html . My testing
indicates that the kiobufs mechanism is now working
quite well. For various reasons I still think that it 
is best to default to indirect IO and let speed hungry
users enable dio (which is done in sg via procfs). Even 
when the user selects direct IO is should be possible to
fall back to indirect IO. [Sg does this when a SCSI
adapter can't support direct IO (e.g. an ISA adapter).]

Since the SCSI tape (st) driver is structurally similar 
to sg, it should be possible to add direct IO support 
to st.

One thing to note is that when you let the user provide
the buffer for direct IO (e.g. with malloc) then on
the i386 it won't be contiguous from a bus address POV.
This means large scatter gather lists (typically with
each element 4 KB on i386) which can be time consuming
to load on some SCSI adapters. One way around this would
be for a driver to provide "malloc/free" like ioctls.

Doug Gilbert
