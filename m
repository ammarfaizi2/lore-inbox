Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUIOSDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUIOSDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIOSCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:02:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:53697 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267254AbUIOSBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:01:08 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1095263565.19906.19.camel@vertex>
References: <1095263565.19906.19.camel@vertex>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 14:00:09 -0400
Message-Id: <1095271209.23385.84.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 11:52 -0400, John McCutchan wrote:

> I am interested in getting inotify included in the mm tree. 
> 
> Inotify is designed as a replacement for dnotify. The key difference's
> are that inotify does not require the file to be opened to watch it,
> when you are watching something with inotify it can go away (if path
> is unmounted) and you will be sent an event telling you it is gone and
> events are delivered over a fd not by using signals.

I want to expand on why dnotify is awful and why inotify is a great
replacement, because dnotify's limitations are really showing up on
modern desktop systems.

Some technical issues with dnotify and why inotify solves the problem:

        - dnotify requires one fd per watched directory.  this results
        in a lot of file descriptors if you are trying to do anything
        creative.  inotify solves this by only having one open file
        descriptor.
        
        - with dnotify, you open the fd on the directory to watch, which
        pins the directory.  this makes unmounting the backing
        filesystem impossible and means using dnotify on removable
        devices is nontrivial.  This is a problem with desktop systems.
        Not only does inotify solve this problem (by not requiring an
        open of each watched directory), but it even sends an "unmount"
        event when the watched directory is unmounted.
        
        - Using dnotify is, uh, interesting.  I mean, fcntl(2) and
        SIGIO?  You end up needing to use real-time signals.  Gross
        gross gross.  This does not working well with modern event-
        driven applications that use mainloops.  You end up needing a
        complicated daemon like FAM.  We don't want FAM, and in fact we
        should not even need a daemon (although we might want one).
        Conversely, inotify is trivial to use and integrates well and is
        select()-able.

I have been going over the code for awhile now, and it looks good.  I
would really like to hear Al's opinion so we can move on fixing any
possible issues that he has.

Best,

	Robert Love


