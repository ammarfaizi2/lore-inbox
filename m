Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbVCKFut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbVCKFut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbVCKFut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:50:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54279 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263223AbVCKFnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:43:18 -0500
Date: Fri, 11 Mar 2005 06:43:08 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Felix Matathias <felix@nevis.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() doesn't respect SO_RCVLOWAT ?
Message-ID: <20050311054307.GF30052@alpha.home.local>
References: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 04:58:51PM -0500, Felix Matathias wrote:
> 
> I am running a 2.4.21-9.0.3.ELsmp #1 kernel and I can setsockopt and 
> getsockopt correctly the SO_RCVLOWAT option, but select() seems to mark a 
> socket readable even if a single byte is ready to be read. Then, a read() 
> blocks until the specified number of bytes in SO_RCVLOWAT makes it to the 
> socket buffer.

as discussed in a previous thread, if you use select(), you should also
use non-blocking sockets. There are cases where select() can wake you up
without anything to read, eg if there is a packet waiting with a wrong
checksum.

> This is the exact opposite behaviour of what I yould have 
> expected/desired. Our application receives data at many Khz rate and we 
> want to avoid reading the socket until a predetermined amount of data is 
> sent, to avoid partial reads. SO_RCVLOWAT seemed to be a nice way to 
> implement that.

I too came across this problem a long time ago and concluded that LOWAT
was not really usable on Linux. But in the end, this is not really a big
deal, because as long as your application doesn't eat all CPU, it does
not change anything performance-wise, and when it becomes to eat a lot
of CPU, the latency will increase, letting more data come in when you
do one read.

> An earlier message by Alan Cox was a bit cryptic:
> 
> "But is the cost of all those special case checks and all the handling
> for it such as select computing if enough tcp packets together accumulated
> worth the cost on every app not using LOWAT for the microscopic gain given
> that essentially nobody uses it."
> 
> Does this mean that select() in Linux will wake up no matter what 
> SO_RCVLOWAT is set to ?

Yes.

Regards,
Willy

