Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVAMO73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVAMO73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVAMO73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:59:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261637AbVAMO7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:59:02 -0500
Subject: Re: raid5 crash
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Stephen Tweedie <sct@redhat.com>, Kristian Eide <kreide@online.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16841.65119.240314.917998@cse.unsw.edu.au>
References: <200412222304.36585.kreide@online.no>
	 <16841.65119.240314.917998@cse.unsw.edu.au>
Content-Type: text/plain
Message-Id: <1105628330.1950.37.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 13 Jan 2005 14:58:50 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-12-22 at 23:08, Neil Brown wrote:

> > kernel BUG at drivers/md/raid5.c:813!
> 
> This BUG happens when there are two outstanding read (or write)
> requests for the same piece of storage (more accurately, two "bio"s
> that overlap).

Ouch. 

> raid5 cannot currently handle this situation.
> Most filesystems would never make requests like this.

I don't think there's anything to stop me doing two O_DIRECT read()s
from the same bit of a file at the same time.  As far as I can see, this
should be easily triggered by user-space.

And if you get corruption in a filesystem such that two files share the
same block, then this possibility arises again.  That can happen due to
corruption in an indirect block (ext2/3) or in the reiserfs tree; or
more commonly due to a bitmap block getting corrupted, resulting in the
same block being allocated twice.

This is a situation we really need to handle.  ext3 goes to great
lengths to make sure that if such cases happen, the worst that results
should be the filesystem taking itself readonly cleanly.

It's really bad behaviour for a fault such as a bad IDE cable to be able
to oops the entire kernel.

> I doubt very much that this would happen with ext3.

It certainly shouldn't do so for buffered IO if things are running fine,
but as soon as you get corrupt data, or start using O_DIRECT, it's
possible.

Cheers,
 Stephen


