Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVJKAJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVJKAJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVJKAJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:09:27 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:23524 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751304AbVJKAJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:09:26 -0400
Date: Tue, 11 Oct 2005 02:09:25 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, glommer@br.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051010163648.3e305b63.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
 <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
 <20051010223636.GB11427@br.ibm.com> <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
 <20051010163648.3e305b63.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Andrew Morton wrote:

> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>>
>> > Maybe the best solution is neither one nor another. Testing and failing
>> > gracefully seems better.
>> >
>> > What do you think?
>>
>>  I certainly agree with you there.  I neither want a deadlock nor
>>  corruption.  (-:
>
> Yup.  In the present implementation __getblk_slow() "cannot fail".  It's
> conceivable that at some future stage we'll change __getblk_slow() so that
> it returns NULL on an out-of-memory condition.

The question is if it is desired --- it will make bread return NULL on 
out-of-memory condition, callers will treat it like an IO error, skipping 
access to the affected block, causing damage on perfectly healthy 
filesystem.

I liked what linux-2.0 did in this case --- if the kernel was out of 
memory, getblk just took another buffer, wrote it if it was dirty and used 
it. Except for writeable loopback device (where writing one buffer 
generates more dirty buffers), it couldn't deadlock.

Mikukas

> Anyone making such a change
> would have to audit all callers to make sure that they handle the NULL
> correctly.
>
> It is appropriate at this time to fix the callers so that they correctly
> handle the NULL return.  However, it is non-trivial to actually _test_ such
> changes, and such changes should be tested.  Or at least, they should be
> done with considerable care and knowledge of the specific filesystems.
>
