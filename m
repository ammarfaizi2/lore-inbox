Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTL2Qgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTL2Qgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:36:32 -0500
Received: from 12-229-138-12.client.attbi.com ([12.229.138.12]:51329 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S263646AbTL2Qga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:36:30 -0500
Message-ID: <3FF0580C.5070604@comcast.net>
Date: Mon, 29 Dec 2003 08:36:28 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net> <3FEFDE4A.1030208@wmich.edu>
In-Reply-To: <3FEFDE4A.1030208@wmich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> In your patch here i think the person who made the code originally
> confused or got wrong the conditions of success for opening the cdrom
> drive. This is in the same function as the patch applies to.
> 
>        if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS))
>                 ret = cdi->ops->open(cdi, 1);
>         else
>                 ret = open_for_data(cdi);
> 
> 
>         if (!ret) cdi->use_count++;

Doesn't this increment it if the call succeeds? In open_for_data, ret is the
return code from the open call, which should be zero upon success. Problem is,
we already incremented it when we entered cdrom_open.

> 
> Here we see that if the open fails we incriment our use_count.  But this
> doesn't make sense. We increment the use_count at the  beginning of the
> function as a "lock" so that we can't do anything while the open
> function is executing like rmmod the cdrom (supposedly?).  Now removing
> the if(!ret) line makes sense. Under the out: label, if the open fails,
> then we close our makeshift lock on the device because our function is
> done. If it succeeded, then the use_count stays at 1 we go along our
> merry way.
> 

Yeah, my patch is just a hack :)  Not really for general use i think, but it
allows me to open the door using the button. The cdrom.c from test11-mm1 never
incremented use_count until after the success of one of the preceeding calls. I
was just undoing the original increment that now happens upon entering
cdrom_open. The use_count does control the door lock though. If you look under
cdrom_release, the door unlock code never gets executed until use_count=0. I
haven't checked overall operation of my cdrom drives enough to know what else is
wrong.

-Walt


