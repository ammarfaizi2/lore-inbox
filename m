Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQKLA6I>; Sat, 11 Nov 2000 19:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKLA56>; Sat, 11 Nov 2000 19:57:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6926 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129460AbQKLA5p>; Sat, 11 Nov 2000 19:57:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: sendfile(2) fails for devices?
Date: 11 Nov 2000 16:57:29 -0800
Organization: Transmeta Corporation
Message-ID: <8ukptp$3c6$1@penguin.transmeta.com>
In-Reply-To: <3A0DE0C8.C700F33D@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A0DE0C8.C700F33D@mandrakesoft.com>,
Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>sendfile(2) fails with -EINVAL every time I try to read from a device
>file.
>
>This sounds like a bug... is it?  (the man page doesn't mention such a
>restriction)

sendfile() on purpose only works on things that use the page cache. 
EINVAL is basically sendfiles way of saying "I would fall back on doing
a read+write, so you might as well do it yourself in user space because
it might actually be more efficient that way". 

>I am using kernel 2.4.0-test11-pre2.  All other tests with sendfile(2)
>succeed:  file->file, file->STDOUT, STDIN->file...

Yes, as long as STDIN is a file ;)

sendfile() wants the source to be in the page cache, because the whole
point of sendfile() was to avoid a copy. 

The current device model does _not_ use the page cache. Now, arguably
that's a bug - it also means that you cannot mmap() a block device - but
as it could be easily documented (maybe it is, somewhere), I'll call it
a bad feature for now.

Now, if you want to add the code to do address spaces for block devices,
I wouldn't be all that unhappy.  I've wanted to see it for a while.  I'm
not likely to apply it for 2.4.x any more, but I'd love to have it early
for 2.5.x. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
