Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWEIFEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWEIFEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWEIFEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:04:04 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:8876 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751377AbWEIFED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:04:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Z86m872/IIoP8dZHCf4uyiFQpF5tt0qrCYzO52fomHcfqNNpfvsRujRGKj3Qj3Dn3CAjL0M7YZMv6cD9C2OWunV//ca/G5/DeNFdvYyaITbpNb0urbP00I/Lago9X/b3LILzIyARtEc9bBpHg9h51kik5N9ZuGdc5r5FcD09xpk=  ;
Message-ID: <44601E9C.2010802@yahoo.com.au>
Date: Tue, 09 May 2006 14:46:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Erik Mouw <erik@harddisk-recovery.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com>	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>	 <1147100149.2888.37.camel@laptopd505.fenrus.org>	 <20060508152255.GF1875@harddisk-recovery.com>	 <1147102290.2888.41.camel@laptopd505.fenrus.org>	 <445FF714.4050803@yahoo.com.au> <1147149399.3198.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1147149399.3198.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Tue, 2006-05-09 at 11:57 +1000, Nick Piggin wrote:
>
>>Perhaps kernel threads in D state should not contribute toward load avg
>>
>
>that would be a change from, well... a LONG time
>

But presently it changes all the time when we change the implementation
of pdflush or kswapd.

If we make pdflush threads blk_congestion_wait for twice as long, and
end up creating twice as many to feed the same amount of IO, our load
magically doubles but the machine is under almost exactly the same
load condition.

Back when we didn't have all these kernel threads doing work for us,
that wasn't an issue.

>
>The question is what "load" means; if you want to change that... then
>there are even better metrics possible. Like
>"number of processes wanting to run + number of busy spindles + number
>of busy nics + number of VM zones that are below the problem
>watermark" (where "busy" means "queue full")
>
>or 50 million other definitions. If we're going to change the meaning,
>we might as well give it a "real" meaning. 
>

I'm not sure if that is any better, and perhaps even worse. It does not
matter that much if VM zones are under a watermark if kswapd is taking
care of the problem and nothing ever blocks on memory IO.

(Sure kswapd will contribute to CPU usage, but that *will* be reflected
in load average)

>
>(And even then it is NOT a good measure for determining if the machine
>can perform more work, the graph I put in a previous mail is very real,
>and in practice it seems the saturation line is easily 4x or 5x of the
>"linear" point)
>

A global loadavg isn't too good anyway, as everyone has observed, there
are many independant resources. But my point is that it isn't going away
while apps still use it, so my point is that this might be an easy way to
improve it.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
