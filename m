Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRJVSdJ>; Mon, 22 Oct 2001 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277572AbRJVSc7>; Mon, 22 Oct 2001 14:32:59 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:46857 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277568AbRJVScv>; Mon, 22 Oct 2001 14:32:51 -0400
Message-ID: <3BD4655E.82ED21CC@zip.com.au>
Date: Mon, 22 Oct 2001 11:28:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcos Dione wrote:
> 
>         Hi. first of all, I'm not suscribed to the mailing list, so cc to
> me in the replies. thanks. and I'm running 2.4.10.
> 
>         what I'm doing is to try to put the disks to sleep at night, or
> when I'm not using the machine. I found what proceses to shutdown, mainly
> those that do things from time to time, like the MTA. then I send a STOP
> signal to kupdated. so far, so good. that works.
> 
>         then I switched to ext3 and kjournald started to appear on the
> processes list. and it commits the transactions very often.

Yes, this is a bit of a problem - it's probably atime updates,
things which write to inodes, etc.  A commit will be forced within
five seconds of this happening.

> I know I can set the commit interval to a high value, but both I don't
> know exactly how, and I think that it's not the solution I need.

That is certainly a simple way of addressing the problem, and
it does work.  You'll need to edit fs/jbd/journal.c and change the `5'
in this line:

        journal->j_commit_interval = (HZ * 5);

to 3600 or whatever.  I'd agree that this user interface could be
improved :)  Probably a field in the journal superblock.

The result of this change is that you could lose up to an hour's work
after a crash rather than up to five seconds worth.  You can manually
force a commit at any time by running /bin/sync.

Probably the best way of addressing all of this is teach ext3 to
look at the kupdate writeback interval from /proc/sys/vm/bdflush.
Users can then set the value in there to, say, one hour and it
should all just work.

 
-
