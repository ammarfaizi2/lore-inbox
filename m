Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSDBO7m>; Tue, 2 Apr 2002 09:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312757AbSDBO7d>; Tue, 2 Apr 2002 09:59:33 -0500
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:49807 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S312694AbSDBO7V>; Tue, 2 Apr 2002 09:59:21 -0500
Subject: Re: 2.5.7 & reiserfs[-related] oops?
From: Chris Mason <mason@suse.com>
To: Stevie O <stevie@qrpff.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020402025340.0228fc88@whisper.qrpff.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 Apr 2002 09:58:46 -0500
Message-Id: <1017759526.24273.52.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-02 at 03:45, Stevie O wrote:
> I downloaded (rather slowly at that -- 5kb/sec, i need dsl!) 2.5.7.
> I configured it using my old config from 2.4.13-ac<something>:
>         cp ../linux-2.4.13-ac<something>/.config
>         yes ''|make oldconfig
>         make menuconfig
> and tweaked a few things (among them, enabling preempting).
> After disabling a few of the modular items that no longer worked (i2o, firewire), I built, lilo'ed, and booted...
> 

You need the patch below (from Oleg Drokin) to fix this oops, but there
is also a problem with the code to finish deletes and truncates after a
crash, and that causes corruption. 

For now, I'd suggest commenting out both of the finish_unfinished()
calls in fs/reiserfs/super.c.  I've been working on the corruption for a
few days, it's really starting to irk me.  For now, I suggest commenting
out both of the finish_unfinished() in fs/reiserfs/super.c

-chris

--- linux-2.5.6/fs/reiserfs/journal.c.orig	Tue Mar 12 15:25:27 2002
+++ linux-2.5.6/fs/reiserfs/journal.c	Tue Mar 12 15:26:47 2002
@@ -1958,8 +1958,7 @@
       		SB_ONDISK_JOURNAL_DEVICE( super ) ?
 		to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;	
 	/* there is no "jdev" option and journal is on separate device */
-	if( ( !jdev_name || !jdev_name[ 0 ] ) && 
-	    SB_ONDISK_JOURNAL_DEVICE( super ) ) {
+	if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
 		journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
 		if( journal -> j_dev_bd )
 			result = blkdev_get( journal -> j_dev_bd, 
@@ -1974,9 +1973,6 @@
 		return result;
 	}
 
-	/* no "jdev" option and journal is on the host device */
-	if( !jdev_name || !jdev_name[ 0 ] )
-		return 0;
 	journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
 	if( !IS_ERR( journal -> j_dev_file ) ) {
 		struct inode *jdev_inode;






