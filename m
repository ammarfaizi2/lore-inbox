Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282681AbRK0AGb>; Mon, 26 Nov 2001 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282677AbRK0AGX>; Mon, 26 Nov 2001 19:06:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2822 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282681AbRK0AGN>; Mon, 26 Nov 2001 19:06:13 -0500
Date: Mon, 26 Nov 2001 16:03:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
cc: Andrew Morton <akpm@zip.com.au>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <20011127002525.A2912@pelks01.extern.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.10.10111261559020.9508-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Daniel Kobras wrote:

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

No messier than corrupted data --

> > Tell me if this is joyful:
> [...]
> > -	transaction->t_expires = jiffies + journal->j_commit_interval;
> > +	transaction->t_expires = jiffies + dirty_buffer_flush_interval();
> 
> This change doesn't take care of kupdated's most interesting feature, i.e.
> that you can entirely stop it (with a flush interval of zero and/or a
> SIGSTOP). Now, if kjournald honoured SIGSTOP/SIGCONT, I could teach noflushd
> to handle the spindown issue in userland. Uh, at least for one small detail:
> Is there a way to tell which kjournald process is associated to which
> partition? A fake cmdline, or an fd to the partition's device node that
> shows up in /proc/<pid>/fd would indeed be quite helpful.

LOL

The low-level spindles can not walk backwards to find a partition because
of the bogus aliased/virtual LBA(0)s that litter a spindle.  The LBA(0)
count == Number of Partitions + 1;

This is utter crap but it is scheduled to be fixed in 2.5, now that it has
started.

Solution : Do not partition use the entire raw device but that will not
work because of the real LBA 0 -- EEK

Cheers,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

