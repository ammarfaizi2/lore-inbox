Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbVIBXJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbVIBXJm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbVIBXJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:09:42 -0400
Received: from chicken.cs.columbia.edu ([128.59.21.28]:64971 "EHLO
	chicken.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S1161110AbVIBXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:09:40 -0400
Date: Fri, 2 Sep 2005 19:09:18 -0400 (EDT)
From: Ion Badulescu <ion.badulescu@limegroup.com>
X-X-Sender: ionut@moisil.badula.org
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: Ion Badulescu <lists@limebrokerage.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <20050902211810.GB18605@yakov.inr.ac.ru>
Message-ID: <Pine.LNX.4.62.0509021903290.10545@moisil.badula.org>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
 <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <20050902183656.GA16537@yakov.inr.ac.ru> <Pine.LNX.4.61.0509021609430.6083@guppy.limebrokerage.com>
 <20050902211810.GB18605@yakov.inr.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Sat, 3 Sep 2005, Alexey Kuznetsov wrote:

>> Well, take a look at the double acks for 84439343, 84440447 and 84441059,
>> they seem pretty much identical to me.
>
> It is just a little tcpdump glitch.
>
> 19:34:54.532271 < 10.2.20.246.33060 > 65.171.224.182.8700: . 44:44(0) ack 84439343 win 24544 <nop,nop,timestamp 226080638 99717832> (DF) (ttl 64, id 60946)
> 19:34:54.532432 < 10.2.20.246.33060 > 65.171.224.182.8700: . 44:44(0) ack 84439343 win 24544 <nop,nop,timestamp 226080638 99717832> (DF) (ttl 64, id 60946)
>
> It is one ACK (look at IP ID), shown twice. This happens sometimes
> with our packet socket.

Ahh... ack. :) That explains it.

> I understood. I expect when 184*4, when you said 184. But minimum is
> still 730 (unscaled 1460*2). If you really saw values lower than 730
> (unscaled 1460*2), there is another more severe problem and the suggested
> patch will not solve it.

I really did see very small values. This one is plucked from one of 
today's streams, after a full day's worth of data had passed through it:

19:03:19.659454 10.1.12.11.8001 > 10.2.10.212.56690: P 3:6(3) ack 1 win 65529 <nop,nop,timestamp 27146219 3617561665> (DF)
19:03:19.659462 10.2.10.212.56690 > 10.1.12.11.8001: . ack 6 win 181 <nop,nop,timestamp 3617562713 27146219> (DF)
19:03:20.690719 10.1.12.11.8001 > 10.2.10.212.56690: P 6:9(3) ack 1 win 65529 <nop,nop,timestamp 27146230 3617562713> (DF)
19:03:20.690727 10.2.10.212.56690 > 10.1.12.11.8001: . ack 9 win 181 <nop,nop,timestamp 3617563744 27146230> (DF)

10.1.12.11 is the Win2k box, 10.2.10.212 is the Linux box. The socket 
buffer sizes are the defaults, so the scaling is most likely 2^2. The 
packets being exchanged at this point are just heartbeats.

On Tuesday I can try to capture a full session from the very begining, if 
you think it would help.

Thanks,
-Ion
