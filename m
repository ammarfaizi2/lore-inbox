Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUIRJzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUIRJzH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 05:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUIRJzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 05:55:07 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:40388 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S269170AbUIRJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 05:54:59 -0400
Date: Sat, 18 Sep 2004 11:55:04 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, <Valdis.Kletnieks@vt.edu>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: journal aborted, system read-only
In-Reply-To: <200409171319.43806.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.44.0409181128540.22468-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Gene Heskett wrote:

> Thats the same conclusion I've since come to, Valdis.  And, now that 
> I've moved my /var to its own partition on another disk, that may 
> have reduced the thrashing of that drive enough to stop the problem.  
> At least I've had no more such occurances since I moved /var off 
> of /.  About 30.5 hours now according to the uptime display in 
> gkrellm.

I've just experienced a very similar situation: I/O error, journal abort, 
partition went read-only. Maybe it's completely unrelated, but by chance, 
do you have some clipping jumper set on this disk so you depend on the 
ide-stroke feature?

In my case this was the culprit. It's a 120GB disk in a box with old 
crashing Award BIOS, so I've clipped it to 32GB. However I've missed the 
fact since about 2.6.7 one has to set hda=stroke kernel parameter in order 
to get the host protected area disabled. Therefore partitions starting 
behind 32GB failed to mount.

In contrast, the partition which crosses the 32GB barrier was mounted 
succesfully but later when trying to access beyond the limit I was seeing:

ide0: reset: success
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=110291109, high=6, low=9627813, sector=110291109
ide: failed opcode was: unknown
end_request: I/O error, dev hda, sector 110291109
EXT3-fs error (device hda7): ext3_get_inode_loc: unable to read inode block - inode=3883009, block=7766022
Aborting journal on device hda7.
ext3_abort called.
EXT3-fs error (device hda7): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

Adding the hda=stroke kernel parameter solved the issue - forced fsck 
showed no damage happened to the fs.

HTH,
Martin

