Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282151AbRK1Oit>; Wed, 28 Nov 2001 09:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282147AbRK1Oim>; Wed, 28 Nov 2001 09:38:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35344 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282151AbRK1Ohl>;
	Wed, 28 Nov 2001 09:37:41 -0500
Date: Wed, 28 Nov 2001 15:37:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Message-ID: <20011128153718.D23858@suse.de>
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011128145858.A23858@suse.de> <20011128140246.318A01E560@Cantor.suse.de> <20011128150717.C23858@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011128150717.C23858@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 28 2001, Jens Axboe wrote:
> On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Am Mittwoch, 28. November 2001 14:58 schrieben Sie:
> > > On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > >
> > > > Hi Jens,
> > > > your patch doesn't work for ide-scsi
> > > > I get this oops when trying to mount a CD:
> > >
> > > [oops in sr_scatter_pad]
> > >
> > > Hmm ok, and 2.5.1-pre1 works for you right?
> > 
> > Yes it works very well
> 
> Ok, thanks for confirming that. Going to take a look at it now.

Does this work for you? Apply on top of what you already have.

-- 
Jens Axboe


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sr-sg-1

--- /opt/kernel/linux-2.5.1-pre2/drivers/scsi/sr.c	Wed Nov 28 09:13:59 2001
+++ drivers/scsi/sr.c	Wed Nov 28 15:33:25 2001
@@ -326,11 +326,14 @@
 	}
 	if (old_sg) {
 		memcpy(sg + i, old_sg, SCpnt->use_sg * sizeof(struct scatterlist));
-		memcpy(bbpnt + i, old_bbpnt, SCpnt->use_sg * sizeof(void *));
+		if (old_bbpnt)
+			memcpy(bbpnt + i, old_bbpnt, SCpnt->use_sg * sizeof(void *));
 		scsi_free(old_sg, (((SCpnt->use_sg * sizeof(struct scatterlist)) +
 				    (SCpnt->use_sg * sizeof(void *))) + 511) & ~511);
 	} else {
-		sg[i].address = SCpnt->request_buffer;
+		sg[i].address = NULL;
+		sg[i].page = virt_to_page(SCpnt->request_buffer);
+		sg[i].offset = (unsigned long) SCpnt->request_buffer&~PAGE_MASK;
 		sg[i].length = SCpnt->request_bufflen;
 	}
 
@@ -340,7 +343,9 @@
 	SCpnt->use_sg += i;
 
 	if (bsize) {
-		sg[SCpnt->use_sg].address = back;
+		sg[SCpnt->use_sg].address = NULL;
+		sg[SCpnt->use_sg].page = virt_to_page(back);
+		sg[SCpnt->use_sg].offset = (unsigned long) back & ~PAGE_MASK;
 		bbpnt[SCpnt->use_sg] = back;
 		sg[SCpnt->use_sg].length = bsize;
 		SCpnt->use_sg++;

--neYutvxvOLaeuPCA--
