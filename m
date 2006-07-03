Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWGCGI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWGCGI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWGCGI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:08:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:39323 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWGCGI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:08:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uIggmDHUGS+515kcNa/dbF+hqJbhJBu5AAVFBSrwCY3pRDMlcNUavnkvC8SXD4nK9wSewiG/pX2xNYpBzoUH0JA+MsiaZ0eJYuh2FByMvpcPl2RewofrQHTvzbJUthTbM8FhlxQxnBT1wPOEpCMdHPhmUNaiFPr2JqQb0mNjq0E=
Message-ID: <b6a2187b0607022308k361c9664uef9d521db10f4d08@mail.gmail.com>
Date: Mon, 3 Jul 2006 14:08:55 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Jean-Marc Valin" <Jean-Marc.Valin@usherbrooke.ca>
Subject: Re: Suspend to RAM regression tracked down
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       cpufreq@lists.linux.org.uk
In-Reply-To: <1151880764.5358.32.camel@idefix.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151837268.5358.10.camel@idefix.homelinux.org>
	 <44A80B20.1090702@goop.org>
	 <1151880764.5358.32.camel@idefix.homelinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try 2.6.17 with this patch from Greg. I had same problem on my
IBM X60s, as you mentioned ... sometimes, can't resume after a few
suspend/resume cycles. But this patch seems to do the trick even if I
don't load USB modules sometimes.

Subject: USB: get USB suspend to work again

Yeah, it's a hack, but it is only temporary until Alan's patches
reworking this area make it in.  We really should not care what devices
below us are doing, especially when we do not really know what type of
devices they are.  This patch relies on the fact that the endpoint
devices do not have a driver assigned to us.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/usb.c |    2 ++
 1 file changed, 2 insertions(+)

--- gregkh-2.6.orig/drivers/usb/core/usb.c
+++ gregkh-2.6/drivers/usb/core/usb.c
@@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev

 static int verify_suspended(struct device *dev, void *unused)
 {
+       if (dev->driver == NULL)
+               return 0;
        return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
 }



On 7/3/06, Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca> wrote:
> > There was a race in ondemand and conservative which made them lock up on
> > resume (possibly only on SMP systems though).  There's a patch for that
> > in current -mm, but I suspect there's another problem (still haven't had
> > any time to track it down).
>
> Any link to the patch and the thread about the problem (if any)? Also,
> was the race introduced in 2.6.12-rc5-git6? If not, it's a completely
> different problem because my machine worked fine with 2.6.12-rc5-git5.
