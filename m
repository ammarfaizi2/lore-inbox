Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131091AbQLQAwC>; Sat, 16 Dec 2000 19:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131452AbQLQAvw>; Sat, 16 Dec 2000 19:51:52 -0500
Received: from lips.borg.umn.edu ([160.94.232.50]:19987 "EHLO
	lips.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S131091AbQLQAvr>; Sat, 16 Dec 2000 19:51:47 -0500
Message-ID: <3A3C06F7.54F51AFA@thebarn.com>
Date: Sat, 16 Dec 2000 18:21:11 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.12 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.LNX.4.10.10012142208420.1308-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Thu, 14 Dec 2000, Russell Cattelan wrote:
> >
> > Ok one more wrinkle.
> > sync_buffers calls ll_rw_block, this is going to have the same problem as
> > calling ll_rw_block directly.
>
> Good point.
>
> This actually looks fairly nasty to fix. The obvious fix would be to not
> put such buffers on the dirty list at all, and instead rely on the VM
> layer calling "writepage()" when it wants to push out the pages.
> That would be the nice behaviour from a VM standpoint.
>
> However, that assumes that you don't have any "anonymous" buffers, which
> is probably an unrealistic assumption.
>
> The problem is that we don't have any per-buffer "writebuffer()" function,
> the way we have them per-page. It was never needed for any of the normal
> filesystems, and XFS just happened to be able to take advantage of the
> b_end_io behaviour.
>
> Suggestions welcome.
>
>                 Linus

Ok after a bit of trial and error I do have something working.
I wouldn't call it the most elegant solution but it does work
and it isn't very intrusive.

#define BH_End_io  7    /* End io function defined don't remap it */

                /*  don't change the callback if somebody explicitly set it */

                if(!test_bit(BH_End_io, &bh->b_state)){
                  bh->b_end_io = end_buffer_io_sync;
                }
What I've done is in the XFS set buffer_head setup functions is
set the initial value of b_state to BH_Locked  and BH_End_io
set the callback function and the rest of the relevant fields and then unlock
the
buffer.

The only other quick fix that comes to mind is to change sync_buffers to use
submit_bh rather than ll_rw_block.

--
Russell Cattelan
cattelan@thebarn.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
