Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSCFE2J>; Tue, 5 Mar 2002 23:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293205AbSCFE2B>; Tue, 5 Mar 2002 23:28:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:64782 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293208AbSCFE1r>; Tue, 5 Mar 2002 23:27:47 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 20:31:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <3C859909.30602@candelatech.com>
Message-ID: <Pine.LNX.4.44.0203052024540.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Ben Greear wrote:

>
>
> Davide Libenzi wrote:
>
> > On Tue, 5 Mar 2002, Ben Greear wrote:
> >
> >
> >>I have a program that I very often need to calculate the current
> >>time, with milisecond accuracy.  I've been using gettimeofday(),
> >>but gprof shows it's taking a significant (10% or so) amount of
> >>time.  Is there a faster (and perhaps less portable?) way to get
> >>the time information on x86?  My program runs as root, so should
> >>have any permissions it needs to use some backdoor hack if that
> >>helps!
> >>
> >
> > If you're on x86 you can use collect rdtsc samples and convert them to ms.
> > You'll get even more then ms accuracy.
>
>
> Can I do this from user space?  If so, any examples or docs
> you can point me to?
>
> Also, I'm looking primarily for a speed increase, not an accuracy
> increase.


    #include <linux/timex.h>


    unsigned long long mscurr;
    cycles_t cys, cye, mscycles;
    struct timespec ts1, ts2;

    clock_gettime(CLOCK_REALTIME, &ts1);
    cys = get_cycles();
    sleep(1);
    clock_gettime(CLOCK_REALTIME, &ts2);
    cye = get_cycles();
    mscycles = (cye - cys) / ((ts2.tv_sec - ts1.tv_sec) * 1000 +
		(ts2.tv_nsec - ts1.tv_nsec) / 1000000);



    mscurr = ts2.tv_sec * 1000 + ts2.tv_nsec * 1000000 + (get_cycles() - cye) / mscycles;





- Davide


