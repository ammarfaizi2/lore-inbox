Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVJKBUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVJKBUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJKBUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:20:07 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:48360 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751308AbVJKBUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:20:05 -0400
Date: Tue, 11 Oct 2005 03:20:04 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: aia21@cam.ac.uk, glommer@br.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051010180705.0b0e3920.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0510110310100.16036@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
 <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
 <20051010223636.GB11427@br.ibm.com> <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
 <20051010163648.3e305b63.akpm@osdl.org> <Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
 <20051010180705.0b0e3920.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  I liked what linux-2.0 did in this case --- if the kernel was out of
>>  memory, getblk just took another buffer, wrote it if it was dirty and used
>>  it. Except for writeable loopback device (where writing one buffer
>>  generates more dirty buffers), it couldn't deadlock.
>
> Wouldn't it be better if bread() were to return ERR_PTR(-EIO) or
> ERR_PTR(-ENOMEM)?    Big change.

No. Out of memory condition can happen even under normal circumstances 
under lightly loaded system. Think of a situation when dirty file-mapped 
pages fill up the whole memory, now a burst of packets from network comes 
that fills up kernel atomic reserve, you have zero pages free --- and what 
now? --- returning ENOMEM and dropping dirty pages without writing them is 
wrong, deadlocking (filesystem waits until memory manager frees some pages 
and memory manager waits until filesystem writes the dirty pages) is wrong 
too.

The filesystem must make sure that it doesn't need any memory to do block 
allocation and data write. Linux-2.0 got this right, it could do getblk 
and bread even if get_free_pages constantly failed.

Mikulas
