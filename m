Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTBSSXM>; Wed, 19 Feb 2003 13:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTBSSXM>; Wed, 19 Feb 2003 13:23:12 -0500
Received: from [63.205.85.133] ([63.205.85.133]:40196 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S263544AbTBSSXL>;
	Wed, 19 Feb 2003 13:23:11 -0500
Date: Wed, 19 Feb 2003 10:33:06 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@locutus.cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore
Message-ID: <20030219103305.G37577@sfgoth.com>
References: <1045630056.10926.4.camel@rth.ninka.net> <200302190501.h1J511Gi002225@locutus.cmf.nrl.navy.mil> <20030218.205325.14347725.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20030218.205325.14347725.davem@redhat.com>; from davem@redhat.com on Tue, Feb 18, 2003 at 08:53:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: chas williams <chas@locutus.cmf.nrl.navy.mil>
>    Date: Wed, 19 Feb 2003 00:01:01 -0500
>    
>    we (meaning some folks here at nrl) already maintain a seperate 
>    kernel with atm 'enhancements' locally.  we are very interested in keeping
>    linux-atm alive (particularly in the linux kernel) and extending it
>    as well.  i would take the role of maintainer for atm if no one truly
>    wants it.
>    
> This is the situation.
> 
> Therefore, please send me a patch to add an appropriate entry
> to linux/MAINTAINERS.

Yes, Chas and I have already been discussing moving the maintainership.
Previously his work has been concentrated on 2.4 but now he's porting
his updates to 2.5 and will be taking over maintenence of the kernel stuff.

As for the locking issues a semaphore is probably the best thing to use
at the moment.  The *correct* fix would be to have atm_dev's and atm_vcc's
be reference counted instead so the card's interrupt handlers can safely
work with them.  This has been well understood for awhile and I was planning
on implementing it about a year ago for 2.5 but I've had basically zero time
to devote to linux-atm these days (sorry)  Maybe Chas or I or someone will
do it for 2.7.  The bad part isn't the atm core code (I could probably do
that myself in a day) but it would require overhaul of a lot of the ATM
drivers.  Some of the drivers are pretty scary.

(Side note: basically linux-atm was originally written before SMP support
existed and made heavy use of cti/sti to make sure the dev's and vcc's
didn't change underneath the drivers.  Later these became largely spinlocks
but they never really became SMP safe - even though the core code would
have proper SMP-exclusion we could have the card doing rx an atm_vcc
on one CPU while another was closing it.

There's some stream-of-consiousness comments about this that I wrote a
long time ago in drivers/atm/lanai.c around line 616.  They're not 100%
correct - I was planning on researching the issue more before submitting
that driver for inclusion into the tree but it lanai.c eventually got
submitted by someone else without asking me first)

-Mitch
