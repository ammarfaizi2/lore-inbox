Return-Path: <linux-kernel-owner+w=401wt.eu-S1030243AbXADVuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbXADVuf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbXADVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:50:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030243AbXADVue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:50:34 -0500
Message-ID: <459D76A1.6000904@redhat.com>
Date: Thu, 04 Jan 2007 15:50:25 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org> <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org> <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104130028.39aa44b8.akpm@osdl.org> <459D6BD1.7050406@redhat.com> <20070104131008.1d95cb0c.akpm@osdl.org> <459D6F17.2050208@redhat.com> <Pine.LNX.4.64.0701041325510.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701041325510.3661@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 4 Jan 2007, Eric Sandeen wrote:
>> Andrew Morton wrote:
>>
>>> btw, couldn't we fix this bug with a simple old
>>>
>>> --- a/fs/bad_inode.c~a
>>> +++ a/fs/bad_inode.c
>>> @@ -15,7 +15,7 @@
>>>  #include <linux/smp_lock.h>
>>>  #include <linux/namei.h>
>>>  
>>> -static int return_EIO(void)
>>> +static long return_EIO(void)
>>>  {
>>>  	return -EIO;
>>>  }
>>> _
>>>
>>> ?
>> What about ops that return loff_t (64 bits) on 32-bit arches and stuff
>> it into 2 registers....
> 
> Do we actually have cases where we cast to a different return value?

Today, via the void * function casts in the bad file/inode ops, in
effect yes.

static int return_EIO(void)
{
        return -EIO;
}

#define EIO_ERROR ((void *) (return_EIO))

...
        .listxattr      = EIO_ERROR,

but listxattr is supposed to return a ssize_t, which is 64 bits on some
platforms, and only 32 bits get filled in thanks to the (void *) cast.
So we wind up with something other than the return value we expect...

Andrew's long suggestion breaks things the other way, with 64-bit
returning ops on 32-bit arches which again only pick up the first 32
bits thanks to the (void *) cast.

If we're really happy with casting away the function arguments (which
are not -used- in the bad_foo ops anyway), then I'd maybe suggest going
back to my first try at this thing:

static int return_EIO_int(void)
{
	return -EIO;
}
#define EIO_ERROR_INT ((void *) (return_EIO_int))

static struct inode_operations bad_inode_ops =
{
	.create		= EIO_ERROR_INT,
...etc...

which is most like what we have today, except with specific return types.

-Eric
