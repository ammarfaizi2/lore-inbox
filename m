Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRKZX16>; Mon, 26 Nov 2001 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282652AbRKZX1t>; Mon, 26 Nov 2001 18:27:49 -0500
Received: from mout1.freenet.de ([194.97.50.132]:17843 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S282651AbRKZX1f>;
	Mon, 26 Nov 2001 18:27:35 -0500
Date: Tue, 27 Nov 2001 00:25:25 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
Message-ID: <20011127002525.A2912@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111231859510.4162-100000@waste.org> <3BFEF71A.F32176FE@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <3BFEF71A.F32176FE@zip.com.au>; from akpm@zip.com.au on Fri, Nov 23, 2001 at 05:25:46PM -0800
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 05:25:46PM -0800, Andrew Morton wrote:
> Also, if we had appropriate hooks into the request layer, we could detect
> when the disk was being spun up for a read, and opporunistically flush
> out any pending writes.

Actually you can't. SCSI spinup code isn't very useful anyway, and IDE disks
mostly handle spinup themselves. The kernel has too issue a reset to get a
disk back alive from sleep mode, but revival from standby doesn't involve
the kernel at all. When using the disk's internal timer, it isn't involved in
spindown either. Teaching the request layer about disk state might therefore
turn out to become rather messy, I suspect.


> Tell me if this is joyful:
[...]
> -	transaction->t_expires = jiffies + journal->j_commit_interval;
> +	transaction->t_expires = jiffies + dirty_buffer_flush_interval();

This change doesn't take care of kupdated's most interesting feature, i.e.
that you can entirely stop it (with a flush interval of zero and/or a
SIGSTOP). Now, if kjournald honoured SIGSTOP/SIGCONT, I could teach noflushd
to handle the spindown issue in userland. Uh, at least for one small detail:
Is there a way to tell which kjournald process is associated to which
partition? A fake cmdline, or an fd to the partition's device node that
shows up in /proc/<pid>/fd would indeed be quite helpful.

Regards,

Daniel.

