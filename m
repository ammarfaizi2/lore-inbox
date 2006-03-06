Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWCFWoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWCFWoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWCFWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:44:07 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:50451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932422AbWCFWoG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:44:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YzpdjTWAhvCiKSjKu1RdMqL/qRKPEboqa5HZlDuoJ1T+Pju/LskifFsA60O1vkuK88Q9cBeMwGDFfQemo4ZJowth4vf4+8sfnhHfiOsBRnjtCwCyW8N8acT/lAB4SpeFNedfhVVC5xbs16aGwxPKz3EH+xc5gbbyeGJ9/k9VBos=
Message-ID: <9a8748490603061444s68da6baejcf5fa12b5368fe8@mail.gmail.com>
Date: Mon, 6 Mar 2006 23:44:05 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 6 Mar 2006, Jesper Juhl wrote:
> >
> > Ok, booting a plain 2.6.16-rc5-mm2 kernel with the above being the
> > only change made results in this :
>
> Yeah. I'm not surprised. A real mode-sense shouldn't be even 64 bytes,
> much less 96, so it shouldn't have overflowed, and we had no indication of
> the corruption spreading past the one allocation anyway.
>
> It did/does seem a bug, though, so worth checking.
>
Well, hopefully the SCSI people can take a look at that as a seperate issue...


> So onward in our tireless battle. Does this patch make any difference for
> you? It does two things:
>
>  - it clears the "->sense" buffer in blk_end_sync_rq() (since it won't be
>    valid any more: the request is gone)
>  - it adds a BUG_ON() if we appear to have already done the sense fill on
>    SCSI IO completion, and do it again.
>
> Now, I've not tried either of these, and the BUG_ON() in particular might
> be a false positive itself, but it might be worth testing.
>

Unfortunately this doesn't seem to make a difference :

Slab corruption: start=f70c0770, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934fb>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f70c0724, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813e6>](free_fdtable_rcu+0x66/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f70c07bc, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813ee>](free_fdtable_rcu+0x6e/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=f70c0770, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934fb>](sr_do_ioctl+0x11b/0x270)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f70c0724, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813e6>](free_fdtable_rcu+0x66/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f70c07bc, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813ee>](free_fdtable_rcu+0x6e/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
