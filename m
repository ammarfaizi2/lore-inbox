Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUG0FQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUG0FQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUG0FQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:16:00 -0400
Received: from web13708.mail.yahoo.com ([216.136.175.141]:33140 "HELO
	web13708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266357AbUG0FPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:15:10 -0400
Message-ID: <20040727051505.7614.qmail@web13708.mail.yahoo.com>
Date: Mon, 26 Jul 2004 22:15:05 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [RFC][PATCH] ataraid_end_request hides errors (all? 2.4 kernels)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, mkrikis@yahoo.com, arjanv@redhat.com
In-Reply-To: <20040726235659.GA17761@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> > And that is the following. For RAID1 writes, the IOs have to be
> > submitted to all the mirrors. If the IO for _any_ of them fails,
> > the upper levels should be notified of the error, because the
> > data integrity is broken across mirrors. (With the exception of
> > those few subdrivers that are capable of keeping working with the
> > volume in "degraded" mode.) 
> 
> I supposed all of them would be able to work in degraded mode? No?

Well, I don't want to give definite answers for drivers I haven't
been involved with. Yet my belief is that none of the ataraid
subdrivers that are currently included with the official kernel
sources can do that. Actually, I should not have chosen the words
"keeping working" because they surely will, in blissful ignorance
of any errors that are happening or any metadata that may need
updating. I'll stop here as this is not a direction that I want
to take this discussion. And my apologies if what I said is not
correct. I think the main idea is that this is ataraid, not md,
and the bar is set much lower on purpose. But that shouldn't
preclude letting the user know that errors are happening, and 
that's why I first wrote.

> > That's very unfortunate, because the comments in fs.h for 2.4
> kernels
> > and in buffer_head.h for 2.6 kernels make it look like all the bits
> > starting with BH_PrivateStart are fair game. Any chance of
> replacing
> > the inviting comment with a big warning, or better yet, officially
> > incorporating all the bits used in jbd.h into the b_state?
> 
> Well, the comment says
> 
>         BH_PrivateStart,/* not a state bit, but the first bit
> available
>                          * for private allocation by other entities
>                          */
> 
> And "other entities" are some of the journalling filesystems.
> 
> When I read the comment, I can't figure out that using it 
> freely from anywhere is "fair game". But you seem to understand
> otherwise.

Yes, I had indeed understood that any new modules may make free
use of this bit as it suits their needs. A new block device
driver, for example, is also an "other entity". The author may
check what the layers below it do (if any, e.g., scsi hba drivers),
see that nobody is touching BH_PrivateSync and assume that it
is OK to use it in the block device driver. Or in an ataraid
patch :-). Turns out that the bit is off-limits, however, because
journaling filesystems use it and block device drivers living below 
the filesystems could cause problems by using this bit. That's
not good, the block device driver writer should not have to
worry about what the higher layers are doing. While it may not
be the best analogy, when we kmalloc memory, it is ours to use,
no worries about who else will use it after we're done. We may
have to initialize it but we certainly don't have to return it
to the state that we received it in before releasing. Going back 
to the BH_PrivateSync bit, even a person who notices jbd.h using
the bit, may assume that perhaps the filesystems only use the bit
when nobody can interfere with its use. So now I know that it's
apparently not the case, but I sure had my hopes up still very
recently... (Yes, I know that the argument can be made that the
block device driver shouldn't use it either, because somebody
on an even lower level may decide to use it... I don't have a
good response to that; I can't demand of filesystems what I'm
not doing myself; I was just hoping for a little miracle, I guess).
 
> Yes, we could stick a stronger indication of "journalling fs'es for
> instance 
> use this". Incorporating the bits in jbd.h into b_state doesnt seem
> right
> because BH_PrivateStart is a generic thing, and not a JBD only thing.
> 
> Does that make sense?

Yes and no. If it's a truly "generic thing" then a block device
driver should be able to use it. It sounds more like it's a
"filesystem-specific thing, not to be used by any module that's
not a filesystem". Well, I don't know what the ideal solution is, 
but I hope I explained how I found the comment misleading. It seems
to me that such bit-ownership disputes may come up again, unless
either the kernel decides who owns it or the comment says that
the bit is used on first-come-first-served basis (and therefore
new module authors must check the whole source tree for previous
uses). Or perhaps, the kernel can just specify that so many bits
are for use at filesystem level, so many next bits for use by
block devices (and so on if there are any other interested parties).
But we can probably just leave all this as is. This discussion
will leave enough of an email-trace for anybody who is serious
to figure out where things stand.

> The "#define BH_IOFailure (BH_PrivateStart + 5) /* jbd.h uses +0 to
> +4 */" 
> is not the cleanest thing in the world, but...

I know :-).   In my original post I expressed an alternative---have
an extra field in ataraid_bh_private structure for this purpose.
But I hate using more space for something that really is just
one bit worth of information (per original IO). 

  Martins Krikis



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
