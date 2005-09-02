Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030685AbVIBEwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030685AbVIBEwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbVIBEwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:52:03 -0400
Received: from r-dd.iij4u.or.jp ([210.130.0.70]:16375 "EHLO r-dd.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1030682AbVIBEwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:52:01 -0400
Date: Fri, 02 Sep 2005 13:51:38 +0900 (JST)
Message-Id: <20050902.135138.38716488.Noritoshi@Demizu.ORG>
From: Noritoshi Demizu <demizu@dd.iij4u.or.jp>
To: Ion Badulescu <lists@limebrokerage.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent
 2.4.x/2.6.x kernels
In-Reply-To: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
X-Mailer: Mew version 4.1 on Emacs 21 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below may not be directly related to the cause of the problem.
But I think some window sizes in your mail need to be re-evaluated.

> 11:29:54.961998 10.2.20.246.33060 > 10.2.224.182.8700: S 1972343059:1972343059(0) win 5840 <mss 1460,sackOK,timestamp 225781001 0,nop,wscale 2> (DF)
> 11:29:54.983334 10.2.224.182.8700 > 10.2.20.246.33060: S 2770690746:2770690746(0) ack 1972343060 win 33304 <nop,nop,timestamp 99687881 225781001,mss 1460,nop,wscale 1,nop,nop,sackOK> (DF)

Since the TCP Window Scale options are exchanged,
the window size field contains shifted value except SYNs.

> 11:29:55.216634 10.2.20.246.33060 > 10.2.224.182.8700: . ack 14307 win 8192 <nop,nop,timestamp 225781255 99687903> (DF)
>
> The connection is established and the receiver's TCP window quickly ramps
> up to 8192.

I think the real window size here is 8192 << 2 = 32768.

> 11:29:55.707823 10.2.20.246.33060 > 10.2.224.182.8700: . ack 274527 win 16534 <nop,nop,timestamp 225781747 99687948> (DF)
>
> Shortly thereafter the TCP window increases further to 16534. It remains
> around 16534 for the next 5 minutes or so.

I think the real window size here is 16534 << 2 = 66136.

> 11:31:09.345250 10.2.20.246.33060 > 10.2.224.182.8700: . ack 38676603 win 16534 <nop,nop,timestamp 225855408 99695308> (DF)
>
> A few minutes later it has finally caught up to present time and it starts 
> receiving smaller packets containing real-time data. The TCP window is 
> still 16534 at this point.

I think the real window size here is 16534 << 2 = 66136.

> 11:34:54.337167 10.2.20.246.33060 > 10.2.224.182.8700: . ack 84402527 win 15340 <nop,nop,timestamp 226080473 99717814> (DF)
  (sniop)
> 11:34:54.628497 10.2.20.246.33060 > 10.2.224.182.8700: . ack 84458619 win 2355 <nop,nop,timestamp 226080737 99717845> (DF)
>
> This is where things start going bad. The window starts shrinking from 
> 15340 all the way down to 2355 over the course of 0.3 seconds.

I think the real window sizes are 15340 << 2 = 61360 and 2355 << 2 = 9420.
Hence, the right edges can be calculated as the following:

  84402527 + 15340 << 2 = 84463887
  84458619 +  2355 << 2 = 84468039

So, the window is not shrinked between those two lines.
Sorry, I have not checked other lines.

> 11:40:08.279678 10.2.20.246.33060 > 10.2.224.182.8700: . ack 134973263 win 2355 <nop,nop,timestamp 226394517 99749214> (DF)
>
> Five minutes later the TCP window is still at 2355, having never recovered.

I think the real window size here is 2355 << 2 = 9420.

> As I mentioned earlier, I've seen it go as low as 181.

I think the real window size is 181 << 2 = 724.

Regards,
Noritoshi Demizu
