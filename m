Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVASX4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVASX4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVASXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:52:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60409 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261989AbVASXvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:51:36 -0500
Message-ID: <41EEF284.2010600@mvista.com>
Date: Wed, 19 Jan 2005 15:51:32 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       matthias@corelatus.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
References: <16872.55357.771948.196757@antilipe.corelatus.se>	 <20050115013013.1b3af366.akpm@osdl.org>	 <1105830384.16028.11.camel@localhost.localdomain> <1105877497.8462.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1105877497.8462.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2005-01-16 at 00:58 +0000, Alan Cox wrote:
> 
>>On Sad, 2005-01-15 at 09:30, Andrew Morton wrote:
>>
>>>Matthias Lang <matthias@corelatus.se> wrote:
>>>These are things we probably cannot change now.  All three are arguably
>>>sensible behaviour and do satisfy the principle of least surprise.  So
>>>there may be apps out there which will break if we "fix" these things.
>>>
>>>If the kernel version was 2.7.0 then well maybe...
>>
>>These are things we should fix. They are bugs. Since there is no 2.7
>>plan pick a date to fix it. We should certainly error the overflow case
>>*now* because the behaviour is undefined/broken. The other cases I'm not
>>clear about. setitimer() is a library interface and it can do the basic
>>checking and error if it wants to be strictly posixly compliant.
> 
> 
> why error?
> I'm pretty sure we can make a loop in the setitimer code that detects
> we're at the end of jiffies but haven't upsurped the entire interval the
> user requested yet, so that the code should just do another round of
> sleeping...
> 
That would work for sleep (but glibc uses nanosleep for that) but an itimer 
delivers a signal.  Rather hard to trap that in glibc.

For what its worth, you can tell it was truncated by reading back the remaining 
time.  That could be done in the glibc wrapper and an error passed back, but 
actually doing the proper wait using this interface is rather hard.

The timer_settime(CLOCK...  interface detects overflow and passes back an error...

Clock_nanosleep on the otherhand, will sleep for the whole time, provide the 
machine doesn't turn to dust :)
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

