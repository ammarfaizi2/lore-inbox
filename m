Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWATVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWATVxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWATVxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:53:45 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:28951 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751177AbWATVxp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:53:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sMe9ispLkB1/iWeKaax/ezsPn98KYYDWq8kg2ztv0eTsCKL7K/wO50ddCx+bE6022MAwvcqSGSwAKdz4aDcHzPFE5Zt84VOOaRnN9bhbWGaPWuwG34p7/qLYwqFJIAtUpQd7dUvbPn4briOUzQp5obgeAVJJWiUjb+XzpfX53Ik=
Message-ID: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
Date: Fri, 20 Jan 2006 16:53:44 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: sendfile() with 100 simultaneous 100MB files
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading this blog post about the lighttpd web server.
http://blog.lighttpd.net/articles/2005/11/11/optimizing-lighty-for-high-concurrent-large-file-downloads
It describes problems they are having downloading 100 simultaneous 100MB files.

In this post they complain about sendfile() getting into seek storms and
ending up in 72% IO wait. As a result they built a user space
mechanism to work around the problems.

I tried looking at how the kernel implements sendfile(), I have
minimal understanding of how the fs code works but it looks to me like
sendfile() is working a page at a time. I was looking for code that
does something like this...

1) Compute an adaptive window size and read ahead the appropriate
number of pages.  A larger window would minimize disk seeks.

2) Something along the lines of as soon as a page is sent age the page
down in to the middle of page ages. That would allow for files that
are repeatedly sent, but also reduce thrashing from files that are not
sent frequently and shouldn't stay in the page cache.

Any other ideas why sendfile() would get into a seek storm?

--
Jon Smirl
jonsmirl@gmail.com
