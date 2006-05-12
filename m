Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWELRp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWELRp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWELRpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:45:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62686 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932172AbWELRpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:45:24 -0400
Date: Fri, 12 May 2006 10:47:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
Message-Id: <20060512104750.0f5cb10a.akpm@osdl.org>
In-Reply-To: <1060512060809.8099@suse.de>
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> If md is asked to store a bitmap in a file, it tries to hold onto the
> page cache pages for that file, manipulate them directly, and call a
> cocktail of operations to write the file out.  I don't believe this is
> a supportable approach.

erk.  I think it's better than...

> This patch changes the approach to use the same approach as swap files.
> i.e. bmap is used to enumerate all the block address of parts of the file
> and we write directly to those blocks of the device.

That's going in at a much lower level.  Even swapfiles don't assume
buffer_heads.

When playing with bmap() one needs to be careful that nobody has truncated
the file on you, else you end up writing to disk blocks which aren't part
of the file any more.

All this (and a set_fs(KERNEL_DS), ug) looks like a step backwards to me. 
Operating at the pagecache a_ops level looked better, and more
filesystem-independent.

I haven't looked at this patch at all closely yet.  Do I really need to?
