Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbRESSci>; Sat, 19 May 2001 14:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbRESSc2>; Sat, 19 May 2001 14:32:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261951AbRESScR>; Sat, 19 May 2001 14:32:17 -0400
Date: Sat, 19 May 2001 11:31:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
 in userspace
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.21.0105191115090.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Ben LaHaise wrote:
> 
> 1. Generic lookup method and argument parsiing (fs/lookupargs.c)

Looks sane.

> 2. Restricted block device (drivers/block/blkrestrict.c)

This is not very user-friendly, but along with symlinks this makes perfect
sense. It would make partition handling a _lot_ simpler.

Note, however, that I think the "restricted block device" is a much more
generic issue than just block devices. I've already discussed with Alan
the possibility of making _all_ file descriptors have the notion of
"restrictions", notably the "start, end" kind of things.

It is very useful for other things too - imagine opening /dev/mem, and
wanting to pass a restricted portiong of it to other processes with the
standard file descriptor passing facilities (think "secure DGA" for the X
server, but also think untrusted users that can read parts of shared files
etc - a suid program that opens a file, restricts it, drops privileges and
knows that the program can only access a specific part of the file)

> 3. Userspace partition code proposal

Yes and no.

I absolutely thihnk the idea that users actually _using_ these names is a
horrible one, and fraught with potential for much too easy mistakes that
end up being disastrous.

But having symlinks that are created by a special program would be ok.

[ Also, note how symlinks would make the point of initrd completely
  moot. You don't have to have initrd to initialize the thing, you can
  initialize the thing at installation time and when doing fdisk, and the
  symlinks would act as the permanent markers. ]

HOWEVER, you have to realize that there are serious security and
maintenance issues here, and I think your idea breaks down completely
because of that.

The thing is, you only have permissions on a "per-object" basis, and it's
common practice to have different permissions for different partitions.
Your scheme does not allow this. Which means that it is fundamentally
broken. Sorry.

So don't go overboard. The name-based thing is useful, but it's useful for
only certain things. And you must _never_ forget the security and
management issues.

For example, if you can open a serial port in the first place, you can set
its baud-rate. So it's ok to make baud-rate part of the name. And once you
have permission to read /dev/fd0 it doesn't make sense to limit you to one
particular format. So it's ok to have the disk format be part of the name.

But it's not possible to make the partition be a "name" issue. Because
while you obviously need different names, you _also_ need different
permissions.

		Linus

