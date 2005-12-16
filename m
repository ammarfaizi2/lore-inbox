Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVLPSHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVLPSHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVLPSHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:07:46 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:35980 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751325AbVLPSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:07:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christian Trefzer <ctrefzer@gmx.de>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Date: Fri, 16 Dec 2005 19:08:56 +0100
User-Agent: KMail/1.9
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <200512072246.06222.rjw@sisk.pl> <20051216101623.GA7878@suse.de> <20051216142543.GA20069@zeus.uziel.local>
In-Reply-To: <20051216142543.GA20069@zeus.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161908.56635.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 16 December 2005 15:26, Christian Trefzer wrote:
> On Fri, Dec 16, 2005 at 11:16:23AM +0100, Stefan Seyfried wrote:
> > This is almost trivially solvable from userspace (not tested, beware :-):
> > - check the return code of your write() to /sys/power/state
> > - if it is ENOMEM (better look into the kernel code if this is what is
> >   actually reported...), then write "0" to image_size and try again.
> > 
> > or (not as sophisticated, and i am not sure if the paths are all correct):
> > ----
> > #!/bin/sh
> > echo 150  > /sys/power/image_size
> > echo disk > /sys/power/state
> > if [ $? -ne 0 ]; then
> >     echo 0 > /sys/power/image_size
> >     echo disk > /sys/power/state
> > fi
> > ----
> > this will retry on any error (e.g. process not stopped, no swap space
> > at all, device refused to suspend...) not only on ENOMEM, but echo
> > unfortunately does not return the error code, only success or failure.
> > Easy solution would be a small perl or C program.
> > 
> > I am not convinced that this should be handled in the kernel.
> 
> I do not see a horrific logical problem here, given that the maximum
> desired image size is the minimum of max_image_size and free swap space
> available. The main question is the one of implementation, though.

The problem is the free swap space is not constant as long as you are
trying to free more RAM, because some pages can get swapped out in the
process at any time.

To handle this properly we would have to count the amount of free swap in
every iteration of the loop in swsusp_shrink_memory(), but I wouldn't like
to make this function swap-dependent.

We are going to move the image-writing and reading functionality of swsusp
to the user space anyway and the userspace process controlling the suspend
will solve this problem.  For now, please use workarounds like the Stefan's
one.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
