Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314265AbSDRH6Q>; Thu, 18 Apr 2002 03:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSDRH6P>; Thu, 18 Apr 2002 03:58:15 -0400
Received: from unthought.net ([212.97.129.24]:24782 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S314265AbSDRH6O>;
	Thu, 18 Apr 2002 03:58:14 -0400
Date: Thu, 18 Apr 2002 09:58:13 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: davem@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020418095813.A28396@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Hirokazu Takahashi <taka@valinux.co.jp>, davem@redhat.com,
	ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020414.212308.33849971.davem@redhat.com> <20020416.100302.129343787.taka@valinux.co.jp> <20020416034120.R18116@unthought.net> <20020418.140155.85418444.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 02:01:55PM +0900, Hirokazu Takahashi wrote:
> Hi,
> 
> I've been thinking about your comment, and I realized it was a good
> suggestion.
> There are no problem with the zerocopy NFS, but If you want to
> use UDP sendfile for streaming or something like that, you wouldn't
> get good performance.

Hi again,

So the problem is, that it is too easy to use UDP sendfile "poorly", right?

Your NFS threads don't have the problem because you make sure that pages are in
core prior to the sendfile call, but not every developer may think that far...

...
> 
> Shall I make a multiple queue based on pid instead of destitation address ?
> Any idea is welcome!

Ok, so here's some ideas. I'm no expert so if something below seems subtle,
it's more likely to be plain stupid rather than something really clever  ;) 


In order to keep sendfile as simple as possible, perhaps one could just make
it fail if not all pages are in core.

So, your NFS send routine would be something like


retry:
  submit_read_requests
  await_io_completion

  rc = sendfile(..)
  if (rc == -EFAULT)
    goto retry

(I suppose even the retry is optional - this being UDP, the packet could be
 dropped anywhere anyway. The rationale behind retrying immediately is, that
 "almost" all pages probably are in core)

That would keep sendfile simple, and force it's users to think of a clever
way to make sure the pages are ready (and about what to do if they aren't).


This is obviously not something one can do from userspace. There, I think that
your suggestion with a queue per pid seems like a nice solution.  What I worry
about is, if the machine is under heavy memory pressure and the queue entries
start piling up - if sendfile is not clever (or somehow lets the VM figure out
what to do with the requests), the queues will be competing against eachother,
taking even longer to finish...

Perhaps userspace would call some sendfile wrapper routine that would do the
queue management, while kernel threads that are sufficiently clever by
themselves will just call the lightweight sendfile.

Or, will the queue management be simpler and less dangerous than I think ?  :)


Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
