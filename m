Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285309AbRLSOzw>; Wed, 19 Dec 2001 09:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285311AbRLSOzd>; Wed, 19 Dec 2001 09:55:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20883 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285309AbRLSOz1>;
	Wed, 19 Dec 2001 09:55:27 -0500
Date: Wed, 19 Dec 2001 09:55:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <m1ellrwq8c.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0112190930040.11104-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Dec 2001, Eric W. Biederman wrote:

> Just for credentials I have a static user space dhcp and tftp just
> 16KB (uncompressed).  If I knew what was involved in the nfs
> mount code I'd contribute this and you would be feature complete.

I have _very_ crude userland nfs mount-by-hands.  It works for testing
other parts of the patch, but that's it - it's quick and dirty with
strong emphasis on the latter.

If you want to look at it - I've dropped it on ftp.math.psu.edu/pub/viro;
name's nfsroot.c and it's _crap_.  Don't read without a barf-bag.  Due to
intended use it takes server address and options from environment variables
(kernel passes options to /init that way).  I.e.
# root_server_addr=<address> root_server_path=<path> nfsroot
or
# root_server_addr=<address> root_server_path=<path>,<options> nfsroot
address is decimal, in network order.

Should mount on /mnt.  RPC over UDP by hands (all we need is three RPC
calls in raw, we wait for result before sending the next one, very limited
handling of timeouts).

Again, it's nowhere near anything I would consider suitable for real use.
Works for testing purposes, but that's it.
 
> Probably the simplest solution is to allow files to come from both
> locations with the additional bootloader files overwriting the
> compiled in files.  And just dropping initrd support altogether.

No need.  Pass a concatenation of several cpio/cpio.gz.  Instead of
compiled-in put that bunch first in the cat.  And there's no real
need to drop initrd support - wrap the image with cpio header saying
that it's /initrd and have /init use it instead of /dev/initrd.  End
of story (and minor 250 in rd.c, while we are at it).

I'm doing that variant right now (basically it's removal of compiled-in
array from uncpio, adding support for several concatenated archives
and divorcing initrd_start/initrd_end from CONFIG_BLK_DEV_INITRD).
It's easy, since both cpio and gzip are self-terminating and both
are guaranteed to have non-zero first byte, so we can even allow
arbitrary padding with NULs between the parts.

