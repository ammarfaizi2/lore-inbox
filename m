Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVIBMLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVIBMLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 08:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVIBMLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 08:11:25 -0400
Received: from chicken.cs.columbia.edu ([128.59.21.28]:62149 "EHLO
	chicken.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S1751173AbVIBMLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 08:11:24 -0400
Date: Fri, 2 Sep 2005 08:11:12 -0400 (EDT)
From: Ion Badulescu <lists@limebrokerage.com>
X-X-Sender: ionut@moisil.badula.org
To: Noritoshi Demizu <demizu@dd.iij4u.or.jp>
cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <20050902.151132.15273184.Noritoshi@Demizu.ORG>
Message-ID: <Pine.LNX.4.62.0509020801380.10545@moisil.badula.org>
References: <20050902.135138.38716488.Noritoshi@Demizu.ORG>
 <20050901222032.5cc649c0@localhost.localdomain> <20050902.144537.35010282.Noritoshi@Demizu.ORG>
 <20050902.151132.15273184.Noritoshi@Demizu.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Noritoshi Demizu wrote:

>> By the way, if tcpdump does not track the window scale option, the right
>> edge (ack + real win) does not change between the following two ACKs.
>>
>>> 11:34:54.337167 10.2.20.246.33060 > 10.2.224.182.8700: . ack 84402527 win 15340 <nop,nop,timestamp 226080473 99717814> (DF)
>>   (259 ACKs are omitted here)
>>> 11:34:54.611769 10.2.20.246.33060 > 10.2.224.182.8700: . ack 84454467 win 2355 <nop,nop,timestamp 226080721 99717841> (DF)
>>
>> The first line is the 37th ACK and the second line is the 295th ACK.
>>
>>   ACK#37:  ack=84402527 win=15340 right_edge=84463887 (= ack + win * 4)
>>   ACK#295: ack=84454467 win=2355  right_edge=84463887 (= ack + win * 4)
>>
>> And all ACKs later than ACK#295 has win=2355 (2355*4=9420).
>>
>> This may be a hint.  But, sorry, I do not know the internal of Linux TCP.

Oh, it's absolutely possible (even likely) that the application was slow 
between 11:34:54.337167 and 11:34:54.611769 and data kept accumulating in 
the socket buffer. The real problem is not the shrinking of the window, 
but the fact that it never increases back to normal once the socket buffer 
is emptied.

> I think there is a possibility that some middle-box does something,
> for example, some middle-box between the two machines does kinda
> traffic-shaping by tweaking the TCP window size field.

Not really: the tcpdump is taken on the very box that generates the acks 
with the shrinking window, so it can't possibly be affected by any shaper. 
Unless the shaper is the Linux kernel itself...

-Ion
