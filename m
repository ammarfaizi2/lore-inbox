Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVAMQDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVAMQDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVAMQDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:03:51 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:63138 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261649AbVAMP4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:56:44 -0500
Message-ID: <41E69A28.9080900@nortelnetworks.com>
Date: Thu, 13 Jan 2005 09:56:24 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrew Morton <akpm@osdl.org>, hirofumi@mail.parknet.co.jp,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: write barriers - Was: Re: [RFC][PATCH] problem of	cont_prepare_write()
References: <877joexjk5.fsf@devron.myhome.or.jp>	 <20041122024654.37eb5f3d.akpm@osdl.org>	 <1101121403.18623.10.camel@imp.csi.cam.ac.uk>	 <20041122135354.38feab51.akpm@osdl.org>	 <Pine.LNX.4.60.0411222324150.27573@hermes-1.csi.cam.ac.uk>	 <20041122154325.4d8e53ef.akpm@osdl.org> <1105627627.22536.30.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1105627627.22536.30.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> If I am setting two variables in sequence and it is essential that if a
> different cpu reads those variables it seems them updated in the same
> order as they were written in the C code do I need a write barrier in
> between the two?  For example:
> 
> ntfs_inode->allocated_size = 10;
> ntfs_inode->initilized_size = 10;

I believe so.  You may also need to cast them as volatile to prevent the 
compiler from reordering--can someone with more gcc knowledge than I 
state definitively whether or not it is smart enough to not reorder 
barriers?

> Should another CPU see initialized_size = 10 but allocated_size < 10 the
> ntfs driver will blow up in some places.  So does that mean I need a
> write barrier, between the two?

As above.

You may also need a read barrier to ensure that they are not 
speculatively loaded in the wrong order--could someone more knowledgable 
than I comment on that?

> If yes, do I still need it if I wrap the two settings (and all accesses)
> with a spin lock?  And in particular with a rw-spinlock?  For example:
> 
> write_lock_irqsave(&ntfs_inode->size_lock, flags);
> ntfs_inode->allocated_size = 10;
> ntfs_inode->initilized_size = 10;
> write_unlock_irqrestore(&ntfs_inode->size_lock, flags);
> 
> Do I still need a write barrier or does the spinlock imply it already?

I believe the spinlock implies it.

> Thanks a lot in advance and apologies for the stupid(?) questions...

Not stupid.  Concurrency is hard.

Chris
