Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTL2GXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 01:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTL2GXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 01:23:48 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:60148 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262772AbTL2GXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 01:23:44 -0500
Message-ID: <3FEFC86E.9050307@wmich.edu>
Date: Mon, 29 Dec 2003 01:23:42 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net>
In-Reply-To: <3FEFA36A.5050307@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walt H wrote:
> Ed Sweetman wrote:
> 
>>I'd have to say the december 17th listed changes are the culprit here.
>>I'm definitely not up to figuring out what change is the bad one.  If
>>any of the cdrom/ide-cd people wanna have me get some data from them
>>then just tell me how.  I've tried viewing the debug output from the
>>modules with no success in figuring out the problem.
>>
>>

> 
> Luckily for me, I built my cdrom drivers as modules, so I could play :)

so did i. I looked at the debugging output and noticed the increments 
increasing. This had no effect on me unloading the module so i didn't 
care. It also should have nothing to do with not being able to eject it 
since being unable to eject would imply that the door is locked, in 
which case the command "eject" should also fail but it does not. I think 
the kernel is really really fubarred since the dec 17th patches dealing 
with ide-cd.  My cd writer is no longer able to write in atapi direct 
mode because the driver isn't giving it the capabalities it should have. 
It's being shown as a simple cdrom as far as the kernel is concerned. 
Also, the drive throws errors about being unable to access sector 0, as 
many others have pointed out. This is an error that should be caught 
prior to actually sending such a command since media is not in the drive 
in the first place.

It's definitely not up to me but i would roll back the cdrom and ide-cd 
changes from dec 17th and re-add them much more carefully because 
something is really messed up.

cdrecord is showing the TOC as just CdRom and reports the drive as 
readonly.  That's about all the irregular information i can find on my 
own. I dont know where to look for anything else, the cdrom debugging 
output doesn't report anything irregular except for the behavior 
described below and that really doesn't help me with anything except to 
prove that the patches that went in last are the cause of the problem, 
not necessarily famd's hackish behavior or hardware.

> I turned on debugging, and noticed that cdi->use_count continues to increment by
> 2 for each access. In cdrom_release, only one cdi->use_count-- exists, so the
> driver never gets to 0 use count and releases. I noticed in
> drivers/cdrom/cdrom.c line 753:
> 
>         if (!ret) cdi->use_count++;
> 
> Which is our second increment, but I can't find two decrements, because the
> check further down won't ever be true if the above is true. Hence, two
> increments and only 1 dec when we reach cdrom_release. What I did, was add a
> conditional decrement right before the open_for_data call, which makes the value
> of use_count like it used to be prior to the Mt. Rainier patches. Seems kinda
> hacky :)
> 
> -Walt
> 
> --- /usr/src/linux/drivers/cdrom/cdrom.c        2003-12-25 09:53:59.000000000 -0800
> +++ linux-2.6.0-mm1/drivers/cdrom/cdrom.c       2003-12-28 19:42:04.174098225 -0800
> @@ -744,4 +744,7 @@
>         }
> 
> +       if (cdi->use_count > 0)
> +               cdi->use_count--;
> +
>         /* if this was a O_NONBLOCK open and we should honor the flags,
>          * do a quick open without drive/disc integrity checks. */
> @@ -931,5 +934,5 @@
>         struct cdrom_device_ops *cdo = cdi->ops;
> 
> -       cdinfo(CD_CLOSE, "entering cdrom_release\n");
> +       cdinfo(CD_CLOSE, "entering cdrom_release\n");
> 
>         if (cdi->use_count > 0)
> 

