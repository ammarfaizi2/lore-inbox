Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVKTVmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVKTVmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKTVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:42:40 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:59602 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932082AbVKTVmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:42:39 -0500
Message-ID: <4380EDBF.7090107@steeleye.com>
Date: Sun, 20 Nov 2005 16:42:23 -0500
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NBD] Use per-device semaphore instead of BKL
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com> <20051119223419.GA1751@gondor.apana.org.au> <20051120015807.GA3593@gondor.apana.org.au> <4380B015.9060005@steeleye.com> <20051120204325.GB11043@gondor.apana.org.au>
In-Reply-To: <20051120204325.GB11043@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Sun, Nov 20, 2005 at 12:19:17PM -0500, Paul Clements wrote:
> 
>>The dropping of the lock in nbd_do_it is actually critical to the way 
>>nbd functions. nbd_do_it runs for the lifetime of the nbd device, so if 
>>nbd_do_it were holding some lock (BKL or otherwise), we'd have big problems.
> 
> 
> Why would you want to issue an ioctl from a different process while
> nbd-client is still running?

nbd-client -d (disconnect) is the main reason -- this functionality 
would be broken if we didn't allow ioctls anymore

> Allow ioctl's while nbd_do_it is in progress is a *serious* bug.  For a

Certain ioctls, yes. There's no harm in NBD_DISCONNECT, though.

> start, if someone else clears the socket then nbd_read_stat will crash.

I agree, NBD_CLEAR_SOCK from another process while nbd_do_it is running 
would cause problems. But, if the user-level tools are coded properly, 
this is not an issue.

Perhaps your ioctl lock scheme, with an exemption for NBD_DISCONNECT 
would work?

--
Paul
