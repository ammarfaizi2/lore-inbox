Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVKTRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVKTRTu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVKTRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:19:50 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:44496 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751297AbVKTRTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:19:49 -0500
Message-ID: <4380B015.9060005@steeleye.com>
Date: Sun, 20 Nov 2005 12:19:17 -0500
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NBD] Use per-device semaphore instead of BKL
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com> <20051119223419.GA1751@gondor.apana.org.au> <20051120015807.GA3593@gondor.apana.org.au>
In-Reply-To: <20051120015807.GA3593@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Sun, Nov 20, 2005 at 09:34:19AM +1100, herbert wrote:
> 
>>This is intentional actually.  nbd_clear_queue never races against
>>nbd_find_request because the ioctl is protected by the BKL.  If it
>>weren't, then we have much worse problems to worry about (e.g.,
>>while you're clearing the queue someone else could have set the
>>socket again and started queueing requests).
> 
> 
> Actually, we do have bigger problems :) The BKL is dropped every
> time you sleep, and nbd_do_it is definitely a frequent sleeper :)

The dropping of the lock in nbd_do_it is actually critical to the way 
nbd functions. nbd_do_it runs for the lifetime of the nbd device, so if 
nbd_do_it were holding some lock (BKL or otherwise), we'd have big problems.


> This isn't really an issue in practice though because the NBD
> client program is single-threaded and doesn't share its file
> descriptors with anyone else.

Right, there's no problem in practice.


> However, we shouldn't make it too easy for the user to shoot himself
> in the foot.  If he's going to do that, let him at least pay for the
> bullet :)
> 
> So here is a patch to use a per-device semaphore instead of the
> BKL to protect the ioctl's against each other.

The problem with this patch is that no ioctls can come in once nbd_do_it 
starts because nbd_do_it runs for the lifetime of the device.

I think we really just need to add the acquiring of queue_lock in 
nbd_clear_que to your previous patch and leave it at that. I'll code 
that up and test it.

Thanks,
Paul
