Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282672AbRK0AVY>; Mon, 26 Nov 2001 19:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282674AbRK0AUZ>; Mon, 26 Nov 2001 19:20:25 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:61948 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282666AbRK0ATr>;
	Mon, 26 Nov 2001 19:19:47 -0500
Date: Mon, 26 Nov 2001 17:18:37 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
Message-ID: <20011126171837.P730@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111231859510.4162-100000@waste.org> <3BFEF71A.F32176FE@zip.com.au>, <3BFEF71A.F32176FE@zip.com.au>; <20011127002525.A2912@pelks01.extern.uni-tuebingen.de> <3C02D2D3.B8BE11A3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C02D2D3.B8BE11A3@zip.com.au>; from akpm@zip.com.au on Mon, Nov 26, 2001 at 03:40:03PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2001  15:40 -0800, Andrew Morton wrote:
> Daniel Kobras wrote:
> > Is there a way to tell which kjournald process is associated to which
> > partition? A fake cmdline, or an fd to the partition's device node that
> > shows up in /proc/<pid>/fd would indeed be quite helpful.
> 
> Andreas has a patch which puts the device major/minor into kjournald's
> process name.

It is in CVS HEAD, but appears not to be in the branches.  It is below.
This should not have a problem with the 16-byte command length, because
kdevname() only returns strings of the form mm:nn, so my system has:


root         8     1  0 08:58 ?        00:00:11 [kjournald-03:07]
root        39     1  0 08:58 ?        00:00:00 [kjournald-03:05]
root        40     1  0 08:58 ?        00:00:00 [kjournald-03:09]
root        41     1  0 08:58 ?        00:00:00 [kjournald-03:0a]
root      1219     1  0 09:23 ?        00:00:02 [kjournald-3a:01]

Which are all within 16 bytes (including NUL), until we get larger
major/minor numbers.

Cheers, Andreas
===========================================================================
diff -u -u -r1.11.2.2 -r1.52
--- fs/jbd/journal.c	2001/11/11 05:11:06	1.11.2.2
+++ fs/jbd/journal.c	2001/11/27 00:10:39	1.52
@@ -210,7 +176,7 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	sprintf(current->comm, "kjournald");
+	sprintf(current->comm, "kjournald-%s", kdevname(journal->j_dev));
 
 	/* Set up an interval timer which can be used to trigger a
 	    commit wakeup after the commit interval expires */
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

