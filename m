Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTD3VBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTD3VBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:01:03 -0400
Received: from [12.47.58.20] ([12.47.58.20]:52822 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262426AbTD3VBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:01:02 -0400
Date: Wed, 30 Apr 2003 14:10:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG ? in 2.5.68] time and sleep...
Message-Id: <20030430141015.16dfe47a.akpm@digeo.com>
In-Reply-To: <20030430195748.18712.qmail@linuxmail.org>
References: <20030430195748.18712.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 21:13:16.0981 (UTC) FILETIME=[5179AE50:01C30F5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo Ciarrocchi" <ciarrocchi@linuxmail.org> wrote:
>
> for i in `seq 1 1 600`;
> do
> 	time sleep 1
> done;
> 
> Then I've run it in background and then I've run 'dbench 32'.
> ...
> 0:01.16elapsed <-
> 0:02.84elapsed <-

Yup, that's expected.  Normally the time command gets everything it needs
out of pagecache.  Sometimes it needs to go to disk, and gets whacked by
other disk activity.

It can be regenerative too: `time' gets throttled in the page allocator. 
This creates a larger time window in which the pages which it needs get
reclaimed.  So it has to read things from disk.  Which takes more time, so
more of its pages are reclaimed.  And for each page which was reclaimed,
`time' needs to allocate memory, so it gets throttled again...

So you see it feeds on itself.  What is normally a few millisecond delay
becomes a many-second delay.

There are probably games we can play in the page allocator to fix this up:
identifying heavy page allocators and preferentially stalling those. 
Tricky to get right.

