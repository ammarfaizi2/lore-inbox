Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVEQSMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVEQSMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEQSMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:12:53 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:16838 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261200AbVEQSMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:12:45 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix root hole in pktcdvd
References: <11163046681444@kroah.com> <11163046692974@kroah.com>
	<20050517050025.GP1150@parcelfarce.linux.theplanet.co.uk>
	<20050517055452.GQ1150@parcelfarce.linux.theplanet.co.uk>
From: Peter Osterlund <petero2@telia.com>
Date: 17 May 2005 20:12:18 +0200
In-Reply-To: <20050517055452.GQ1150@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m31x85k9h9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:

> On Tue, May 17, 2005 at 06:00:25AM +0100, Al Viro wrote:
> > Same comment as for previous patch.  I'll take a look at that sucker,
> > it might happen to be OK, seeing that most of the bdev ->ioctl() instances
> > ignore file argument and we might get away with passing odd stuff to
> > anything that could occur here.
> 
> Oh, lovely - pkt_open() opens underlying device, unless we already have our
> device opened.  Guess what happens if you open() with O_RDONLY and
> then - with O_RDWR?

You get I/O errors when you submit write requests, which is definitely
not good. I don't know if it also has security implications.

A check got lost in the char dev control device conversion patch. The
patch below fixes it.

-
If you tried to open a packet device first in read-only mode and then
a second time in read-write mode, the second open succeeded even
though the device was not correctly set up for writing. If you then
tried to write data to the device, the writes would fail with I/O
errors.

This patch prevents that problem by making the second open fail with
-EBUSY.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -puN drivers/block/pktcdvd.c~packet-multi-open-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-multi-open-fix	2005-05-17 19:52:30.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2005-05-17 19:52:30.000000000 +0200
@@ -2025,7 +2025,13 @@ static int pkt_open(struct inode *inode,
 	BUG_ON(pd->refcnt < 0);
 
 	pd->refcnt++;
-	if (pd->refcnt == 1) {
+	if (pd->refcnt > 1) {
+		if ((file->f_mode & FMODE_WRITE) &&
+		    !test_bit(PACKET_WRITABLE, &pd->flags)) {
+			ret = -EBUSY;
+			goto out_dec;
+		}
+	} else {
 		if (pkt_open_dev(pd, file->f_mode & FMODE_WRITE)) {
 			ret = -EIO;
 			goto out_dec;
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
