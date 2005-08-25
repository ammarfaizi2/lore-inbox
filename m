Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVHYNkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVHYNkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVHYNkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:40:53 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:3680 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964979AbVHYNkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:40:52 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
In-Reply-To: <1124972307.6307.30.camel@localhost>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 09:40:53 -0400
Message-Id: <1124977253.5039.13.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 14:18 +0200, Johannes Berg wrote:
> Hi,
> 
> > I have also observed another problem with inotify with dovecot - so I spoke 
> > with Johannes Berg who wrote the inotify code in dovecot.  He suggested I post 
> > here to LKML since his opinion is that this to be a kernel bug.
> 
> Allow me to jump in at this point. The small tool below triggers this
> problem for Reuben (confirmed via private mail) but works fine for me on
> 2.6.13-rc6.

On 2.6.13-rc7 the test program fails. It always fails when a wd == 1024.
If I skip inotify_rm_watch when wd == 1024, it will fail at wd == 2048.
It seems the idr layer has an aversion to multiples of 1024.

When I run your test program I get this a lot:

inotify_add_watch returned wd1 5
inotify_add_watch returned wd2 6
inotify_add_watch returned wd1 6
inotify_add_watch returned wd2 7

The pattern of 

add_watch wd1 = X
add_watch wd2 = X+1
rm_watch X
rm_watch X+1
add_watch wd1 = X+1
add_watch wd2 = X+2

Should never happen. We tell the idr layer to always give us something
bigger than the last wd we received.

Also, idr_get_new_above doesn't work all the time. Under 2.6.13-rc7, I
added this to inotify.c:359:

if (ret <= dev->last_wd) {
    printk(KERN_INFO "idr_get_new_above returned <= dev->last_wd\n");
}

I get that message a lot. I know I have said this before (and was wrong)
but I think the idr layer is busted.

-- 
John McCutchan <ttb@tentacle.dhs.org>
