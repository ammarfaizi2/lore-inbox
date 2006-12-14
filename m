Return-Path: <linux-kernel-owner+w=401wt.eu-S932598AbWLNLVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWLNLVX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWLNLVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:21:22 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:60595 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932598AbWLNLVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:21:22 -0500
Date: Thu, 14 Dec 2006 12:18:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
Message-ID: <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> For the sharing case, some sort of softirq should be created. That is, when a
>> hard interrupt is generated and the irq handler is executed, set a flag that at
>> some other point in time, the irq is delivered to userspace. Like you do with
>> signals in userspace:
>
>NO.
>
>The whole point is, YOU CANNOT DO THIS.
>
>You need to shut the device up. Otherwise it keeps screaming.
>
>Please, people, don't confuse the issue any further. A hardware driver
>
>	ABSOLUTELY POSITIVELY HAS TO
>
>have an in-kernel irq handler that knows how to turn the irq off.
>
>End of story. No ifs, buts, maybes about it.

I don't get you. The rtc module does something similar (RTC generates
interrupts and notifies userspace about it)


  irqreturn_t uio_handler(...) {
      disable interrupts for this dev;
      set a flag that notifies userspace the next best time;
      seomstruct->flag |= IRQ_ARRIVED;
      return IRQ_HANDLED;
  }


  /* Userspace->kernel notification, e.g. by means of a device node
     /dev/uio or some ioctl. */
  int uio_write(...) {
      somestruct->flag &= ~IRQ_ARRIVED;
      enable interrupts for the device;
  }



> - have an in-kernel irq handler that at a minimum knows how to test 
>   whether the irq came from that device and knows how to shut it up.
>
>This means NOT A GENERIC DRIVER. That simply isn't an option on the 
>table, no matter how much people would like it to be.


	-`J'
-- 
