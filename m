Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263138AbREWQEr>; Wed, 23 May 2001 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbREWQEi>; Wed, 23 May 2001 12:04:38 -0400
Received: from shine.micron.net ([204.229.122.198]:29397 "EHLO
	shine.micron.net") by vger.kernel.org with ESMTP id <S263138AbREWQEX>;
	Wed, 23 May 2001 12:04:23 -0400
Date: Wed, 23 May 2001 10:03:59 -0600 (MDT)
From: null <null@null.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bdflush/mm performance drop-out defect (more info)
Message-ID: <Pine.LNX.4.21.0105230927360.32238-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SMTP-HELO: cboi17p51.boi.micron.net
X-SMTP-MAIL-FROM: null@null.com
X-SMTP-PEER-INFO: cboi17p51.boi.micron.net [209.19.158.149]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Jeffrey W. Baker wrote:
> In short, I'm not seeing this problem.

I appreciate your attempt to duplicate the defect on your system.  In my
original post I quoted some conversation between Rick Van Riel and Alan
Cox where they describe seeing the same symptoms under heavy load.  Alan
described it then as a "partial mystery".  Yesterday some others that I
work with confirmed seeing the same defect on their systems.  Their
devices go almost completely idle under heavy I/O load.  What I would like
to do now is somehow attract some visibility to this issue by helping to
find a repeatable test case.

> May I suggest that the problem may be the driver for your SCSI device?

I can't ruled this out yet, but the problem has been confirmed on at least
three different low level SCSI drivers:  qlogicfc, qla2x00, and megaraid.
And I suspect that Alan and Rick were likely using something else when
they saw it.

> I just ran some tests of parallel I/O on a 2 CPU Intel Pentium III 800
> MHz with 2GB main memory

I have a theory that the problem only shows up when there is some pressure
on the buffer cache code.  In one of your tests, you have a system with
2GB of main memory and you write ten 100MB files with dd.  This may not
have begun to stress the buffer cache in a way that exposes the defect.  
If you have the resources, you might try writing larger files with dd.  
Try something which would exceed your 2GB system memory for some period of
time.  Or try lowering the visible system memory (mem=xx).  I should point
out that the most repeatable test case I've found so far is with large
parallel mke2fs processes.  I realize most folks don't have extra disk
space lying around to do the parallel mkfs test, but it's the one I would
recommend at this point.

Using vmstat, you should be able to tell when your cache memory is being
pushed.  Something I noticed while using vmstat is that my system tends to
become completely unresponsive at about the same time as some other
process tries to do a read.  Here's a theory:  the dd and mkfs commands
have a pattern best described as sequencial write, which may be causing
the buffer cache code to settle into some optimization behavior over time,
and when another process attempts to do a read from somewhere not already
cached, it seems to cause severe performance issues backing out of that
optimization.  That's just an idea.

Again, thanks for trying to reproduce this.  Enough people have seen the
symptoms that I'm gaining more confidence that it isn't just my
configuration or something I'm doing wrong.  I just hope that we can
resolve this before 2.4 gets deployed in any kind of intense I/O
environment where it could leave a bad impression.



