Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288087AbSACAxr>; Wed, 2 Jan 2002 19:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288049AbSACAwi>; Wed, 2 Jan 2002 19:52:38 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:19217 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288073AbSACAvf>; Wed, 2 Jan 2002 19:51:35 -0500
Date: Wed, 2 Jan 2002 16:55:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Peter Osterlund <petero2@telia.com>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler fixups ...
In-Reply-To: <m24rm4p8xf.fsf@pengo.localdomain>
Message-ID: <Pine.LNX.4.40.0201021652520.1034-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2002, Peter Osterlund wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
> > On 2 Jan 2002, Peter Osterlund wrote:
> >
> > > Davide Libenzi <davidel@xmailserver.org> writes:
> > >
> > > > a still lower ts
> > >
> > > This also lowers the effectiveness of nice values. In 2.5.2-pre6, if I
> > > run two cpu hogs at nice values 0 and 19 respectively, the niced task
> > > will get approximately 20% cpu time (on x86 with HZ=100) and this
> > > patch will give even more cpu time to the niced task. Isn't 20% too
> > > much?
> >
> > The problem is that with HZ == 100 you don't have enough granularity to
> > correctly scale down nice time slices. Shorter time slices helps the
> > interactive feel that's why i'm pushing for this.
>
> OK, but even architectures with bigger HZ values will suffer. Isn't it
> better to set MIN_NICE_TSLICE to a smaller value (such as 1000) and
> fix the calculation in fill_tslice_map to make sure ts_table[i] is
> always non-zero. The current formula will break anyway if
>
>         HZ < 1000000 / MIN_NICE_TSLICE = 100,
>
> but maybe HZ >= 100 is true for all architectures?

Yep, but we can do something like :

static void fill_tslice_map(void)
{
    int i;

    for (i = 0; i < NICE_RANGE; i++) {
        ts_table[i] = ((MIN_NICE_TSLICE +
                        ((MAX_NICE_TSLICE - MIN_NICE_TSLICE) /
                         (NICE_RANGE - 1)) * i) * HZ) / 1000000;
        if (!ts_table[i]) ts_table[i] = 1;
    }
}




- Davide


