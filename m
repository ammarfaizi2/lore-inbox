Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135581AbRDSHue>; Thu, 19 Apr 2001 03:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135583AbRDSHuY>; Thu, 19 Apr 2001 03:50:24 -0400
Received: from zeus.kernel.org ([209.10.41.242]:58855 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135585AbRDSHuI>;
	Thu, 19 Apr 2001 03:50:08 -0400
Date: Thu, 19 Apr 2001 10:07:21 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andrew Chan <achan@achan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to tune TCP for heavily loaded sendmail box
Message-ID: <20010419100721.X805@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0104160037230.19394-100000@maelstrom.localhost> <3ADA5C4C.748D0916@home.com> <007d01c0c862$3fa67e40$093d9ecd@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007d01c0c862$3fa67e40$093d9ecd@outblaze.com>; from achan@achan.com on Thu, Apr 19, 2001 at 07:49:45AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 07:49:45AM +0800, Andrew Chan wrote:
> Greetings,
> 
> I am running a relaying sendmail box and I would like it to be able to
> handle up to 600 or so concurrent (incoming or outgoing) connections.
> 
> I tried that and discovered that TONS of incoming connections are stuck at
> SYNC_RECV state. It is like the sendmail box received these port 25
> connection attempts and then didn't know what to do with them.

	Such sockets don't make it to accept() -- the TCP connection
	setup is a three-way handshake, and SYN_RECV is just indication
	of the reception of the first part of it:

	1)  local  <-------  SYN ----------  remote
	2)  local  --------  ACK,SYN ----->  remote
	3)  local  <-------  ACk,ACK ------  remote

	Each of those  SYN_RECV  sockets have done 2, but have never
	heard back.   In normal case the state 3 is reached by 1.5
	times the roundtrip time between the two systems. (Presuming
	symmetric delays.)

	There is finite size queue of sockets that can sit in this
	particular state waiting for full open (3), after which the
	user programs can then get the sockets with  accept().

	It may be so called 'SYN-attack', although it might just as
	well be routing blackhole somewhere.

	Look for documents regarding SYN-Cookies, and how to enable them.
	( I.e. what values mean what at:
		/proc/sys/net/ipv4/tcp_syncookies )

> I suspect I need to tune some of the TCP parameters so that the system can
> handle many short lived TCP connections in an efficent manner. Any pointer
> to this specific issue or general TCP tunning under Linux (2.4.2-ac28
> kernel) will be most appreciated.
> 
> Thanks.
> 
> Andrew

/Matti Aarnio
