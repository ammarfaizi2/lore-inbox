Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292315AbSBBQ2O>; Sat, 2 Feb 2002 11:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292318AbSBBQ2E>; Sat, 2 Feb 2002 11:28:04 -0500
Received: from mailf.telia.com ([194.22.194.25]:33509 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S292315AbSBBQ14>;
	Sat, 2 Feb 2002 11:27:56 -0500
Message-Id: <200202021627.g12GRhM12101@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Errors in the VM - detailed (or is it Tux? or rmap? or those together...)
Date: Sat, 2 Feb 2002 17:24:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0202021635530.10839-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0202021635530.10839-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday den 2 February 2002 16.38, Roy Sigurd Karlsbakk wrote:
> > I have reread the first mail in this series - I would say that Bug#2 is
> > much worse than Bug#1. This since Bug#1 is "only" a performance problem,
> > but Bug#2 is about correctness...
> >
> > Are you 100% sure that tux works with rmap?
>
> Of course not. How can I be sure???
>
> > I would suggest testing the simplest possible case.
> > * Standard kernel
> > * concurrent dd:s
>
> Won't work. Then all I get is (ref prob #1) good throughput until RAMx2
> bytes is read from disk. Then it all falls down to ~1MB/s. See
> http://karlsbakk.net/dev/kernel/vm-fsckup.txt for more details.

How do you know that it gets into this at RAMx2? Have you added 'bi' from
vmstat?

One interesting thing to notice from vmstat is...

r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy id
When performing nicely:
0 200  1   1676   3200   3012 786004   0 292 42034   298  791   745   4  29 67
0 200  1   1676   3308   3136 785760   0   0 44304     0  748   758   3  15 82
0 200  1   1676   3296   3232 785676   0   0 44236     0  756   710   2  23 75
Later when being slow:
0 200  0  3468   3316  4060 784668  0   0  1018    0  613   631   1   2 97
0 200  0  3468   3292  4060 784688  0   0  1034    0  617   638   0   3 97
0 200  0  3468   3200  4068 784772  0   0  1066    6  694   727   2   4 94

No swap activity (si + so == 0), mostly idle (id > 90).
So it is waiting - on what??? timer? disk?

>
> > What can your problem be:
> > * something to do with the VM - but the problem is in several different
> > VMs... * something to do with read ahead? you got some patch suggestions
> > - please use them on a standard kernel, not rmap (for now...)
>
> Then fix the problem rmap11c fixed. I first need that fixed before being
> able to do any further testing!

Roy, did you notice the mail from Andrew Morton:
> heh.  Yep, Roger finally nailed it, I think.
> 
> Roy says the bug was fixed in rmap11c.  Changelog says:
> 
> 
> rmap 11c:
>   ...
>   - elevator improvement                                  (Andrew Morton)
> 
> Which includes:
> 
> -       queue_nr_requests = 64;
> -       if (total_ram > MB(32))
> -               queue_nr_requests = 128;                                    
>                              +       queue_nr_requests = (total_ram >> 9) & 
> ~15;     /* One per half-megabyte */
> +       if (queue_nr_requests < 32)
> +               queue_nr_requests = 32;
> +       if (queue_nr_requests > 1024)
> +               queue_nr_requests = 1024;

rmap11c changed the queue_nr_requests, that problem went away.
But another one showed its ugly head...

Could you please try this part of rmap11c only? Or the very simple one 
setting queue_nr_request to = 2048 for a test drive...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
