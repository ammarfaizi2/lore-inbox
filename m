Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbRLSQKa>; Wed, 19 Dec 2001 11:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285356AbRLSQKU>; Wed, 19 Dec 2001 11:10:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14668 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285352AbRLSQKF>; Wed, 19 Dec 2001 11:10:05 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112190930040.11104-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Dec 2001 08:49:44 -0700
In-Reply-To: <Pine.GSO.4.21.0112190930040.11104-100000@weyl.math.psu.edu>
Message-ID: <m14rmnw6p3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On 19 Dec 2001, Eric W. Biederman wrote:
> 
> > Just for credentials I have a static user space dhcp and tftp just
> > 16KB (uncompressed).  If I knew what was involved in the nfs
> > mount code I'd contribute this and you would be feature complete.
> 
> I have _very_ crude userland nfs mount-by-hands.  It works for testing
> other parts of the patch, but that's it - it's quick and dirty with
> strong emphasis on the latter.
> 
> If you want to look at it - I've dropped it on
> ftp.math.psu.edu/pub/viro;

[snip]

Thanks I'll take a look, if all it takes is 3 RPC calls then it
doesn't sound too bad, to deal with.
  
> > Probably the simplest solution is to allow files to come from both
> > locations with the additional bootloader files overwriting the
> > compiled in files.  And just dropping initrd support altogether.
> 
> No need.  Pass a concatenation of several cpio/cpio.gz.  Instead of
> compiled-in put that bunch first in the cat.  And there's no real
> need to drop initrd support - wrap the image with cpio header saying
> that it's /initrd and have /init use it instead of /dev/initrd.  End
> of story (and minor 250 in rd.c, while we are at it).

Well that sounds like a reasonable approach.  It sounds like dropping
and re-adding initrd support in a slightly different form.

I guess from what you have described there could be a test ``if !cpio
archive assume old initrd''.  But I can't imagine how that would be
anything but ugly.
 
> I'm doing that variant right now (basically it's removal of compiled-in
> array from uncpio, adding support for several concatenated archives
> and divorcing initrd_start/initrd_end from CONFIG_BLK_DEV_INITRD).
> It's easy, since both cpio and gzip are self-terminating and both
> are guaranteed to have non-zero first byte, so we can even allow
> arbitrary padding with NULs between the parts.

O.k. This sounds quite reasonable on the boot protocol
side.  Bootloaders if they want to take advantage of the new
functionality need to be made aware of the cpio issue but otherwise
can remain blissfully ignorant.

Except for the issue of creating a kernel file with one or more of
these cpio archives attached to the kernel image.  This work seems
completely independent from what I'm doing.  And for simple network
booting it is required to have everything all in one file. 

I have alarm bells ringing in my gut saying there are pieces of your
proposal that are on the edge of being overly complex... But without
source I can't really say.  Arbitrary NULL padding between images is
cool but why?

Eric
