Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTL2Dpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTL2Dpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:45:49 -0500
Received: from 12-211-64-253.client.attbi.com ([12.211.64.253]:61081 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262652AbTL2Dpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:45:47 -0500
Message-ID: <3FEFA36A.5050307@comcast.net>
Date: Sun, 28 Dec 2003 19:45:46 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu>
In-Reply-To: <3FEF8BB1.6090704@wmich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> I'd have to say the december 17th listed changes are the culprit here.
> I'm definitely not up to figuring out what change is the bad one.  If
> any of the cdrom/ide-cd people wanna have me get some data from them
> then just tell me how.  I've tried viewing the debug output from the
> modules with no success in figuring out the problem.
> 
> 

Luckily for me, I built my cdrom drivers as modules, so I could play :)
I turned on debugging, and noticed that cdi->use_count continues to increment by
2 for each access. In cdrom_release, only one cdi->use_count-- exists, so the
driver never gets to 0 use count and releases. I noticed in
drivers/cdrom/cdrom.c line 753:

        if (!ret) cdi->use_count++;

Which is our second increment, but I can't find two decrements, because the
check further down won't ever be true if the above is true. Hence, two
increments and only 1 dec when we reach cdrom_release. What I did, was add a
conditional decrement right before the open_for_data call, which makes the value
of use_count like it used to be prior to the Mt. Rainier patches. Seems kinda
hacky :)

-Walt

--- /usr/src/linux/drivers/cdrom/cdrom.c        2003-12-25 09:53:59.000000000 -0800
+++ linux-2.6.0-mm1/drivers/cdrom/cdrom.c       2003-12-28 19:42:04.174098225 -0800
@@ -744,4 +744,7 @@
        }

+       if (cdi->use_count > 0)
+               cdi->use_count--;
+
        /* if this was a O_NONBLOCK open and we should honor the flags,
         * do a quick open without drive/disc integrity checks. */
@@ -931,5 +934,5 @@
        struct cdrom_device_ops *cdo = cdi->ops;

-       cdinfo(CD_CLOSE, "entering cdrom_release\n");
+       cdinfo(CD_CLOSE, "entering cdrom_release\n");

        if (cdi->use_count > 0)



