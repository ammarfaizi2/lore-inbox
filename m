Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283558AbRK3IXd>; Fri, 30 Nov 2001 03:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283556AbRK3IXY>; Fri, 30 Nov 2001 03:23:24 -0500
Received: from [195.66.192.167] ([195.66.192.167]:12816 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S283558AbRK3IXS>; Fri, 30 Nov 2001 03:23:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [BUG] 2.4.16pre1: minix initrd does not work, ext2 does
Date: Fri, 30 Nov 2001 10:21:54 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011127151356.ast@domdv.de> <01112812184503.00924@manta> <01112815415100.00898@manta>
In-Reply-To: <01112815415100.00898@manta>
MIME-Version: 1.0
Message-Id: <01113010215401.00937@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 November 2001 15:41, vda wrote:
> On Wednesday 28 November 2001 12:18, vda wrote:
> > ext2.gz contains gzipped ext2 ramdisk image.
> > minix.gz contains gzipped minix ramdisk image.
> > minix is gunzipped minix.gz.
> >
> > Initrd          2.4.10  2.4.13,2.4.16pre1
> > --------------- ------- -----------------
> > ext2.gz         ok      ok
> > minix.gz        ok      minix fs not detected (bad fs magic)
> > minix           ok      minix magic ok, can't open console and find init
> >
> > (2.4.16pre1 was instrumented to show minix magic etc)
> >
> > As you can see, we have decompression bug: results for
> > compressed and uncompressed minix ramdisks are different.
> > Or maybe kernel corrupts ramdisk image after gunzip.
> > I'm puzzled...
> >
> > Guys, who fiddled with zlib/ramdisk/??? in 2.4.11 - 2.4.13 range?
>
> I narrowed it down to 2.4.10 -> 2.4.12 (2.4.11-dontuse wasn't tested)
> 2.4.10 can boot my minix initrd, 2.4.12 can't.

Well, I'm still can't find out what was broken there...
A couple of negative info: bootloader isn't guilty, 
initrd is NOT corrupted: when 2.4.13 is booted with 'noinitrd', I can dump
initrd 'cat /dev/initrd > file' and it's perfectly mountable via loop device
(good, usable minix fs there). Same with gzipped minix - good fs
after ungzipping. These two even compare ok (no difference).
I presume this means that initrd is not tampered with in RAM.
Something bad must be happening when initrd is copied to ramdisk
or when ramdisk is mounted. Both seem unlikely because
rd.c diff between 2.4.10 and .12 is tiny (see below)
and ramdisk mount is tested from userspace (ok),
but something *must be* broken there or I'm doing something stupid.

My test minix.gz is here (btw: it's unmodified slackware one,
~1.4 meg):
http://port.imtp.ilyichevsk.odessa.ua/linux/vda/minix.gz

I'll be glad if anyone will try to reproduce initrd problem
with 2.4.x, x>=12 with this image.

Andreas, can you give me your image for testing?
--
vda

diff -u --recursive linux-2.4.10/drivers/block/rd.c 
linux-2.4.12/drivers/block/rd.c
--- linux-2.4.10/drivers/block/rd.c	Sun Sep 23 14:44:37 2001
+++ linux-2.4.12/drivers/block/rd.c	Mon Oct  8 16:25:14 2001
@@ -276,7 +276,6 @@
 			if (!Page_Uptodate(page)) {
 				memset(kmap(page), 0, PAGE_CACHE_SIZE);
 				kunmap(page);
-				flush_dcache_page(page);
 				SetPageUptodate(page);
 			}

@@ -301,8 +300,11 @@
 		kunmap(page);
 		bh_kunmap(sbh);

-		if (rw != READ)
+		if (rw == READ) {
+			flush_dcache_page(page);
+		} else {
 			SetPageDirty(page);
+		}
 		if (unlock)
 			UnlockPage(page);
 		__free_page(page);
