Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWFXUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWFXUaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 16:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFXUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 16:30:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30888 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751094AbWFXUaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 16:30:19 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <449DA08A.10209@s5r6.in-berlin.de>
Date: Sat, 24 Jun 2006 22:28:58 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2.6.17-mm1 4/3] ieee1394: convert	ieee1394_transactions
 from semaphores to waitqueue
References: <449BEBFB.60302@s5r6.in-berlin.de>	 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net>	 <30866.1151072338@warthog.cambridge.redhat.com>	 <tkrat.df6845846c72176e@s5r6.in-berlin.de>	 <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>	 <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>	 <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de>	 <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>	 <449D7A53.4080605@s5r6.in-berlin.de> <1151172766.3181.75.camel@laptopd505.fenrus.org>
In-Reply-To: <1151172766.3181.75.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.894) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2006-06-24 at 19:45 +0200, Stefan Richter wrote:
>>following semaphores remain in the ieee1394 subsystem:
>>
>>highlevel.c:  hl_drivers_sem    (RW semaphore)
>>nodemgr.c:    subsys.rwsem      (driver core's RW semaphores)
>>raw1394.c:    fi->complete_sem  (completion semaphore)

> can this last one move to an actual completion? That would get rid of it
> nicely ;)

Hmm. There are dozens of points in raw1394 which call 
__queue_complete_req() which up()s the semaphore. ("fi" is the 
private_data of a struct file. Multiple outstanding requests may be 
associated with a file.) Then there are two places which wait on the 
semaphore:

raw1394_read(), called when somebody reads /dev/raw1394:
	if (file->f_flags & O_NONBLOCK) {
		if (down_trylock(&fi->complete_sem))
			return -EAGAIN;
	} else {
		if (down_interruptible(&fi->complete_sem))
			return -ERESTARTSYS;
	}

raw1394_release(), called when somebody closes (releases) /dev/raw1394:
	done = 0;
	while (!done) {
		/* free all complete requests */
		/* set "done" if there are no more pending requests */
		if (!done)
			down_interruptible(&fi->complete_sem);
	}
	/* cleanup, free fi */

It looks like fi->complete_sem is a actually a counting semaphore. It 
could perhaps be replaced by a wait queue plus an atomic counter. There 
is even already a wait queue in "fi" for use with poll_wait() via 
raw1394_poll().
-- 
Stefan Richter
-=====-=-==- -==- ==---
http://arcgraph.de/sr/
