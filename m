Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272050AbTHRPwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTHRPwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:52:05 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:56331 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272050AbTHRPuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:50:44 -0400
Message-ID: <3F40F98F.8060103@techsource.com>
Date: Mon, 18 Aug 2003 12:06:39 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
CC: "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <D069C7355C6E314B85CF36761C40F9A42E20BB@mailse02.se.axis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Kjellerstedt wrote:

> 
> For loops       2.867568    5.620561    8.128734   28.286289  
> Multi byte fill 2.868031    5.670782    6.312027   11.336015  
> 
> And here are the numbers for my P4:
> 
> For loops       3.060262    5.927378    8.796814   30.659818  
> Multi byte fill 3.126607    5.898459    7.096685   13.135379  
> 
> So there is no doubt that the multi byte version is a clear
> winner (which was expected, I suppose).

Cool!  Hey, is this just an exercise, or are we actually going to use 
this?  I would be very happy to have something I contributed to put into 
the kernel.  :)

> 
> Here is the code that I used:
> 
> char *strncpy(char *dest, const char *src, size_t count)
> {
> 	char *tmp = dest;
> 
> 	while (count && *src) {
> 		*tmp++ = *src++;
> 		count--;
> 	}
> 
> 	if (count) {

Good idea... bad to do so many checks if count is zero.  On the other 
hand, if count is rarely zero, then it's a loss.  Maybe benchmark with 
and without?

> 		size_t count2;
> 
> 		while (count & (sizeof(long) - 1)) {
> 			*tmp++ = '\0';
> 			count--;
> 		}
> 
> 		count2 = count / sizeof(long);

I know that a good compiler should migrate code to help the CPU 
pipeline, but how about moving this "count2 = " line up to before the 
first fill loop.  See if that helps any.  Always good to precompute well 
in advance.

> 		while (count2) {
> 			*((long *)tmp)++ = '\0';
> 			count2--;
> 		}
> 
> 		count &= (sizeof(long) - 1);

And move this to before the middle fill loop.

> 		while (count) {
> 			*tmp++ = '\0';
> 			count--;
> 		}
> 	}
> 
> 	return dest;
> }
> 
> //Peter
> 
> 


