Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVDPTgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVDPTgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVDPTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 15:36:13 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:12748 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262739AbVDPTgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 15:36:01 -0400
Date: Sat, 16 Apr 2005 12:35:59 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Hacksaw <hacksaw@hacksaw.org>
cc: linux-os@analogic.com, "Theodore Ts'o" <tytso@mit.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before
  using it
In-Reply-To: <200504160830.j3G8UH0x031123@hacksaw.org>
Message-ID: <Pine.LNX.4.58.0504161226140.6618@shell4.speakeasy.net>
References: <200504160830.j3G8UH0x031123@hacksaw.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2005, Hacksaw wrote:

> >if you want actual concrete examples, let me know.
> I'd love a few, but maybe privately?
>
>
> I can certainly see where always copying is simpler; I certainly consider this
> to be an optimization, which must be looked at carefully, lest you end up with
> that which speed things up a little, but adds a big maintenance headache.
>
> But this strikes me as a potentially big speed up for movement through
> devices. (Or is there already a mechanism for that?)
>
> >It checks if the LAST page belongs to userland, and fails if not;
> I can't claim to know how memory assignment goes. I suppose that this
> statement means that the address space the userland program sees is continuous?
>
> If not I could see a scenario where that would allow someone to get at data
> that isn't theirs, by allocating around until they got an chunk far up in
> memory, then just specified a start address way lower with the right size to
> end up on their chunk.
>
> I'm assuming this isn't a workable scenario, right?

For the copy_from_user() operation, we're still talking about virtual
memory. In virtual memory terms, each userspace program resides in the
lower addresses, while the kernel takes up the higher addresses. The
user program can pass the kernel any virtual memory pointer it feels
like.

The kernel first checks that it won't try to read from itself, simply by
checking that the last page, belonging to the highest virtual address of
the supposed buffer, does not belong to kernel space. So far so good.

Now the only thing that can go wrong is that the user program told the
kernel that the buffer exists, but some or all of the pages are not
mapped in virtual memory. This is taken care of "transparently" during
the copy -- if we try to copy from a page that isn't mapped, the kernel
will catch the exception, realize that the buffer was bogus, and return
an error.

All of this works because virtual memory is much more restrictive than
physical memory in terms of what data resides where.

> --
> You are in a maze of twisty passages, all alike. Again.
> http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD
>
>

-Vadim Lobanov
