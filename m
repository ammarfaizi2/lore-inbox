Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTAINHc>; Thu, 9 Jan 2003 08:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbTAINHb>; Thu, 9 Jan 2003 08:07:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58580 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266527AbTAINH3>; Thu, 9 Jan 2003 08:07:29 -0500
Date: Thu, 9 Jan 2003 13:15:10 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030109131510.A25566@devserv.devel.redhat.com>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com> <20030109121431.GQ6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030109121431.GQ6626@fs.tum.de>; from bunk@fs.tum.de on Thu, Jan 09, 2003 at 01:14:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 01:14:32PM +0100, Adrian Bunk wrote:
> On Wed, Jan 08, 2003 at 08:39:09PM -0500, Alan Cox wrote:
> >...
> > Linux 2.4.21pre3-ac1
> >...
> > +	IDE Raid support for AMI/SI 'Medley' IDE Raid	(Arjan van de Ven)
> >...
> 
> This causes a compile error if both pdcraid.o and silraid.o are compiled 
> statically into the kernel:


this ought to fix it:
Alan please apply

diff -urN linux-2.4.20/drivers/ide/raid.org/pdcraid.c linux-2.4.20/drivers/ide/raid/pdcraid.c
--- linux-2.4.20/drivers/ide/raid.org/pdcraid.c	2003-01-09 11:03:11.000000000 +0100
+++ linux-2.4.20/drivers/ide/raid/pdcraid.c	2003-01-09 14:09:21.000000000 +0100
@@ -159,48 +159,11 @@
 }
 
 
-unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
+static unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
 {
 	return block + partition_off;
 }
 
-unsigned long partition_map_linux(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
-{
-	unsigned long newblock;
-	
-	newblock = stride - (partition_off%stride); if (newblock == stride) newblock = 0;
-	newblock += block;
-	newblock = newblock % partition_size;
-	newblock += partition_off;
-	
-	return newblock;
-}
-
-static int funky_remap[8] = { 0, 1,  2, 3, 4, 5, 6, 7 };
-
-unsigned long partition_map_linux_raid0_4disk(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
-{
-	unsigned long newblock,temp,temp2;
-	
-	newblock = stride - (partition_off%stride); if (newblock == stride) newblock = 0;
-
-	if (block < (partition_size / (8*stride))*8*stride ) {
-		temp = block % stride;
-		temp2 = block / stride;
-		temp2 = ((temp2>>3)<<3)|(funky_remap[temp2&7]);
-		block = temp2*stride+temp;
-	}
-
-	
-	newblock += block;
-	newblock = newblock % partition_size;
-	newblock += partition_off;
-	
-	return newblock;
-}
-
-
-
 static int pdcraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
 {
 	unsigned long rsect;
diff -urN linux-2.4.20/drivers/ide/raid.org/silraid.c linux-2.4.20/drivers/ide/raid/silraid.c
--- linux-2.4.20/drivers/ide/raid.org/silraid.c	2003-01-09 11:03:31.000000000 +0100
+++ linux-2.4.20/drivers/ide/raid/silraid.c	2003-01-09 14:09:27.000000000 +0100
@@ -157,7 +157,7 @@
 }
 
 
-unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
+static unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
 {
 	return block + partition_off;
 }
