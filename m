Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUFQLXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUFQLXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 07:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266456AbUFQLXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 07:23:44 -0400
Received: from tor.morecom.no ([64.28.24.90]:8855 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S266455AbUFQLXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 07:23:33 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: Phil White <ext3@philwhite.org>
Cc: ext3 <ext3-users@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1805.216.148.213.196.1087426691.squirrel@www.code-visions.com>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan> <40D06C0B.7020005@techsource.com>
	 <1805.216.148.213.196.1087426691.squirrel@www.code-visions.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087471412.2765.209.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 17 Jun 2004 13:23:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was never able to resolve the problems I had with data=journal with the
> 2.4 kernel.  I did *not* try the 2.6 kernel though, so I can't give you
> any data points there.  In the end, I settled for data=ordered, and have
> never seen the problems I described in my original posts.  Also, to give
> you some background, I had been using ReiserFS before switching to ext3,
> and I experienced a lot of corruption with Reiser (my company makes linux
> based appliances which sometimes get turned off while under heavy IO). 
> Since ReiserFS doesn't do data journalling (metadata only), we
> consistently ended up with corrupt files.  After this, I decided to try
> ext3 with data=journal, and I never even got far enough with load testing
> to try the 'hard reset' test.  It would consistently crash in the fs code
> under heavy load.

This should be considered a serious bug, dont you think. Have you
reported this to the kernel list? I have the list now on the CC, but it
probably should be made as a bug report.


> 
> We have since had no problems with data=ordered, and since it writes data
> blocks before writing metadata to the journal, we don't see corrupt files
> anymore (even on hard resets).

Ok

> 
> If data integrity (within the file) is important to you in the face of a
> crash or power loss, do NOT use ReiserFS or ext3 data=writeback.   If your
> application never overwrites data in files, you will be just fine using
> data=ordered (appending to files or creating new files is pretty much
> guaranteed to never cause corruption).  If you need to overwrite data in
> files, you need to use data=journal (and probably beg people to fix it) or
> rewrite your application to use some other method (i.e. copy the file,
> delete the old one) and just use data=ordered.
> 

So data=journal would gain safer data integrity (if it works as intended then) 
than using data=ordered. But if data=journal does not work correctly we may be 
better off using data=ordered if we design our application after it. The problem 
is that we can not do this consistent because we have a mix of both open source 
applications and our own developed applications.

But think of your scenario  of copy, delete and make a new file with the new content.
First we copy the contents of the file, then we do our modifications. When we are done 
we delete the original file. Then we hit a crash. The content we had of the file in our process are 
gone, the original file is deleted. This is not a good idea. But if we write the new 
file first as fileX.new and den delete fileX, hit a crash then we would have at least the 
correct file written as fileX.new.

But we would be best off if we could trust the filesystem. 

In practise there are probably many more systems out there which use data=ordered because 
this is the default, and therefor get best testet. 

Journaling both data and metadata was what Dr. Tweedie did in the first public releases,
but the goal was not to do it. 

It is not easy to know what is the best thing to do.

We use this ext3 filesystem on a compact flash in an embedded system. 

Petter
