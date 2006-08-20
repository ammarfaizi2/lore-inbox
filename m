Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWHTLsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWHTLsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 07:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWHTLsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 07:48:32 -0400
Received: from mail.tigress.co.uk ([195.172.168.163]:43216 "EHLO
	intgat.tigress.co.uk") by vger.kernel.org with ESMTP
	id S1750747AbWHTLsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 07:48:31 -0400
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200608201148.k7KBm8XA005948@tiffany.internal.tigress.co.uk>
Date: Sun, 20 Aug 2006 12:48:08 +0100
To: rmy@tigress.co.uk, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext2: avoid needless discard of preallocated blocks
References: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk>
 <20060819224603.bf687be2.akpm@osdl.org>
In-Reply-To: <20060819224603.bf687be2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>Been there, done that.  The problem was that hanging onto the preallocation
>will cause separate files to have up-to-seven-block gaps between them.  So
>if you put a large number of small files in the same directory, the time to
>read them all back is quite significantly impacted: they cover a lot more
>disk.

The preallocation is only held while the file is open, so there will only
be gaps between files that are open simultaneously.  If they're created
sequentially there will be no gap.

This issue exists even with the current code.

The patch will have a small effect.  With the current code an open file
will lose its preallocation when some other process touches the inode.
In that case a subsequently created file will follow without a gap.  As
soon as the open file is written to, though, it gets a new preallocation.
