Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUCaWjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCaWjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:39:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:2542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbUCaWhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:37:50 -0500
Date: Wed, 31 Mar 2004 14:37:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <1080771361.1991.73.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Mar 2004, Stephen C. Tweedie wrote:
>         
> although I can't find an unambiguous definition of "queued for service"
> in the online standard.  I'm reading it as requiring that the I/O has
> reached the block device layer, not simply that it has been marked dirty
> for some future writeback pass to catch; Uli agrees with that
> interpretation.

That interpretation makes pretty much zero sense.

If you care about the data hitting the disk, you have to use fsync() or 
similar _anyway_, and pretending anything else is just bogus.

As such, just marking the pages dirty is as much of a "queing" them for 
write as actually writing them, since in both cases the guarantees are 
_exactly_ the same: the pages have not hit the disk by the time the system 
call returns, but will hit the disk at some time in the future.

Having the requirement that it is on some sw-only request queue is
nonsensical, since such a queue is totally invisible from a user
perspective.

User space has no idea about "block device layer" vs "VM layer" queues,
and trying to distinguiosh between the two is madness. It's just an 
internal implementation issue that has no meaning to the user.

		Linus
