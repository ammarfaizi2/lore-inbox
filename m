Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbQLVCXA>; Thu, 21 Dec 2000 21:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131571AbQLVCWu>; Thu, 21 Dec 2000 21:22:50 -0500
Received: from hermes.mixx.net ([212.84.196.2]:30481 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131528AbQLVCWc>;
	Thu, 21 Dec 2000 21:22:32 -0500
Message-ID: <3A42B353.D0D249C1@innominate.de>
Date: Fri, 22 Dec 2000 02:50:11 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Cassella <pwc@sgi.com>, Tim Wright <timw@splhi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <3A42380B.6E9291D1@sgi.com> <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cassella wrote:
> The sync variable version of the dmabuf code snippet (assuming the
> dmabuf_mutex is never acquired from an interrupt) would look like this:
> 
>     dmabuf_init(...);
>     {
>             ...
>             spin_lock_init(&dmabuf_spin);
>             sv_init(&dmabuf_sv, &dmabuf_spin, SV_MON_SPIN);
>             ...
>     }
> 
>     dmabuf_alloc(...)
>     {
> 
>             ...
>             while (1) {
>                     spin_lock(&dmabuf_spin);
>                     attempt to grab a free buffer;
>                     if (success){
>                             spin_unlock(&dmabuf_spin);
>                             return;
>                     } else {
>                             sv_wait(&dmabuf_sv);
>                     }
>             }
>     }
> 
>     dmabuf_free(...)
>     {
>             ...
>             spin_lock(&dmabuf_spin);
>             free up buffer;
>             sv_broadcast(&dmabuf_sv);
>             spin_unlock(&dmabuf_spin);
>     }
> 

But isn't this actually a simple situation?  How about:

    dmabuf_alloc(...)
    {
            ...
            while (1) {
                    spin_lock(&dmabuf_lock);
                    attempt to grab a free buffer;
                    spin_unlock(&dmabuf_lock);
                    if (success)
                           return;
                    down(&dmabuf_wait);
            }
    }

    dmabuf_free(...)
    {
            ...
            spin_lock(&dmabuf_lock);
            free up buffer;
            spin_unlock(&dmabuf_lock);
            up(&dmabuf_wait);
    }

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
