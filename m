Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSEVEdy>; Wed, 22 May 2002 00:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSEVEdx>; Wed, 22 May 2002 00:33:53 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:22433 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S316851AbSEVEdw>; Wed, 22 May 2002 00:33:52 -0400
Date: Tue, 21 May 2002 21:33:03 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: What to do with all of the USB UHCI drivers
 in the kernel ?
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <3CEB1F7F.4000000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
In-Reply-To: <5.1.0.14.2.20020521133408.068d2ef8@mail1.qualcomm.com>
 <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com>
 <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com>
 <20020521195925.GA2623@kroah.com>
 <5.1.0.14.2.20020521133408.068d2ef8@mail1.qualcomm.com>
 <5.1.0.14.2.20020521164157.06b68430@mail1.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim (Max) Krasnyanskiy wrote:
> 
> One-shot interrupt transfers are broken in *-hcd drivers. core/hcd.c 
> returns EINVAL if urb->interval==0.

Hmm, eventually that automagic resubmit model needs to go away,
in favor of a straight queued transfer model -- where in effect
there are _only_ "one shot" transfers, which for interrupts are
just going to hang out on endpoint queues that are properly
scheduled.  That's needed to make interrupt reads and writes
have the same transfer model ... right now interrupt OUT transfers
don't work very well.  (And they'll be the most common type when
we eventually get those device/target side driver APIs sorted.)

Meanwhile, I suppose I can see wanting access to that UHCI-ism.
However your patch would do that wrong, since it should only
apply to interrupt transfers.


> usb-uhci-hcd has to be fixed.
> btw It tries to round interval value even thought it's done by hcd.c

That was one of my quick-review comments too.  It doesn't hurt,
it's just one of several URB sanity-check/preprocessing steps
that doesn't need to be in every driver.


> On a side note. Why are URBs still not SLABified ?

Hasn't seemed to be necessary.  kmalloc() is slabified already,
so it's not clear that a control/bulk/interrupt URB pool shared
between drivers -- size, maybe a handful -- would be better than
sharing that same memory with other kernel code.

- Dave





