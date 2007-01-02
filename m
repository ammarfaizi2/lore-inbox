Return-Path: <linux-kernel-owner+w=401wt.eu-S1755216AbXABNu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbXABNu7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbXABNu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:50:58 -0500
Received: from brick.kernel.dk ([62.242.22.158]:16858 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844AbXABNu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:50:57 -0500
Date: Tue, 2 Jan 2007 14:50:53 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cdrom: longer timeout for "Read Track Info" command
Message-ID: <20070102135052.GA2483@kernel.dk>
References: <20070102023623.GA3108@sgi.com> <20070102102829.4117b230@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102102829.4117b230@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2007, Alan wrote:
> On Mon, 1 Jan 2007 18:36:24 -0800
> Jeremy Higdon <jeremy@sgi.com> wrote:
> 
> > I have a DVD combo drive and a CD in which the
> > "READ TRACK INFORMATION" command (implemented in the
> > cdrom_get_track_info() function) takes about 7 seconds to run.
> > The current implementation of cdrom_get_track_info() uses the
> > default timeout of 5 seconds.  So here's a patch that increases
> > the timeout from 5 to 15 seconds.
> > 
> > The drive in question is a TSSTcorpCD/DVDW SN-S082D, and I have
> > a Silicon Image 680A adapter, in case that's of interest.
> > 
> > signed-off-by: <jeremy@sgi.com>
> 
> Please test with a seven second timeout rather than fifteen which is way
> longer than anyone wants to wait. Seven is the magic value used by
> another major vendor so ought to be right for all hardware 8)

Yep, I suspect this patch is long overdue. Jeremy, is this enough to fix
it for you?

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 66d028d..3105ddd 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -337,6 +337,12 @@ static const char *mrw_address_space[] = { "DMA", "GAA" };
 /* used in the audio ioctls */
 #define CHECKAUDIO if ((ret=check_for_audio_disc(cdi, cdo))) return ret
 
+/*
+ * Another popular OS uses 7 seconds as the hard timeout for default
+ * commands, so it is a good choice for us as well.
+ */
+#define CDROM_DEF_TIMEOUT	(7 * HZ)
+
 /* Not-exported routines. */
 static int open_for_data(struct cdrom_device_info * cdi);
 static int check_for_audio_disc(struct cdrom_device_info * cdi,
@@ -1528,7 +1534,7 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
 	cgc->buffer = (char *) buf;
 	cgc->buflen = len;
 	cgc->data_direction = type;
-	cgc->timeout = 5*HZ;
+	cgc->timeout = CDROM_DEF_TIMEOUT;
 }
 
 /* DVD handling */

-- 
Jens Axboe

