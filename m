Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130686AbRCTSkF>; Tue, 20 Mar 2001 13:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130721AbRCTSjy>; Tue, 20 Mar 2001 13:39:54 -0500
Received: from secure.webhotel.net ([195.41.202.80]:51468 "HELO
	secure.webhotel.net") by vger.kernel.org with SMTP
	id <S130686AbRCTSjn>; Tue, 20 Mar 2001 13:39:43 -0500
X-Authenticated-Timestamp: 19:42:22(CET) on March 20, 2001
Message-ID: <3AB7A2CB.64ED61F3@netgroup.dk>
Date: Tue, 20 Mar 2001 19:34:51 +0100
From: Peter Lund <firefly@netgroup.dk>
Organization: NetGroup A/S
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@sch.bme.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: esound (esd), 2.4.[12] chopped up sound -- solved
In-Reply-To: <Pine.GSO.4.30.0103201832260.15849-100000@balu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:

> Are you sure that the problem isn't at the mp3->raw conversino point? In
> mandrake for example, mpg123 is badly compiled, and plays nicely on 2.2,
> but awfully on 2.4.

Positive.  Anyway, the problem is solved now...I just want to investigate it a
little bit further because I think there is something I can learn from it.


In my original mail I wrote:

> I've tested it on a freshly booted machine without X and gnome, only the bare
> essentials for the machine + esd + esdcat (I converted one of my mp3's into raw
> audio for the test).

1) mpg123 and XMMS sounded fine under 2.2.18 (which I hope was clear from what I
wrote).
2) I played the raw sound directly to /dev/dsp -- worked great
3) I played it through esd on 2.2.18 -- worked great
 (the latter two points should have been made explicitly but weren't - sorry)

so the conclusion is that there is some bad interaction between 2.4.x, the esd
version I was using, and the esdcat version I was using.   esdcat seemed pretty
simple, it just
wrote 4K at a time to a Unix socket, blocking as necessary, so I figured the
culprit was elsewhere.

The problem went away when I upgraded to the esd in Debian unstable (in the
esound package).  I was either using an esd binary from Debian stable or one
from one of the Ximian packages.  I'm still not sure whether they supply an esd
themselves or just rely on the standard Debian one.

I took a look at the diff between the stable/testing and unstable versions of
the Debian esound package and there was a change in two or three places that
seems to give a plausible explanation.  A simple write() was changed into a loop
that retried the write() in case it was partial with an error code of EAGAIN
(after sleeping 100 microseconds and with an upper bound on the number of
retries).

My theory now is that the sound driver changed in some way from 2.2.x to 2.4.x
so some writes would only move a limited amount of bytes to the driver.  Maybe
the driver only accepts about 4K in each version and the kernel performs the
retries, sleeping in between?  Just a theory until I know more.

Anyway, it works now with 2.4.x, even without the lowlatency patch from Andrew
Morton.

-Peter
