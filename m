Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVHYPSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVHYPSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVHYPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:18:39 -0400
Received: from peabody.ximian.com ([130.57.169.10]:52407 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751161AbVHYPSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:18:38 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: george@mvista.com, jim.houston@ccur.com,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       johannes@sipsolutions.net, linux-kernel@vger.kernel.org
In-Reply-To: <1124976814.5039.4.camel@vertex>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124976814.5039.4.camel@vertex>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 11:18:37 -0400
Message-Id: <1124983117.6810.198.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 09:33 -0400, John McCutchan wrote:
> On Thu, 2005-08-25 at 22:07 +1200, Reuben Farrelly wrote:
> > Hi,
> > 
> > I have also observed another problem with inotify with dovecot - so I spoke 
> > with Johannes Berg who wrote the inotify code in dovecot.  He suggested I post 
> > here to LKML since his opinion is that this to be a kernel bug.
> > 
> > The problem I am observing is this, logged by dovecot after a period of time 
> > when a client is connected:
> > 
> > dovecot: Aug 22 14:31:23 Error: IMAP(gilly): inotify_rm_watch() failed: 
> > Invalid argument
> > dovecot: Aug 22 14:31:23 Error: IMAP(gilly): inotify_rm_watch() failed: 
> > Invalid argument
> > dovecot: Aug 22 14:31:23 Error: IMAP(gilly): inotify_rm_watch() failed: 
> > Invalid argument
> > 
> > Multiply that by about 1000 ;-)
> > 
> > Some debugging shows this:
> > dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): removing wd 1019 from inotify fd 4
> > dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): removing wd 1018 from inotify fd 4
> > dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): inotify_add_watch returned 1019
> > dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): inotify_add_watch returned 1020
> > dovecot: Aug 25 19:31:23 Warning: IMAP(gilly): removing wd 1020 from inotify fd 4
> > dovecot: Aug 25 19:31:23 Warning: IMAP(gilly): removing wd 1019 from inotify fd 4
> > dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): inotify_add_watch returned 1020
> 
> 
> 
> > dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): inotify_add_watch returned 1021
> > dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): removing wd 1021 from inotify fd 4
> > dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): removing wd 1020 from inotify fd 4
> > dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): inotify_add_watch returned 1021
> > dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): inotify_add_watch returned 1022
> > dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): removing wd 1022 from inotify fd 4
> > dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): removing wd 1021 from inotify fd 4
> > dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): inotify_add_watch returned 1022
> > dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): inotify_add_watch returned 1023
> > dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): removing wd 1023 from inotify fd 4
> > dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): removing wd 1022 from inotify fd 4
> > dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): inotify_add_watch returned 1023
> > dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): inotify_add_watch returned 1024
> > dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): removing wd 1024 from inotify fd 4
> > dovecot: Aug 25 19:31:27 Error: IMAP(gilly): inotify_rm_watch() failed: 
> > Invalid argument
> > dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): removing wd 1023 from inotify fd 4
> > dovecot: Aug 25 19:31:28 Warning: IMAP(gilly): inotify_add_watch returned 1024
> > dovecot: Aug 25 19:31:28 Warning: IMAP(gilly): inotify_add_watch returned 1024
> > 
> > Note the incrementing wd value even though we are removing them as we go..
> > 
> 
> What kernel are you running? The wd's should ALWAYS be incrementing, you
> should never get the same wd as you did before. From your log, you are
> getting the same wd (after you inotify_rm_watch it). I can reproduce
> this bug on 2.6.13-rc7.
> 
> idr_get_new_above 
> 
> isn't returning something above.
> 
> Also, the idr layer seems to be breaking when we pass in 1024. I can
> reproduce that on my 2.6.13-rc7 system as well.
> 
> > This is using latest CVS of dovecot code and with 2.6.12-rc6-mm(1|2) kernel.
> > 
> > Robert, John, what do you think?   Is this possibly related to the oops seen 
> > in the log that I reported earlier?  (Which is still showing up 2-3 times per 
> > day, btw)
> 
> There is definitely something broken here.

Jim, George-

We are seeing a problem in the idr layer.  If we do idr_find(1024) when,
say, a low valued idr, like, zero, is unallocated, NULL is returned.

This readily manifests itself in inotify, where we recently switched to
using idr_get_new_above() with our last allocated token.

	Robert Love


