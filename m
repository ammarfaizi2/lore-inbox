Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130990AbQLZWSb>; Tue, 26 Dec 2000 17:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbQLZWSL>; Tue, 26 Dec 2000 17:18:11 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:22546 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S130990AbQLZWR7>; Tue, 26 Dec 2000 17:17:59 -0500
Message-ID: <3A4911ED.95A73903@dm.ultramaster.com>
Date: Tue, 26 Dec 2000 16:47:25 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom changes in test13-pre2 slow down cdrom access by 70%
In-Reply-To: <3A43D48D.B1825354@dm.ultramaster.com> <20001223133737.D300@suse.de> <3A4904CA.EA1062AF@dm.ultramaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > The cdrom changes that went into test13-pre2 really kill the performance
> > > of my cdrom.  I'm using cdparanoia to read audio data, and it normally

... cut ...

> Anyway, do you think a 'try to allocate 8, if that fails, try to
> allocate 1' solution would be a simple compromise?  That should be easy
> to do, based on the above code (if kmalloc returns NULL && frames > 1,
> frames = 1, retry...).
> 

Jens, 

Here's a version of the above idea, ontop of the patch you sent.  It's
cut and pasted, but I don't think it's whitespace mangled...  I haven't
actually run with this patch, but it does compile :-)

--- drivers/cdrom//cdrom.c	2000/12/26 17:53:14	1.6.4.2
+++ drivers/cdrom//cdrom.c	2000/12/26 21:39:42
@@ -2004,8 +2004,15 @@
 
 		frames = ra.nframes > 8 ? 8 : ra.nframes;
 
-		if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW * frames,
GFP_KERNEL)) == NULL)
-			return -ENOMEM;
+	retry:
+		if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW * frames,
GFP_KERNEL)) == NULL) {
+			if (frames > 1) {
+				frames = 1;
+				goto retry;
+			} else {
+				return -ENOMEM;
+			}
+		}
 
 		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
 			kfree(cgc.buffer);

David


-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
