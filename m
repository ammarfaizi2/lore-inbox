Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRCIRxB>; Fri, 9 Mar 2001 12:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCIRww>; Fri, 9 Mar 2001 12:52:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2012 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129749AbRCIRwl>;
	Fri, 9 Mar 2001 12:52:41 -0500
Date: Fri, 9 Mar 2001 12:51:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Andries Brouwer <aeb@veritas.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103091449580.6037-100000@mikeg.weiden.de>
Message-ID: <Pine.GSO.4.21.0103091232150.14558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, Mike Galbraith wrote:

> I think I've figured it out.. at least I've found a way to reproduce
> the exact errors to the last detail and some pretty nasty corruption
> to go with it.  The operator must help though.. a lot ;-)
> 
> If you do mount -o remount /dev/somedisk / thinking that that will get
> rid of your /dev/ram0 root, that isn't the case, and you will corrupt
> the device you remounted (I did it to a scratch monkey) very badly when
> you write to the still mounted ramdisk.

Ugh. mount -o remount ignores dev_name argument. It will change the
flags of fs mounted from /dev/ram0 and will not even touch a /dev/somedisk.
If you write to device you have mounted... Well, don't expect it to be pretty.

> You must exec a shell (or something) chrooted to your mounted harddisk
> to un-busy the old root and then pivot_root/unmount that old root.  I
> tested this, and all is well.
> 
> I think this is a consequence of the multiple mount changes.. not sure.
> (ergo cc to Al Viro.. he knows eeeeverything about mount points)

I _really_ doubt that it has anything to multiple mounts. mount -o remount
never unmounts anything. Never did. The rest is an obvious result - you
leave fs mounted, you do direct write to its device, you see it fucked.
The fact that it is a root doesn't matter. Relevant part of manpage:
              remount
                     Attempt  to  remount an already-mounted file
                     system.  This is commonly used to change the
                     mount flags for a file system, especially to
                     make a readonly file system writeable.
Hmm... Might be cleaner. IMO
                     Attempt  to  change the mount flags of
                     already-mounted file system.  This is commonly
                     used to make a readonly file system writeable.
would be less confusing. Andries, your comments?
							Cheers,
								Al
(fully expecting a long rant from Richard declaring that -o remount had
_always_ been used to mount a different fs and both ANSI C standard and
X-files fan guide mention it somewhere ;-)

