Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSBWXtO>; Sat, 23 Feb 2002 18:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293275AbSBWXtC>; Sat, 23 Feb 2002 18:49:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293274AbSBWXsw>;
	Sat, 23 Feb 2002 18:48:52 -0500
Message-ID: <3C782A00.CBB858EA@zip.com.au>
Date: Sat, 23 Feb 2002 15:47:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Stephen Lord <lord@sgi.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au>,
		<3C781909.F69D8791@zip.com.au> <20020223230755.GO20060@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Sat, Feb 23, 2002 at 02:34:49PM -0800, Andrew Morton wrote:
> > Unfortunately I seem to have found a bug in existing ext2, a bug
> > in existing block_write_full_page, a probable bug in the aic7xxx
> > driver, and an oops in the aic7xxx driver.  So progress has slowed
> > down a bit :(
> 
> Are these bugs in 2.4 also?

The test case is:

- 120 megabyte filesystem, 1k blocksize ext2.  SMP.
- run `dbench 64 2>/dev/null >/dev/null', as root (dunno
  if rootness matters, but it affects ext2 allocation policy).

This really hammers the out-of-space handling.

We get a stream of `__block_prepare_write: zeroing uptodate buffer'
messages.  I added that message.  I shall work out whether there's
a bug, or if the message just gets killed.  This happens in 2.4 also.

We get a handful of `VFS: brelse: Trying to free free buffer' messages,
coming from this code:

        /* Next simple case - plain lookup or failed read of indirect block */
        if (!create || err == -EIO) {
cleanup:
                while (partial > chain) {
                        brelse(partial->bh);
                        partial--;
                }

in ext2_get_block().  This only happens in 2.5.  It happens on uniprocessor.
Possibly a bug introduced by the changed ext2 locking in 2.5.  I have not
investigated further.


With my I/O scheduling changes the SCSI driver gets all upset about
data overruns or such.  This may be my fault.  It's a 2.5 issue.

During recovery from the data overrun, the SCSI driver oopses
over manipulation of a dodgy-looking timer struct.

-
