Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277601AbRJVSr7>; Mon, 22 Oct 2001 14:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277581AbRJVSru>; Mon, 22 Oct 2001 14:47:50 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:26109 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277576AbRJVSrn>; Mon, 22 Oct 2001 14:47:43 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 22 Oct 2001 12:47:51 -0600
To: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
Message-ID: <20011022124751.C5146@turbolinux.com>
Mail-Followup-To: Marcos Dione <mdione@hal.famaf.unc.edu.ar>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 22, 2001  14:29 -0300, Marcos Dione wrote:
> 	Hi. first of all, I'm not suscribed to the mailing list, so cc to
> me in the replies. thanks. and I'm running 2.4.10.

Don't use 2.4.10 Linus kernel with ext3.  It is bad.  Use a newer kernel,
or -ac kernel instead.

> 	then I switched to ext3 and kjournald started to appear on the
> processes list. and it commits the transactions very often. I know I can
> set the commit interval to a high value, but both I don't know exactly
> how, and I think that it's not the solution I need. sending STOP signals
> to kjournald doesn't work, it seems to ignore them. what can I do?

Hmm.  I have a laptop running with all ext3 filesystems, and it has no
problems spinning down the disk.  I have not done anything to increase
the flush interval of kjournald.  It may be that kjournald is writing
to disk because you have things which are trying to write to disk.

> then I send a STOP signal to kupdated

Well, this is a sure sign that you are getting disk write requests.
Note that it is very dangerous to do this.  Instead, you should give it
a long (but finite) interval so that you at least get some data written
to disk instead of none at all.

I have all of the filesystems on my laptop mounted noatime (this breaks
/tmp auto-cleanup, but oh well) and I have moved all of the entries from
/etc/cron.hourly to /etc/cron.daily, as they are not so critical for me.

If you want, you can still increase the kjournald flush interval by editing
fs/jbd/journal.c:journal_init_common().  Granted, this is not elegant, and
it _should_ be configurable somewhere, but it isn't yet.

If you change the commit interval and run in journaled-data mode, and have
a long interval to kupdated, then ext3 _should_ buffer all of your I/O in
memory until the journal is full.  This is much safer than just turning off
kupdated, since you WILL get things written to disk if there have been enough
changes to fill the journal, so you have an upper limit of a few MB of data
that can be lost if it never flushes to disk.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

