Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292872AbSB1Plb>; Thu, 28 Feb 2002 10:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293189AbSB1Pip>; Thu, 28 Feb 2002 10:38:45 -0500
Received: from host194.steeleye.com ([216.33.1.194]:35598 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S293426AbSB1Pg7>; Thu, 28 Feb 2002 10:36:59 -0500
Message-Id: <200202281536.g1SFaqF02079@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Fri, 22 Feb 2002 13:14:21 EST." <1064010000.1014401661@tiny> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Feb 2002 09:36:52 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Gilbert prompted me to re-examine my notions about SCSI drive caching, 
and sure enough the standard says (and all the drives I've looked at so far 
come with) write back caching enabled by default.

Since this is a threat to the integrity of Journalling FS in power failure 
situations now, I think it needs to be addressed with some urgency.

The "quick fix" would obviously be to get the sd driver to do a mode select at 
probe time to turn off the WCE and RCD bits (this will place the cache into 
write through mode), which would match the assumptions all the JFSs currently 
make.  I'll see if I can code up a quick patch to do this.

A longer term solution might be to keep the writeback cache but send down a 
SYNCHRONIZE CACHE command as part of the back end completion of a barrier 
write, so the fs wouldn't get a completion until the write was done and all 
the dirty cache blocks flushed to the medium.

Clearly, there would also have to be a mechanism to flush the cache on 
unmount, so if this were done by ioctl, would you prefer that the filesystem 
be in charge of flushing the cache on barrier writes, or would you like the sd 
device to do it transparently?

James


