Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSKFQJU>; Wed, 6 Nov 2002 11:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbSKFQJU>; Wed, 6 Nov 2002 11:09:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54083 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265785AbSKFQJS>; Wed, 6 Nov 2002 11:09:18 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Nov 2002 09:13:18 -0700
In-Reply-To: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
Message-ID: <m1vg3aekwx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> >From a sanity standpoint, I think the thing already _has_ a system call, 
> though: clearly "sys_reboot()" is the place to add a case for "reboot into 
> this image". No? That's where we shut down devices anyway, and it's the 
> sane place to say "reboot into the kexec image"

When kexec is separated into two pieces I agree.  As I had it
initially in one step it does not look at all like reboot.    Now I
just need to think up a new magic number for sys_reboot.

[snip wonderful vision of the theoretical simplicity of sys_kexec].

In case I was not sufficiently clear last night.  It could be as
simple as your example code if I replaced vmalloc by
__get_free_pages/alloc_pages, and allocated a large contiguous area of
ram.  But MAX_ORDER limits me to 8MB images, and allocating an 8MB
chunk is unreliable, and even a 2MB chunk is dangerous.    

So I must use some form of scatter/gather list of pages, like
area ->pages[] to make it work.  Things get tricky because I gather
(via memcpy) the pages at a location that potentially overlaps the
source pages.  So I must walk through the list of pages making certain
I when I gather (memcpy) the buffer pages into their final location I
will not stomp on a buffer page I have not come to yet. Correctly
doing that untangling is where the complexity in kernel/kexec.c comes
from.

Eric

