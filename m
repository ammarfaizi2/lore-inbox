Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTF0O0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTF0O0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:26:43 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:6541 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S264374AbTF0OZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:25:52 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Fri, 27 Jun 2003 16:41:06 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306270222.27727.phillips@arcor.de> <Pine.LNX.4.53.0306271345330.14677@skynet>
In-Reply-To: <Pine.LNX.4.53.0306271345330.14677@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271641.06771.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 June 2003 15:00, Mel Gorman wrote:
> On Fri, 27 Jun 2003, Daniel Phillips wrote:
> I was thinking of using slabs because that way there wouldn't be need to
> scan all of mem_map, just a small number of slabs. I have no basis for
> this other than hand waving gestures though.

That's the right idea, it's just not necessary to use slab cache to achieve 
it.  Actually, to handle huge (hardware) pages efficiently, my first instinct 
is to partition them into their own largish chunks as well, and allocate new 
chunks as necessary.  To get rid of a chunk (because freespace of that type 
of chunk has fallen below some threshold) it has to be entirely empty, which 
can be accomplished using the same move logic as for defragmentation.

You're right to be worried about intrusion of unmovable pages into regions 
that are supposed to be defraggable.  It's very easy for some random kernel 
code to take a use count on a page and hang onto it forever, making the page 
unmovable.  My hope is that:

  - This doesn't happen much
  - Code that does that can be cleaned up
  - Even when it happens it won't hurt much
  - If all of the above fails, fix the api for the offending code or create
    a new one
  - If that fails too, give up.

Regards,

Daniel

