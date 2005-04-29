Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVD2WDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVD2WDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVD2WDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:03:03 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8154 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263023AbVD2WC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:02:57 -0400
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, aia21@hermes.cam.ac.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, mike.miller@hp.com
In-Reply-To: <OF48BA3721.BD4798AD-ON88256FF2.00680E7E-88256FF2.0069814F@us.ibm.com>
References: <OF48BA3721.BD4798AD-ON88256FF2.00680E7E-88256FF2.0069814F@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114812035.18330.396.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 23:00:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-29 at 20:11, Bryan Henderson wrote:
> So I view it as correct even if fsync() does nothing on a disk-based 
> filesystem because the programmer was lazy (or because the user wants to 
> defeat the performance-busting behavior of some paranoid application). But 
> when Alan speaks of a "not completely correct" version of synchronization, 
> which makes me think of something that doesn't implement any consistent 
> form of "stable," I want to hear more.

On the main fs's people use with a current kernel fsync guarantees the
data went somewhere. What it guarantees beyond that depends on the fs
properties, the driver properties and the media properties.

So ext3 journal=data or jffs which are the strongest guarantee cases
mean that your fsync() data should be on media and stable. Ditto I
believe default ext3 behaviour because fsync has stronger rules than
fdatasync.

The next question is what the I/O device does with the data. SCSI disks
will cache but the scsi layer uses tags and if neccessary turns the
cache off on the drive. In other words you should get that behaviour
correctly on SCSI media.

The default IDE behaviour doesn't turn write cache off and the IDE
device may re-order writes and ack them before they hit storage. IDE
lacks tags, and tends to have poor performance on cache flush commands.
With the barrier support on the right thing should occur, or with hdparm
used to turn the write cache off.

Raid controllers will cache data in their writeback caches, they will
also write and rewrite stripes which can mean a critical failure loses
the cache or involves a whole stripe loss, but that is very unlikely in
most modes. The good ones either write through or have battery backed
caches. The really good ones even let you put the battery/ram unit onto
another card.

Underlying all of this is the fact that disks aren't really disks any
more but NAS devices on funky cables, that can mean you can lose blocks
to drive faults that might not be the block you are currently writing.

Alan

