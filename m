Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbRGMQaw>; Fri, 13 Jul 2001 12:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbRGMQam>; Fri, 13 Jul 2001 12:30:42 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:38916 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267501AbRGMQae>; Fri, 13 Jul 2001 12:30:34 -0400
Date: Fri, 13 Jul 2001 17:30:07 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mike Black <mblack@csihq.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net, Stephen Tweedie <sct@redhat.com>
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Message-ID: <20010713173007.G13419@redhat.com>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <111501c10ba3$664a1370$e1de11cc@csihq.com>; from mblack@csihq.com on Fri, Jul 13, 2001 at 09:54:56AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2001 at 09:54:56AM -0400, Mike Black wrote:
> I give up!  I'm getting file system corruption now on the ext3 partition...
> and I've got a kernel oops (soon to be decoded)

Please, do send details.  We already know that the VM has a hard job
under load, and journaling exacerbates that --- ext3 cannot always
write to disk without first allocating more memory, and the VM simply
doesn't have a mechanism for dealing with that reliably.  It seems to
be compounded by (a) 2.4 having less write throttling than 2.2 had,
and (b) the zoned allocator getting confused about which zones
actually need to be recycled.

It's not just ext3 --- highmem bounce buffering and soft raid buffers
have the same problem, and work around it by doing their own internal
preallocation of emergency buffers.  Loop devices and nbd will have a
similar problem if you use those for swap or writable mmaps, as will
NFS.

One proposed suggestion is to do per-zone memory reservations for the
VM's use: Ben LaHaise has prototype code for that and we'll be testing
to see if it makes for an improvement when used with ext3.

Cheers,
 Stephen
