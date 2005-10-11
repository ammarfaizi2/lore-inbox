Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVJKFD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVJKFD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVJKFD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:03:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751329AbVJKFDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:03:25 -0400
Date: Mon, 10 Oct 2005 22:02:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: aia21@cam.ac.uk, glommer@br.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-Id: <20051010220242.794b2f2b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0510110310100.16036@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
	<Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
	<20051010214605.GA11427@br.ibm.com>
	<Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
	<20051010223636.GB11427@br.ibm.com>
	<Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
	<20051010163648.3e305b63.akpm@osdl.org>
	<Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
	<20051010180705.0b0e3920.akpm@osdl.org>
	<Pine.LNX.4.62.0510110310100.16036@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>
> >>  I liked what linux-2.0 did in this case --- if the kernel was out of
> >>  memory, getblk just took another buffer, wrote it if it was dirty and used
> >>  it. Except for writeable loopback device (where writing one buffer
> >>  generates more dirty buffers), it couldn't deadlock.
> >
> > Wouldn't it be better if bread() were to return ERR_PTR(-EIO) or
> > ERR_PTR(-ENOMEM)?    Big change.
> 
> No. Out of memory condition can happen even under normal circumstances 
> under lightly loaded system. Think of a situation when dirty file-mapped 
> pages fill up the whole memory, now a burst of packets from network comes 
> that fills up kernel atomic reserve, you have zero pages free --- and what 
> now? --- returning ENOMEM and dropping dirty pages without writing them is 
> wrong, deadlocking (filesystem waits until memory manager frees some pages 
> and memory manager waits until filesystem writes the dirty pages) is wrong 
> too.

Well.  The filesystem could just redirty the page and skip the writepage().
That's still deadlockable but I bet the kernel would recover in the vast
majority of cases.

Still, this is all very theoretical - there are no plans to make getblk
bail out on oom - AFAIK nobody has been able to demonstrate a testcase...
