Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271112AbRIFPCG>; Thu, 6 Sep 2001 11:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271106AbRIFPB5>; Thu, 6 Sep 2001 11:01:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:10417 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271105AbRIFPBr>;
	Thu, 6 Sep 2001 11:01:47 -0400
Date: Thu, 06 Sep 2001 16:02:04 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, riel@conectiva.com.br, jaharkes@cs.cmu.edu,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <598034578.999792124@[10.132.112.53]>
In-Reply-To: <20010906163909.186b8b46.skraw@ithnet.com>
In-Reply-To: <20010906163909.186b8b46.skraw@ithnet.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,

>> Yes, but this is because VM system's targets & pressure calcs do not
>> take into account fragmentation of the underlying physical memory.
>> IE, in theory you could have half your memory free, but
>> not be able to allocate a single 8k block. Nothing would cause
>> cache, or InactiveDirty stuff to be written.
>
> Which is obviously not the right way to go. I guess we agree in that.

Well, I agree that this is not desirable. I am not sure whether
the right course is
 (a) to avoid getting here,
 (b) to do traditional page_launder() stuff, i.e. write stuff out,
     and hope that fixes it
 (c) to actively go defragment (Daniel P's prefered approach)
 (d) some combination of the above.

>> You yourself proved this, by switching rsize,wsize to 1k and said
>> it all worked fine! (unless I misread your email).
>
> Sorry, misunderstanding: I did not touch rsize/wsize. What I do is to lower fs
> action by not letting knfsd walk through the subtrees of a mounted fs. This
> leads to less allocs/frees by the fs layer which tend to fail and let knfs fail
> afterwards.

OK, I'm getting confused.

I'm looking at stuff you sent like:
Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec826>] [<fdcec8f5>] [<fdceb7d7>]
Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444]
Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944]
Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532]
Aug 29 13:43:34 admin kernel:    [system_call+51/56]
Aug 29 13:43:34 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).

If you use rsize=1024,wsize=1024, (note you may have to force
this at the client end), you should not see, at least from NFS,
allocations at greater than order 0. So if the problem is /just/
fragmentation (rather than too little memory), it will magically
go away (i.e. be hidden). If it's not just fragmentation, you
will still see errors. This is not intended as a solution, but
as a diagnostic tool. [I mistakenly thought/dreamed you had
already done this].

Note there may still be other things trying to do >0 order
allocs, for instance bounce buffers, but I believe you have
applied useful patches for them already.

--
Alex Bligh
