Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVGSScR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVGSScR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVGSScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:32:16 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:58554 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261804AbVGSScQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:32:16 -0400
X-ORBL: [63.202.173.158]
Date: Tue, 19 Jul 2005 11:32:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050719183206.GA23253@taniwha.stupidest.org>
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DD44E2.3000605@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 08:22:26PM +0200, Jan Blunck wrote:

> Since these "arranged" values are also used as the offsets in the
> return dirent IMO it is quite clean.

So the size you want to reflect is n*<stack-depth> i take it?  Where
in this case n is 20?

So you can seek to m*<stack-depth>+<offset> to access an offset into
something at depth m?

> Nope. This value is kind of traditional: tmpfs is using it
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=103208296515378&w=2). I
> think a better value would be 1 (one) since this is also used as the
> dirent offset by dcache_readdir().

I really don't know why tmpfs is doing this.

> The i_size of a directory isn't covered by the POSIX standard. IMO,
> it should be possible to seek in the range of i_size and a following
> readdir() on the directory should succeed.

With what defined semantics?  What if an entry is added in between
seek and readdir?

> But this isn't possible even not with real file systems like ext2.

I'm not sure how expecting a meaningful offset into a directory can
have consistent bahvior.

> But keeping the i_size bound to zero even if the directory contains
> entries does not make sense at all.

Why?  It seems perfectly reasonable that we can return 0 in such
cases.  Zero seems to make more sense as 'magical/unknown' than say
any other arbitrary value.

It's also possible a regular filesystem could return an arbitrary
value such as 20 (not that this directly matters except it becomes
confusing potentially):

    cw@taniwha:~$ mkdir foobar
    cw@taniwha:~$ ls -ld foobar
    drwxr-xr-x  2 cw cw 6 Jul 19 11:29 foobar

    cw@taniwha:~$ mkdir foobar/1234567
    cw@taniwha:~$ ls -ld foobar
    drwxr-xr-x  3 cw cw 20 Jul 19 11:30 foobar
