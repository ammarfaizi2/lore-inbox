Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130066AbRBVQrk>; Thu, 22 Feb 2001 11:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbRBVQrb>; Thu, 22 Feb 2001 11:47:31 -0500
Received: from m127-mp1-cvx1b.col.ntl.com ([213.104.72.127]:13060 "EHLO
	[213.104.72.127]") by vger.kernel.org with ESMTP id <S130295AbRBVQrT>;
	Thu, 22 Feb 2001 11:47:19 -0500
To: Jens Axboe <axboe@suse.de>
Cc: <Andries.Brouwer@cwi.nl>, <johnsom@orst.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
In-Reply-To: <UTC200102182032.VAA132602.aeb@vlet.cwi.nl>
	<20010218215727.D6593@suse.de>
From: John Fremlin <chief@bandits.org>
Date: 22 Feb 2001 16:46:59 +0000
In-Reply-To: Jens Axboe's message of "Sun, 18 Feb 2001 21:57:27 +0100"
Message-ID: <m2bsru3bss.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

[...]

> > You know all about this stuff, so probably I am mistaken.
> > However, my copy of SFF8020-r2.6 everywhere has
> > "Sense 02 ASC 3A: Medium not present" without giving
> > subcodes to distinguish Tray Open from No Disc.
> > So, it seems to me that drives built to this spec will not have
> > nonzero ASCQ.
> 
> Right, old ATAPI has 3a/02 as the only possible condition, so we
> can't really tell between no disc and tray open. I guess the safest
> is to just keep the old behaviour for !ascq and report open.

Jens, you are maintainer? Could you ask Linus or Alan to revert the
change below?

diff -u --recursive --new-file v2.4.0/linux/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- v2.4.0/linux/drivers/ide/ide-cd.c   Tue Jan  2 16:59:17 2001
+++ linux/drivers/ide/ide-cd.c  Sun Jan 28 13:37:50 2001
@@ -2324,11 +2309,17 @@
                    sense.ascq == 0x04)
                        return CDS_DISC_OK;

+
+               /*
+                * If not using Mt Fuji extended media tray reports,
+                * just return TRAY_OPEN since ATAPI doesn't provide
+                * any other way to detect this...
+                */
                if (sense.sense_key == NOT_READY) {
-                       /* ATAPI doesn't have anything that can help
-                          us decide whether the drive is really
-                          emtpy or the tray is just open. irk. */
-                       return CDS_TRAY_OPEN;
+                       if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))+                               return CDS_NO_DISC;
+                       else
+                               return CDS_TRAY_OPEN;
                }


-- 

	http://www.penguinpowered.com/~vii
