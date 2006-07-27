Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWG0HYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWG0HYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWG0HYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:24:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932535AbWG0HYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:24:39 -0400
Date: Thu, 27 Jul 2006 00:24:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org, aia21@cantab.net
Subject: Re: [BUG?] possible recursive locking detected
Message-Id: <20060727002432.0f0c14a5.akpm@osdl.org>
In-Reply-To: <44C86271.9030603@yahoo.com.au>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	<20060726225311.f51cee6d.akpm@osdl.org>
	<44C86271.9030603@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 16:51:29 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > We hold the ext2 directory mutex, and ntfs_put_inode is trying to take an
> > ntfs i_mutex.  Not a deadlock as such, but it could become one in ntfs if
> > ntfs ever does a __GFP_WAIT allocation inside i_mutex, which it surely
> > does.
> 
> Though it should be using GFP_NOFS, right? So the dcache shrinker would
> not reenter the fs in that case.

Sort-of, arguably.  Many years ago, holding i_mutex (i_sem) was considered
to be "in the fs" and one should use GFP_NOFS.

(This code dates from the ext2 directory-in-pagecache conversion - it's
2.4 stuff.)

It's better, of course, to use GFP_HIGHUSER for pagecache so we should aim
to get this working.  And that means don't-take-i_mutex-on-the-reclaim-path.

We quite possibly are doing that in other places, too.

> I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
> cause any problem?

It might, if ext2 takes i_mutex on the reclaim path.  But it doesn't.

