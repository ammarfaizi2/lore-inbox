Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUC1Sat (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUC1Sat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:30:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:14346 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262130AbUC1Sap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:30:45 -0500
Date: Sun, 28 Mar 2004 22:30:13 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Thomas Steudten <alpha@steudten.com>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, mingo@redhat.com, neilb@cse.unsw.edu.au
Subject: Re: md raid oops on 2.4.25/alpha
Message-ID: <20040328223013.A15859@jurassic.park.msu.ru>
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at> <20040327164153.GA7324@gamma.logic.tuwien.ac.at> <20040328160246.GA19965@gamma.logic.tuwien.ac.at> <40670BAE.4060901@steudten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40670BAE.4060901@steudten.com>; from alpha@steudten.com on Sun, Mar 28, 2004 at 07:30:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 07:30:22PM +0200, Thomas Steudten wrote:
> Looks like the well known bad assembler code with gcc.
> On the alpha you see the problem first in the
> raid1_read_balance() code sequence..

Very likely.

> You should use gcc 3.3.2 better 3.3.3.

Also, here is a hack (originally from Jay Estabrook) which
should work around a bug in older compilers.

Ivan.

--- linux.orig/drivers/md/raid1.c	Thu Feb  5 14:11:04 2004
+++ linux/drivers/md/raid1.c	Sun Mar 28 22:13:33 2004
@@ -487,6 +487,12 @@ static int raid1_read_balance (raid1_con
 		goto rb_out;
 	
 
+#if defined(CONFIG_ALPHA) && ((__GNUC__ < 3) || \
+			      ((__GNUC__ == 3) && (__GNUC_MINOR__ < 3)))
+	/* Work around a compiler bug in older gcc */
+	new_disk = *(volatile int *)&new_disk;
+#endif
+
 	/* make sure that disk is operational */
 	while( !conf->mirrors[new_disk].operational) {
 		if (new_disk <= 0) new_disk = conf->raid_disks;
@@ -544,6 +550,11 @@ static int raid1_read_balance (raid1_con
 	
 	/* Find the disk which is closest */
 	
+#if defined(CONFIG_ALPHA) && ((__GNUC__ < 3) || \
+			      ((__GNUC__ == 3) && (__GNUC_MINOR__ < 3)))
+	/* Work around a compiler bug in older gcc */
+	disk = *(volatile int *)&disk;
+#endif
 	do {
 		if (disk <= 0)
 			disk = conf->raid_disks;
