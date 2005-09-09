Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVIIIOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVIIIOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVIIIOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:14:35 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:17425
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S965024AbVIIIOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:14:35 -0400
Message-ID: <43214467.7010702@acquerra.com.au>
Date: Fri, 09 Sep 2005 18:14:31 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.13 buffer strangeness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone. I'm seeing something very Odd with 2.6.11 / 2.6.12 and 2.6.13, it has me stumped so I want to describe my 
problem here and hopefully some kind soul can verify that what I am seeing is a Feature and NotABug :-)

It it's a Feature, then I'll find some way to work around it, but it seems to me that it's a Bug :-)

I have a digital video stream coming in at 25Mb/s over a firewire connector, and this data is being written out to a 
usb2 hard drive as it's captured. The hard drive can only sustain about 17Mb/s write speed, so I am in deficit by 7Mb 
per second.

I'm using a Dell Inspiron laptop with a 2GHz p4 and 1.5Gb of physical RAM, running a FC3 based distro but with a number 
of custom kernels, including 2.6.11, 2.6.12 and 2.6.13. I see the same issue on all of them.

Apart from X and my capture application (Coriander) there is nothing else happening on the machine, and so I see about 
1.3Gb of physical ram is available for buffering this data.

Okay, so what I *expect* to see is this: The video will stream in and out of Coriander at 25Mb/s until all the free RAM 
is full of dirty data waiting to be written to disk. At a deficit of 7Mb/s this should take about 3 minutes to fill 
1.3Gb. When this point is reached I would see my write speed suddenly drop from 25Mb/s to 17Mb/s because there is 
effectively no more RAM to allocate for buffers.

*But* what I actually see is that I hit this point after only 50 seconds. This is very puzzling. After 50 seconds of 
operation I see my video write speed suddenly drop to 17Mb/s.

Coincidentally (or not...) this is about how long it takes the kernel to allocate all of the 1.3Gb of RAM to disk 
buffers. If I watch "free" while I am running I can see the amount of allocated buffers growing by 25Mb/s until it is 
all used, and then my write speed immediately drops.

It's as if the kernel isn't bothering to write out any of my data until it runs out of RAM.

Now, I'm pretty sure that the data is streaming out to the disk, cause I can see the disk activity light solidly lit on 
the usb2 drive (very scientific). There is a short delay after I start streaming before it comes on, maybe 4 or 5 
seconds. I've tinkered with the VM settings in /proc/sys/vm and I can make the kernel start writing data faster by 
lowering dirty_ratio, but this does not change the symptoms that I am seeing.

When all 1.3Gb has been allocated to buffers after 50 seconds, 900M of that should have become free to be recycled as it 
has been written out to the usb2 drive at 17Mb/s - Somehow this doesn't seem to be happening.

The result that I am seeing could be explained if the kernel was not releasing dirty pages after they have been written 
to disk, but I know this doesn't make sense.

Can anyone make sense of this and let me know whether this is expected behaviour or not?

I'd prefer to read any responses on the list - if you email me directly then you'll have to get past my spam filter.

Thanks in advance,

Anthony

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836

