Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTIINMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTIINMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:12:53 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:10881 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S264073AbTIINMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:12:52 -0400
Message-ID: <3F5DD237.4040909@terra.com.br>
Date: Tue, 09 Sep 2003 10:14:31 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Richard Procter <rnp@paradise.net.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver, take 2
References: <Pine.LNX.4.21.0309091029230.252-100000@ps2.local>
In-Reply-To: <Pine.LNX.4.21.0309091029230.252-100000@ps2.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Richard,

Richard Procter wrote:
> I've had a good look over your revised patch, and it looks fine to me. I
> didn't manage to get an MCA kernel booting to test it, but I'm not sure if
> it would have added a lot, especially as I don't have an SMP MCA machine.

	That's closer the a proper test box than me, since I don't even have 
an that NIC ;)

> That said, over the weekend I realised that the need to unroll wait_event
> was a consequence of using the same queue to perform two quite distinct
> functions: serialising the issuing of commands, and waiting for the card
> to complete command execution. This forces us to use a private variable to
> indicate which situation has occured. That's ok on UP, but requires us to
> jump through hoops to use it safely on SMP with spinlocks. 

	True, but since the patch uses a per-device lock, aren't we safe (and 
relatively scaleable) on SMP too?

	Using wait_event as "prepare_for_wait" and all that IMHO is needed 
because wait_event calls schedule, and we can't do that with our 
device lock held..hence the prepare_to_wait/spin_unlock/schedule stuff 
on mc32::wait_pending.

	I don't know if using 2 different locks is worth it, since we may 
starve mc_reload on SMP...but since the ammount of code dropped, it's 
worth testing to see if we scale better than the inline wait_pending 
stuff.

> I've rewritten things using completions (== semaphores?), and it's both
> cleaner and (unexpectedly) smaller (see example below). I'm in the process
> of convincing myself it all works; should have something out there by the
> end of the week.

	Great!

	Please let me know when you have something...I'm really enjoying 
helping to fix this bug. :)

> If there's a merge deadline coming up, please feel free to submit the
> patch, otherwise I'd like to hold off for a couple of days and see where
> we stand then.

	There isn't.

	Maybe we won't make 2.6.0-test5, but there's no need to rush things. 
Let's get this right.

	Kind Regards,

Felipe

