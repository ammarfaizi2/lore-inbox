Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281956AbRKZRrL>; Mon, 26 Nov 2001 12:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281959AbRKZRrC>; Mon, 26 Nov 2001 12:47:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49618 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S281956AbRKZRqu>;
	Mon, 26 Nov 2001 12:46:50 -0500
Message-ID: <3C028008.6000605@us.ibm.com>
Date: Mon, 26 Nov 2001 09:46:48 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011110
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Oliver.Neukum@lrz.uni-muenchen.de, Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [PATCH] Remove needless BKL from release functions
In-Reply-To: <200111231047.fANAlA105874@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>Beeing completly single-threaded also simplifies writing unclean drivers..
>
>BTW, I've attached a patch that fixes the largest input races (against 2.4.6),
>I don't see how to change the total lack of locking for other data structures
>without an API change, though.
>
The removal of the BKL in the input.c's open() was beyond the scope of 
what we were trying to do.  But, it snuck into the patch anyway.  It 
probably shouldn't have been there.  

In the patch, in the open function, you do this:
    if (handler)
        new_fops = fops_get(handler->fops);

But, the fops_get() #define already cheecks to make sure handler isn't null:
#define fops_get(fops) \
        (((fops) && (fops)->owner)      \
                ? ( try_inc_mod_count((fops)->owner) ? (fops) : NULL ) \
                : (fops))

It's nice to be careful, but is that extra check really necessary?

And, the BKL is still held during the open() call to the handler's 
open().  Is this trying to make sure that open() isn't called twice on a 
single device?  I checked all of the files in drivers/input, and didn't 
see any other uses of the BKL.  

--
David C. Hansen
haveblue@us.ibm.com

