Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVCJRl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVCJRl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVCJRiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:38:09 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:44402 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262798AbVCJRfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:35:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=k/VsmSL56z0eHFSgCAqDJsjELX+3ri52FJnF6/XixIhhwR4of7jd+2IDoTDh/hdJuMLDaFHs+N6pf+FJPC/87LF4pLGbbb/A66BHlceGRH3Ft0qyAVR5dj2OPLzkPfGKyYxFdZ3QESFsp9ptiLTMur4Q4IKg143jLit5l6SNKu4=
Message-ID: <29495f1d05031009357408420e@mail.gmail.com>
Date: Thu, 10 Mar 2005 09:35:36 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] Add TPM hardware enablement driver
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com
In-Reply-To: <1110415321526@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050310004115.GA32583@kroah.com> <1110415321526@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005 16:42:01 -0800, Greg KH <greg@kroah.com> wrote:
> ChangeSet 1.2035, 2005/03/09 10:12:19-08:00, kjhall@us.ibm.com
> 
> [PATCH] Add TPM hardware enablement driver

<snip>

> +void tpm_time_expired(unsigned long ptr)
> +{
> +       int *exp = (int *) ptr;
> +       *exp = 1;
> +}
> +
> +EXPORT_SYMBOL_GPL(tpm_time_expired);

<snip>

> +       down(&chip->timer_manipulation_mutex);
> +       chip->time_expired = 0;
> +       init_timer(&chip->device_timer);
> +       chip->device_timer.function = tpm_time_expired;
> +       chip->device_timer.expires = jiffies + 2 * 60 * HZ;
> +       chip->device_timer.data = (unsigned long) &chip->time_expired;
> +       add_timer(&chip->device_timer);
> +       up(&chip->timer_manipulation_mutex);
> +
> +       do {
> +               u8 status = inb(chip->vendor->base + 1);
> +               if ((status & chip->vendor->req_complete_mask) ==
> +                   chip->vendor->req_complete_val) {
> +                       down(&chip->timer_manipulation_mutex);
> +                       del_singleshot_timer_sync(&chip->device_timer);
> +                       up(&chip->timer_manipulation_mutex);
> +                       goto out_recv;
> +               }
> +               set_current_state(TASK_UNINTERRUPTIBLE);
> +               schedule_timeout(TPM_TIMEOUT);
> +               rmb();
> +       } while (!chip->time_expired);

<snip>

It seems like this use of schedule_timeout() and the others are a bit
excessive. In this case, a timer is set to go off in 2 hours or so,
with tpm_time_expired() as the callback. tpm_time_expired(), it seems
just takes data and sets it to 1, which in this case is
chip->time_expired (and is similar in the other cases). We then loop
while (!chip->time_expired), which to me means until
chip->device_timer goes off, checking if the request is complete every
5 milliseconds. The chip->device_timer doesn't really do anything,
does it? It just guarantees a maximum time (of 2 hours). Couldn't the
same be achieved with (please excuse the lack of tabs, any real
patches I submit will have them):

unsigned long stop = jiffies + 2 * 60 * HZ;
do {
     u8 status = inb(chip->vendor->base + 1);
     if ((status & chip->vendor->req_complete_mask ==
           chip->vendor->req_complete_val)
               goto out_recv;
     msleep(TPM_TIMEOUT); // TPM_TIMEOUT could now be 5 ms
     rmb();
} while (time_before(jiffies, stop);

I think similar replacements would work in the other locations.

If people agree, I will send patches.

Thanks,
Nish
