Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbSJGSSB>; Mon, 7 Oct 2002 14:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbSJGSSA>; Mon, 7 Oct 2002 14:18:00 -0400
Received: from packet.digeo.com ([12.110.80.53]:51889 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262701AbSJGSR6>;
	Mon, 7 Oct 2002 14:17:58 -0400
Message-ID: <3DA1D121.222DECFC@digeo.com>
Date: Mon, 07 Oct 2002 11:23:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
References: <3DA0854E.CF9080D7@digeo.com> from "Andrew Morton" at Oct 06, 2002 10:47:42 AM PST <200210071745.g97Hjth23332@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 18:23:29.0798 (UTC) FILETIME=[A2C22A60:01C26E2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> ...
> drivers/built-in.o: In function `aic7xxx_biosparam':
> drivers/built-in.o(.text+0xcfc71): undefined reference to `__udivdi3'
> drivers/built-in.o(.text+0xcfca8): undefined reference to `__udivdi3'
> drivers/built-in.o: In function `qla1280_proc_info':
> drivers/built-in.o(.text+0xd0ca0): undefined reference to `get_free_page'
> drivers/built-in.o: In function `qla1280_biosparam':
> drivers/built-in.o(.text+0xd1daa): undefined reference to `__udivdi3'
> drivers/built-in.o(.text+0xd1dce): undefined reference to `__udivdi3'
> make: *** [.tmp_vmlinux] Error 1

For the __udivdi3 thing, the below patch should fix that up.

For the get_free_page thing I need a grep-for-dummies book.  Please
just go into  qla1280_proc_info() and replace get_free_page() with
get_zeroed_page().  I need to do a second round on that patch.



--- 2.5.40/drivers/scsi/aic7xxx_old.c~lbd-fixes-1	Mon Oct  7 11:18:28 2002
+++ 2.5.40-akpm/drivers/scsi/aic7xxx_old.c	Mon Oct  7 11:19:18 2002
@@ -11735,13 +11735,13 @@ aic7xxx_biosparam(Disk *disk, struct blo
   
   heads = 64;
   sectors = 32;
-  cylinders = disk->capacity / (heads * sectors);
+  cylinders = sector_div(disk->capacity, heads * sectors);
 
   if ((p->flags & AHC_EXTEND_TRANS_A) && (cylinders > 1024))
   {
     heads = 255;
     sectors = 63;
-    cylinders = disk->capacity / (heads * sectors);
+    cylinders = sector_div(disk->capacity, heads * sectors);
   }
 
   geom[0] = heads;
--- 2.5.40/drivers/scsi/qla1280.c~lbd-fixes-1	Mon Oct  7 11:19:42 2002
+++ 2.5.40-akpm/drivers/scsi/qla1280.c	Mon Oct  7 11:20:06 2002
@@ -1705,11 +1705,11 @@ qla1280_biosparam(Disk * disk, struct bl
 
 	heads = 64;
 	sectors = 32;
-	cylinders = disk->capacity / (heads * sectors);
+	cylinders = sector_div(disk->capacity, heads * sectors);
 	if (cylinders > 1024) {
 		heads = 255;
 		sectors = 63;
-		cylinders = disk->capacity / (heads * sectors);
+		cylinders = sector_div(disk->capacity, heads * sectors);
 		/* if (cylinders > 1023)
 		   cylinders = 1023; */
 	}

.
