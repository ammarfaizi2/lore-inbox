Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278615AbRKFHZ1>; Tue, 6 Nov 2001 02:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRKFHZR>; Tue, 6 Nov 2001 02:25:17 -0500
Received: from unthought.net ([212.97.129.24]:22745 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S278617AbRKFHZC>;
	Tue, 6 Nov 2001 02:25:02 -0500
Date: Tue, 6 Nov 2001 08:25:01 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106082501.B1588@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net> <20011105144112.Q11619@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20011105144112.Q11619@pasky.ji.cz>; from pasky@pasky.ji.cz on Mon, Nov 05, 2001 at 02:41:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 02:41:12PM +0100, Petr Baudis wrote:
> Hi,
> 
> > We want to avoid these problems:
> >  1)  It is hard to parse (some) /proc files from userspace
> >  2)  As /proc files change, parsers must be changed in userspace
> > 
> > Still, we want to keep on offering
> >  3)  Human readable /proc files with some amount of pretty-printing
> >  4)  A /proc fs that can be changed as the kernel needs those changes
> 
>   I've read the whole thread, but i still don't get it. Your solution doesn't
> improve (1) for parsers in scripting languages, where it is frequently far
> easier to parse ASCII stuff than messing with binary things, when not almost
> impossible. So we don't make any progress here.  And for languages like C,
> where this will have most use, there actually is solution and it is working.
> So, please, can you enlighten me, what's so wrong on sysctl? It actually
> provides exactly what do you want, and you even don't need to bother yourself
> with open() etc ;). So it would be maybe better improving sysctl interface,
> especially mirroring of all /proc stuff there, instead of arguing about scanf()
> :-).
> 
>   So can you please explain me merits of your approach against sysctl?

As far as I can see, I cannot read /proc/[pid]/* info using sysctl.

Then I need the other /proc/* files as well, not just /proc/sys/*

It seems to me that the sysctl interface does not have any type checking,
so if for example I want to read the jiffies counter and supply a 32-bit
field, sysctl will happily give me the first/last 32 bits of a field that
could as well be 64 bits (bit widths do sometimes change, even on architectures
that do not change).   How am I to know ?

If you look in kernel/sysctl.c, you'll see code like 

if (oldval && oldlenp) {
        get_user(len, oldlenp);
        if (len) {
                if (len > table->maxlen)
                        len = table->maxlen;
                if(copy_to_user(oldval, table->data, len))
                        return -EFAULT;
                if(put_user(len, oldlenp))
                        return -EFAULT;
        }
}
if (newval && newlen) {
        len = newlen;
        if (len > table->maxlen)
                len = table->maxlen;
        if(copy_from_user(table->data, newval, len))
                return -EFAULT;
}

Now is that pretty or what - Imagine someone trying to configure a 64-bit
kernel parameter with a 32 bit value   ;)

This could be tightened up of course - but the problem of knowing which
unit some number may be represented in is still there.  For example,
assuming I could read out partition sizes, well are they in blocks, bytes,
kilobytes, or what ?    Oh, I'm supposed to *know*, and *assume* such things
never change ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
