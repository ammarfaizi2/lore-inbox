Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWBGBCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWBGBCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWBGBCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:02:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964922AbWBGBCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:02:07 -0500
Date: Mon, 6 Feb 2006 17:04:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060206170411.360f3a97.akpm@osdl.org>
In-Reply-To: <20060207003410.GS43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<20060206054815.GJ43335175@melbourne.sgi.com>
	<20060205222215.313f30a9.akpm@osdl.org>
	<20060206115500.GK43335175@melbourne.sgi.com>
	<20060206151435.731b786c.akpm@osdl.org>
	<20060207003410.GS43335175@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> > So to fix both these problems we need to be smarter about terminating the
> > wb_kupdate() loop.  Something like "loop until no expired inodes have been
> > written".
> > 
> > Wildly untested patch:
> 
> Wildly untested assertion - it won't fix my case for the same reason I'm seeing
> the current code not working - we abort higher up in writeback_inodes()
> on the age check.

You mean that we're in the state

a) big-dirty-expired inode is on s_dirty

b) small-dirty-not-expired inode is on s_io

sync_sb_inodes() sees the small-dirty-not-expired inode on s_io and gives up?


In which case, yes, perhaps leaving big-dirty-expired inode on s_io is the
right thing to do.  But should we be checking that it has expired before
deciding to do this?  We don't want to get in a situation where continuous
overwriting of a large file causes other files on that fs to never be
written out.
