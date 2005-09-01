Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVIAOu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVIAOu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVIAOu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:50:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965170AbVIAOu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:50:26 -0400
Date: Thu, 1 Sep 2005 10:50:06 -0400
From: Alan Cox <alan@redhat.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: 2.6.13-mm1
Message-ID: <20050901145006.GF5427@devserv.devel.redhat.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6970000.1125584568@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 07:22:53AM -0700, Martin J. Bligh wrote:
> -               if (count > (TTY_FLIPBUF_SIZE - tty->flip.count))
> -                       count = TTY_FLIPBUF_SIZE - tty->flip.count;
> -
> +               count = tty_buffer_request_room(tty, N_INBUF);
> +               

Should be "int count = " yes

>                 /* If flip is full, just reschedule a later read */
>                 if (count == 0) {
>                         poll_mask |= HVC_POLL_READ;
> 
> shouldn't be deleting the declaration of count. 
> and possibly the "flip removal" was incomplete (line 636) ???

Yep. You can remove the tty->flip.count test or use count, but at that
point count is guaranteed to be > 0 I believe. Fixed both in my tree will
push a new diff to Andre soon.

Also if you are tidying up all the 'read 64 chars and take a break' stuff
should just go away. The kernel will buffer large chunks of data for you
now. In the ideal case if you know the total pending space you can do

	int len = tty_buffer_request_room(tty, len)

and it'll look to kmalloc a big enough buffer for you if the buffer pool
isn't suitable. Even if that fails (its a hint) the tty layer will split the
data across multiple smaller buffers for you when you use tty_insert_flip_*

So you should be able to just ram data at it as it comes off the hvc.

Alan

