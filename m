Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSJQPEw>; Thu, 17 Oct 2002 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbSJQPEv>; Thu, 17 Oct 2002 11:04:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261403AbSJQPEu>;
	Thu, 17 Oct 2002 11:04:50 -0400
Message-ID: <3DAED2DB.3030407@pobox.com>
Date: Thu, 17 Oct 2002 11:10:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk>	<3DAC5B47.7020206@pobox.com>	<20021015214420.GA28738@fib011235813.fsnet.co.uk>	<3DAD75AE.7010405@pobox.com>	<20021016152047.GA11422@fib011235813.fsnet.co.uk>	<3DAD8CC9.9020302@pobox.com>	<20021017080552.GA2418@fib011235813.fsnet.co.uk> <m3fzv5pj23.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Joe Thornber <joe@fib011235813.fsnet.co.uk> writes:
> 
> 
>>Is there anyone out there who is going to argue against using an fs
>>interface when I submit it ?  Speak now or forever hold your peace !
>>
>>If dm now misses the feature freeze deadline due to this extra work,
>>is it going to be possible to still place it in 2.5 at a later date ?
>>(dm with an ioctl interface is better than no dm at all).
> 
> 
> How would the fs based interface work ? 
> 
> plan9 style echo 'rename foo bla' > /dmfs/command would seem ugly to me
> (just look at the horrible parser code for that in mtrr.c) 
> 
> doing it fully as fs objects (mv /dmfs/volume1 /dmfs/volume2 for rename)
> could likely get complicated and it's doubtful that VFS semantics completely
> map to DM volumes.

The simplest interface can be read(2) and write(2) to replace ioctl(2), 
but still using a single control node [or whatever granularity currently 
exists]  I think you are over-complicating a simple issue.


> Unless you have a clear and simple way to handle these issues I would
> suggest to stay with simple ioctls. They look clean enough.

Please go back and read what Linus and Al Viro have repeatedly posted 
about ioctl(2)...

Overall, one should consider here
* device mapper has never been in the Linux kernel before, thus we have 
a duty to make sure it is clean before it gets into the kernel
* ioctls appear "simple" only at first glance.  they require more 
maintenance in the long run due to the ioctl32 thunking layers, and are 
often riddled with shortsighted 32-bit size limits that reduce their 
utility on 64-bit platforms
* ioctls cannot be exported over NFS and similar interfaces
* ioctls are a way to add "do something totally different" functionality 
to a file descriptor.  IOW you read(2) and write(2) a file, and when you 
have other tasks to do to this file, add an "escape hatch"?  No, that's 
the wrong way to go.

ioctls are analogous to procfs:  they are simple, easy, and usually the 
wrong thing to do.

	Jeff



