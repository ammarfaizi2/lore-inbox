Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289193AbSAVH7W>; Tue, 22 Jan 2002 02:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289188AbSAVH7D>; Tue, 22 Jan 2002 02:59:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63506 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289184AbSAVH6z>;
	Tue, 22 Jan 2002 02:58:55 -0500
Date: Tue, 22 Jan 2002 08:58:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Vojtech Pavlik <vojtech@suse.cz>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020122085841.I1018@suse.de>
In-Reply-To: <F9158D81E5D@vcnet.vc.cvut.cz> <Pine.LNX.4.10.10201211442190.15703-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201211442190.15703-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Andre Hedrick wrote:
> In PIO there is no scatter gather possible without a memcpy to a
> contigious buffer period.  Therefore under the contstraints issued bu

Why?

> Linus and Jens, of access to one 4k page of memory, and a forced
> requirement to return back every 4k page of memory of completion prevents
> one from ever transaction more than 8 sectors per request in PIO any mode.

You don't understand... It's not forced, it's just _the sane way to do
it_. When you finish I/O on a chunk of data, end I/O on that chunk of
data. This doesn definitely _not_ prevent transaction of more than 8
sectors per request, that's nonsense. It's only that way in the current
kernel because it was easy to get right the first time around. And it's
only in multi-write, oh look at multi-read, that does 16 sectors at the
time. Weee!

> start_request_sectors (255 sectors) max
> 
> make_request (start_request_sectors())
> 
> 	do_request()
> 	ide-disk get (255 sectors)
> 		block truncates to 8 sectors max
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Wrong

> 	ide-taskfile
> 		transfers 8 sectors max
                ^^^^^^^^^^^^^^^^^^^^^^^

Wrong

> 		end request (return 247 sectors)
> 
> upate_request(247 to be re issued, + additional max of 8)	

end_request _is_ the update request. You seem to not understand that
calling ide_end_request does not mean that we are terminating the
request from the host side, we are merely asking the block layer to
complete xxx amount of sectors for us so we can continue doing the
request residual.

> 	make_request (247 to be re issued, + additional max of 8)

Very wrong, make_request is never called here. Let me out line what
happens. Do you really mean start_request, if so then yes.

> This is why I am going to request for backing out again because the BLOCK
> API without a MID-LAYER to buffer against the goal of the kernel,
> conflicts with the hardware rules requirements.  Until a satisfactory

end_that_request_first understands partial completion of any size in
2.5, what more of a mid layer do you want?

> agreement can be reached then the current direction it is going will trash
> the Virtual DMA hardware coming in the future.

Is that so?

-- 
Jens Axboe

