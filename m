Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVJKBHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVJKBHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVJKBHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:07:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751332AbVJKBHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:07:53 -0400
Date: Mon, 10 Oct 2005 18:07:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: aia21@cam.ac.uk, glommer@br.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-Id: <20051010180705.0b0e3920.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
	<Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
	<20051010214605.GA11427@br.ibm.com>
	<Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
	<20051010223636.GB11427@br.ibm.com>
	<Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
	<20051010163648.3e305b63.akpm@osdl.org>
	<Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>
>  On Mon, 10 Oct 2005, Andrew Morton wrote:
> 
>  > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>  >>
>  >> > Maybe the best solution is neither one nor another. Testing and failing
>  >> > gracefully seems better.
>  >> >
>  >> > What do you think?
>  >>
>  >>  I certainly agree with you there.  I neither want a deadlock nor
>  >>  corruption.  (-:
>  >
>  > Yup.  In the present implementation __getblk_slow() "cannot fail".  It's
>  > conceivable that at some future stage we'll change __getblk_slow() so that
>  > it returns NULL on an out-of-memory condition.
> 
>  The question is if it is desired --- it will make bread return NULL on 
>  out-of-memory condition, callers will treat it like an IO error, skipping 
>  access to the affected block, causing damage on perfectly healthy 
>  filesystem.

Yes, that is a bit dumb.  A filesystem might indeed want to take different
action for ENOMEM versus EIO.

>  I liked what linux-2.0 did in this case --- if the kernel was out of 
>  memory, getblk just took another buffer, wrote it if it was dirty and used 
>  it. Except for writeable loopback device (where writing one buffer 
>  generates more dirty buffers), it couldn't deadlock.

Wouldn't it be better if bread() were to return ERR_PTR(-EIO) or
ERR_PTR(-ENOMEM)?    Big change.
