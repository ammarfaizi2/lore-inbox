Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVBDXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVBDXNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVBDXNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:13:38 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:47753 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S266387AbVBDXNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:13:13 -0500
Message-ID: <42040176.1030703@oracle.com>
Date: Fri, 04 Feb 2005 15:12:54 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] invalidate range of pages after direct IO write
References: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>	<20050203161927.0090655c.akpm@osdl.org>	<4202D55E.5030900@oracle.com> <20050203182854.0b36fb4d.akpm@osdl.org>
In-Reply-To: <20050203182854.0b36fb4d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I'd be inclined to hold off on the macro until we actually get the
> open-coded stuff right..  Sometimes the page lookup loops take an end+1
> argument and sometimes they take an inclusive `end'.  I think.  That might
> make it a bit messy.
> 
> How's this look?

Looks good.  It certainly stops the worst behaviour we were worried
about.  I wonder about 2 things:

1) Now that we're calculating a specifc length for pagevec_lookup(), is
testing that page->index > end still needed for pages that get remapped
somewhere weird before we locked?  If it is, I imagine we should test
for < start as well.

2) If we get a pagevec full of pages that fail the != mapping test we
will probably just try again, not having changed next.  This is fine, we
won't find them in our mapping again.  But this won't happen if next
started as 0 and we didn't update it.  I don't know if retrying is the
intended behaviour or if we care that the start == 0 case doesn't do it.

I'm being less excited by the iterating macro the more I think about it.
   Tearing down the pagevec in some complicated for(;;) doesn't sound
reliable and I fear that some function that takes a per-page callback
function pointer from the caller will turn people's stomachs.

- z
