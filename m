Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSIWXIu>; Mon, 23 Sep 2002 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSIWXIu>; Mon, 23 Sep 2002 19:08:50 -0400
Received: from packet.digeo.com ([12.110.80.53]:31635 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261442AbSIWXIr>;
	Mon, 23 Sep 2002 19:08:47 -0400
Message-ID: <3D8FA032.32193956@digeo.com>
Date: Mon, 23 Sep 2002 16:13:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38bk2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Paul Larson <plars@linuxtestproject.org>,
       lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: Bug in last night's bk test
References: <3D8F9047.B464ABD4@digeo.com> from "Andrew Morton" at Sep 23, 2002 02:05:59 PM PST <200209232252.g8NMqN110401@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 23:13:54.0082 (UTC) FILETIME=[E2A86820:01C26356]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> >
> > ...
> > Until that's done you'll need to set BIO_MAX_PAGES to 16 in
> > include/linux/bio.h
> >
> 
> I am little confused here. I thought IPS driver can handle 64K IO.
> Infact, IPS_MAX_SG is set to 17. So it should be able to handle 68K.
> I have been told that it can handle more than that.. but for some
> reason it was set to 17.
> 
> Paul, what kernel are u running ? 2.5.38 ?
> 

Current bitkeeper has 

#define BIO_MAX_PAGES           (256)

That's a megabyte.  It works fine with mpage.c.  But direct-io.c
is still using BIO_MAX_PAGES.  It really is building 1 megabyte
BIOs, which will break just about every device out there.

I think we just ask Linus to do the below until we get it fixed up?


--- 2.5.38-bk2/fs/direct-io.c~direct-io-size	Mon Sep 23 16:12:25 2002
+++ 2.5.38-bk2-akpm/fs/direct-io.c	Mon Sep 23 16:12:47 2002
@@ -26,7 +26,7 @@
  * The largest-sized BIO which this code will assemble, in bytes.  Set this
  * to PAGE_SIZE if your drivers are broken.
  */
-#define DIO_BIO_MAX_SIZE BIO_MAX_SIZE
+#define DIO_BIO_MAX_SIZE (16*1024)
 
 /*
  * How many user pages to map in one call to get_user_pages().  This determines

.
