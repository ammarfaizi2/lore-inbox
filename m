Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUF2RlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUF2RlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUF2RlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:41:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21184 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265833AbUF2RlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:41:15 -0400
Date: Tue, 29 Jun 2004 18:41:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] expandable anonymous shared mappings
In-Reply-To: <40E1A19C.6090607@aknet.ru>
Message-ID: <Pine.LNX.4.44.0406291828030.16640-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, Stas Sergeev wrote:
> Now I understand, however, the problems I had with
> mremap(), have nothing special to do with the anon-shm,
> it just seems to be the usual thing with that syscall.
> It is full of surprises, it will map a zero-page to you,
> it will give you a SIGBUS, it will do everything
> but not what you really want from it:) I always
> wanted to have the more reliable mremap(). Not the
> one that can expand everything in the world, but
> the one that returns the value you can rely upon,
> as all the other syscalls do.

>From this attack on poor little mremap(), I think perhaps there's
something else you didn't realize, that I'd assumed you did realize.

If you have a file of size, say, 2 pages; and you mmap 3 pages of
it (from offset 0 for simplicity); then you try to access the third
page of your mapping... you get SIGBUS.  That's so whether it's a
shared or a private mapping.  It's even so if it's a private mapping,
you write your own data into the second page, you truncate the file
to 1 page, you try to access your own data in the second page again.
That's how mmap is specified to behave, not just on Linux.

So mremap() is entirely consistent to allow you to extend a mapping
beyond the end of the object, such that you'll get SIGBUS if you
try to access the end of your mapping.

The deficiency with shared anonymous is that there's no way to expand
or shrink the underlying object to match the mapping, whereas you can
ftruncate a real file.

Hugh

