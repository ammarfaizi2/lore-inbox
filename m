Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUBQToS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266483AbUBQToR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:44:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266503AbUBQToP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:44:15 -0500
Date: Tue, 17 Feb 2004 19:44:14 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040217194414.GP8858@parcelfarce.linux.theplanet.co.uk>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org> <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 08:57:40AM -0800, Linus Torvalds wrote:
> Trust me, this is much less intrusive, and a lot easier to debug too. It 
> won't be as fast as the regular path operations, but depending on what the 
> common cases are (hopefully "look up name that is exact"), it would likely 
> not be horrible either. And it could probably be debugged as a real 
> module, without impacting any existing code, which would make it a lot 
> easier to create.
> 
> See where I'm going? Would this be acceptable to you? Are there any samba 
> people who are knowledgeable about the VFS-layer and have the time/energy 
> to try something like this?
> 
> Al? What do you think?

What will protect your generation counts during the operation itself?
->i_sem?

If anything, I'd suggest doing it as
	cretinous_rename(dir_fd, name1, name2)
with the following semantics:

	* if directory had been changed since open() that gave us dir_fd -
-EFOAD
	* otherwise, rename name1 to name2 (no cross-directory renames here).

No need to expose generation counts to userland - we can just compare the
count at open() time with that at operation time.  The rest can be done
in userland (including creation of files).

We _definitely_ don't want to put "UTF-8 case-insensitive comparison" anywhere
near the kernel - it's insane.  If samba wants it, they get to pay the price,
both in performance and keeping butt-ugly code (after all, the goal of project
is to imitate butt-ugly system for butt-ugly clients).  The same goes for Wine.

And we really don't want to encourage those who port Windows userland in
not fixing the idiotic semantics.  As for Lindows... let's just say that
I can't find any way to describe what I really think of those clowns, their
intellect and their morals that wouldn't lead to a lawsuit from them.
