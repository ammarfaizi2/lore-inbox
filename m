Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131651AbQKAWVZ>; Wed, 1 Nov 2000 17:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbQKAWVP>; Wed, 1 Nov 2000 17:21:15 -0500
Received: from azure.humbug.org.au ([203.24.22.40]:8206 "EHLO
	azure.humbug.org.au") by vger.kernel.org with ESMTP
	id <S131651AbQKAWVH>; Wed, 1 Nov 2000 17:21:07 -0500
Date: Thu, 2 Nov 2000 08:20:43 +1000
From: Anthony Towns <aj@azure.humbug.org.au>
Cc: "'Pasi Kärkkäinen'" <pk@edu.joroinen.fi>,
        Rik van Riel <riel@conectiva.com.br>,
        "Forever shall I be." <zinx@microsoftisevil.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 3-order allocation failed
Message-ID: <20001102082043.C22439@azure.humbug.org.au>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBF3@orsmsx31.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBF3@orsmsx31.jf.intel.com>; from randy.dunlap@intel.com on Wed, Nov 01, 2000 at 01:42:17PM -0800
Organisation: Lacking
X-PGP: http://azure.humbug.org.au/~aj/aj_key.asc
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 01:42:17PM -0800, Dunlap, Randy wrote:
> > Is this bug in the usb-driver (usb-uhci), in the camera's driver
> > (cpia_usb) or in the v4l?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Could there be a memory leak as well?  But I expect that
> it's simply that memory is just fragmented so that enough
> contiguous pages aren't available, like Rik said.

There is a memory leak, the memory kmalloc'ed in cpia_usb_open for
sbuf[*].data is never kfree'd (except when an error occurs during
initialisation). Adding some kfree's in cpia_usb_free_resources fixed
the problem in test7 or so, here's a patch against -test10.

--- drivers/media/video/cpia_usb.c.orig	Wed Nov  1 14:14:37 2000
+++ drivers/media/video/cpia_usb.c	Wed Nov  1 14:16:05 2000
@@ -432,10 +432,20 @@
 		ucpia->sbuf[1].urb = NULL;
 	}
 
+	if (ucpia->sbuf[1].data) {
+		kfree(ucpia->sbuf[1].data);
+		ucpia->sbuf[1].data = NULL;
+	}
+ 
 	if (ucpia->sbuf[0].urb) {
 		usb_unlink_urb(ucpia->sbuf[0].urb);
 		usb_free_urb(ucpia->sbuf[0].urb);
 		ucpia->sbuf[0].urb = NULL;
+	}
+
+	if (ucpia->sbuf[0].data) {
+		kfree(ucpia->sbuf[0].data);
+		ucpia->sbuf[0].data = NULL;
 	}
 }

HTH.

Cheers,
aj 

-- 
Anthony Towns <aj@humbug.org.au> <http://azure.humbug.org.au/~aj/>
I don't speak for anyone save myself. GPG signed mail preferred.

  ``We reject: kings, presidents, and voting.
                 We believe in: rough consensus and working code.''
                                      -- Dave Clark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
