Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVCJSbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVCJSbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVCJSYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:24:08 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:8839 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262852AbVCJSTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:19:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jiVQaPZIafjBzB87xYLVe1pqyQImSPqbQBh/z6vPif5zXqPGmoODr/3oppsVLAwYLoBgfISqqTg/uNGiluV/IZPWqomHSevxbG2ch5qLmbVYbyGAUvLabnNAa5XUWlVe2/KdrKxJ+Dotm0zMM4l+wFn3PQ9XPUkDiGQPqElvkVI=
Message-ID: <29495f1d050310101973f416c2@mail.gmail.com>
Date: Thu, 10 Mar 2005 10:19:29 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] Add TPM hardware enablement driver
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com
In-Reply-To: <29495f1d05031009357408420e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050310004115.GA32583@kroah.com> <1110415321526@kroah.com>
	 <29495f1d05031009357408420e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 09:35:36 -0800, Nish Aravamudan
<nish.aravamudan@gmail.com> wrote:
> On Wed, 9 Mar 2005 16:42:01 -0800, Greg KH <greg@kroah.com> wrote:
> > ChangeSet 1.2035, 2005/03/09 10:12:19-08:00, kjhall@us.ibm.com
> >
> > [PATCH] Add TPM hardware enablement driver
> 
> <snip>
> 
> > +void tpm_time_expired(unsigned long ptr)
> > +{
> > +       int *exp = (int *) ptr;
> > +       *exp = 1;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(tpm_time_expired);
> 
> <snip>
> 
> > +       down(&chip->timer_manipulation_mutex);
> > +       chip->time_expired = 0;
> > +       init_timer(&chip->device_timer);
> > +       chip->device_timer.function = tpm_time_expired;
> > +       chip->device_timer.expires = jiffies + 2 * 60 * HZ;
> > +       chip->device_timer.data = (unsigned long) &chip->time_expired;
> > +       add_timer(&chip->device_timer);
> > +       up(&chip->timer_manipulation_mutex);
> > +
> > +       do {
> > +               u8 status = inb(chip->vendor->base + 1);
> > +               if ((status & chip->vendor->req_complete_mask) ==
> > +                   chip->vendor->req_complete_val) {
> > +                       down(&chip->timer_manipulation_mutex);
> > +                       del_singleshot_timer_sync(&chip->device_timer);
> > +                       up(&chip->timer_manipulation_mutex);
> > +                       goto out_recv;
> > +               }
> > +               set_current_state(TASK_UNINTERRUPTIBLE);
> > +               schedule_timeout(TPM_TIMEOUT);
> > +               rmb();
> > +       } while (!chip->time_expired);
> 
> <snip>
> 
> It seems like this use of schedule_timeout() and the others are a bit
> excessive. In this case, a timer is set to go off in 2 hours or so,
> with tpm_time_expired() as the callback. tpm_time_expired(), it seems
> just takes data and sets it to 1, which in this case is
> chip->time_expired (and is similar in the other cases). We then loop
> while (!chip->time_expired), which to me means until
> chip->device_timer goes off, checking if the request is complete every
> 5 milliseconds. The chip->device_timer doesn't really do anything,
> does it? It just guarantees a maximum time (of 2 hours). Couldn't the

Sorry for the slight exaggeration :) Not 2 hours, but 2 minutes :)
still, a long time.

-Nish
