Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRCTTvq>; Tue, 20 Mar 2001 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbRCTTvh>; Tue, 20 Mar 2001 14:51:37 -0500
Received: from james.kalifornia.com ([208.179.59.2]:10544 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130660AbRCTTvW>; Tue, 20 Mar 2001 14:51:22 -0500
Message-ID: <3AB7B477.2A740CE0@blue-labs.org>
Date: Tue, 20 Mar 2001 11:50:15 -0800
From: David Ford <david@blue-labs.org>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Lund <firefly@netgroup.dk>
CC: Pozsar Balazs <pozsy@sch.bme.hu>, linux-kernel@vger.kernel.org
Subject: Re: esound (esd), 2.4.[12] chopped up sound -- solved
In-Reply-To: <Pine.GSO.4.30.0103201832260.15849-100000@balu> <3AB7A2CB.64ED61F3@netgroup.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually you probably upgraded to a non-broken version of esd.  Stock esd -still-
writes to the socket without regard to return value.  If the write only accepted
2098 of 4096 bytes, the residual bytes are lost, esd will write the next packet at
4097, not 2099.  esd is incredibly bad about err checking as is old e stuff.

I posted my last patch for esd here and to other places in June of 2000.  All it
does is check for return value and adjust the writes accordingly.  For reference,
the patch is at http://stuph.org/esound-audio.c.patch.

-d

Peter Lund wrote:

> Pozsar Balazs wrote:
>
> > Are you sure that the problem isn't at the mp3->raw conversino point? In
> > mandrake for example, mpg123 is badly compiled, and plays nicely on 2.2,
> > but awfully on 2.4.
>
> Positive.  Anyway, the problem is solved now...I just want to investigate it a
> little bit further because I think there is something I can learn from it.
>
> In my original mail I wrote:
>
> > I've tested it on a freshly booted machine without X and gnome, only the bare
> > essentials for the machine + esd + esdcat (I converted one of my mp3's into raw
> > audio for the test).
>
> 1) mpg123 and XMMS sounded fine under 2.2.18 (which I hope was clear from what I
> wrote).
> 2) I played the raw sound directly to /dev/dsp -- worked great
> 3) I played it through esd on 2.2.18 -- worked great
>  (the latter two points should have been made explicitly but weren't - sorry)
>
> so the conclusion is that there is some bad interaction between 2.4.x, the esd
> version I was using, and the esdcat version I was using.   esdcat seemed pretty
> simple, it just
> wrote 4K at a time to a Unix socket, blocking as necessary, so I figured the
> culprit was elsewhere.
>
> The problem went away when I upgraded to the esd in Debian unstable (in the
> esound package).  I was either using an esd binary from Debian stable or one
> from one of the Ximian packages.  I'm still not sure whether they supply an esd
> themselves or just rely on the standard Debian one.
>
> I took a look at the diff between the stable/testing and unstable versions of
> the Debian esound package and there was a change in two or three places that
> seems to give a plausible explanation.  A simple write() was changed into a loop
> that retried the write() in case it was partial with an error code of EAGAIN
> (after sleeping 100 microseconds and with an upper bound on the number of
> retries).
>
> My theory now is that the sound driver changed in some way from 2.2.x to 2.4.x
> so some writes would only move a limited amount of bytes to the driver.  Maybe
> the driver only accepts about 4K in each version and the kernel performs the
> retries, sleeping in between?  Just a theory until I know more.
>
> Anyway, it works now with 2.4.x, even without the lowlatency patch from Andrew
> Morton.
>
> -Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



