Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282656AbRKZXlJ>; Mon, 26 Nov 2001 18:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282657AbRKZXlB>; Mon, 26 Nov 2001 18:41:01 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:55044 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282656AbRKZXkx>; Mon, 26 Nov 2001 18:40:53 -0500
Message-ID: <3C02D2D3.B8BE11A3@zip.com.au>
Date: Mon, 26 Nov 2001 15:40:03 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <Pine.LNX.4.40.0111231859510.4162-100000@waste.org> <3BFEF71A.F32176FE@zip.com.au>,
		<3BFEF71A.F32176FE@zip.com.au>; from akpm@zip.com.au on Fri, Nov 23, 2001 at 05:25:46PM -0800 <20011127002525.A2912@pelks01.extern.uni-tuebingen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Kobras wrote:
> 
> On Fri, Nov 23, 2001 at 05:25:46PM -0800, Andrew Morton wrote:
> > Also, if we had appropriate hooks into the request layer, we could detect
> > when the disk was being spun up for a read, and opporunistically flush
> > out any pending writes.
> 
> Actually you can't. SCSI spinup code isn't very useful anyway, and IDE disks
> mostly handle spinup themselves. The kernel has too issue a reset to get a
> disk back alive from sleep mode, but revival from standby doesn't involve
> the kernel at all. When using the disk's internal timer, it isn't involved in
> spindown either. Teaching the request layer about disk state might therefore
> turn out to become rather messy, I suspect.

Much simpler approach:

	if (we're about to read from the disk) {
		if (we have dirty data which is > 10 seconds old) {
			write_it_now();
		}
	}


> > Tell me if this is joyful:
> [...]
> > -     transaction->t_expires = jiffies + journal->j_commit_interval;
> > +     transaction->t_expires = jiffies + dirty_buffer_flush_interval();
> 
> This change doesn't take care of kupdated's most interesting feature, i.e.
> that you can entirely stop it (with a flush interval of zero and/or a
> SIGSTOP).

yup.

> Now, if kjournald honoured SIGSTOP/SIGCONT, I could teach noflushd
> to handle the spindown issue in userland. Uh, at least for one small detail:
> Is there a way to tell which kjournald process is associated to which
> partition? A fake cmdline, or an fd to the partition's device node that
> shows up in /proc/<pid>/fd would indeed be quite helpful.

Andreas has a patch which puts the device major/minor into kjournald's
process name.

Simply setting the journal timer to infinity happens to work out OK.
Commits are triggered by kupdate.

This is because kupdate's superblock writeout runs a commit.  Because
ext3 is unable to distinguish it from a sys_sync().  Sigh.

-
