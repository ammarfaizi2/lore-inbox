Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271929AbRH2ITZ>; Wed, 29 Aug 2001 04:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271930AbRH2ITP>; Wed, 29 Aug 2001 04:19:15 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:8968 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S271929AbRH2ITF>; Wed, 29 Aug 2001 04:19:05 -0400
Date: Wed, 29 Aug 2001 10:22:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kevin.vanmaren@unisys.com, linux-kernel@vger.kernel.org
Subject: Re: The cause of the "VM" performance problem with 2.4.X
Message-ID: <20010829102216.H640@suse.de>
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F5F@us-slc-exch-3.slc.unisys.com> <200108281852.f7SIqos15325@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108281852.f7SIqos15325@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28 2001, Linus Torvalds wrote:
> >Abbreiated/stripped kernprof/gprof output:
> >------------------------------------------
> >
> >Each sample counts as 0.000976562 seconds.
> >  %   cumulative   self              self     total
> > time   seconds   seconds    calls  ms/call  ms/call  name
> > 39.46    224.65   224.65                             cg_record_arc
> > 16.40    318.00    93.34  6722992     0.01     0.02  getblk
> >  9.02    369.33    51.33 50673121     0.00     0.00  spin_lock_
> >  6.67    407.27    37.95  6722669     0.01     0.01  _make_request
> >  4.51    432.97    25.70 13445261     0.00     0.00  blk_get_queue
> >  2.61    447.83    14.86                             long_copy_user
> >  2.59    462.56    14.72                             mcount
> >  2.06    474.27    11.71                             cpu_idle
> 
> Now, while I don't worry about "getblk()" itself, the request stuff and
> blk_get_queue() _can_ be quite an issue even under non-mkfs load, so

blk_get_queue() is easy to 'fix', it grabs io_request_lock for no good
reason at all. I think this must have been a failed attempt to protect
switching of queues, however it's obviously very broken in this regard.
So in fact no skin is off our nose for just removing the io_request_lock
in that path. 2.5 will have it properly reference counted...

> And your lock profile certainly shows the io_request_lock as a _major_
> lock user, although I'm happy to see that contention seems to be
> reasonably low. Still, I'd bet that it is worth working on..

Sure is, the bio patches have not had io_request_lock in them for some
time.

-- 
Jens Axboe

