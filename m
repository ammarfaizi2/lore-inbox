Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVHRSIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVHRSIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVHRSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:08:00 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:7477 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932350AbVHRSH7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:07:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LqvOg8Au4Mh3Z8jgnnVoIFeRdhVWRDiHj2kPs67lqpavBM7dHkoSDfaiFAC8+p/NeC8JO3h7B7gXyI34SoZirbMxc69+iGwSzA+lD7vJEtpYgfReOUFwAzx2AYZgIQAQ7/aPOuKXvL/YyRE+0BGWivgUMsvDiJX8p1cgjO9soW8=
Message-ID: <29495f1d050818110763d0b658@mail.gmail.com>
Date: Thu, 18 Aug 2005 11:07:56 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] ppc64: add RTAS console driver
Cc: linuxppc64-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508181752.j7IHq2Qq001692@d03av02.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508181931.43481.arnd@arndb.de>
	 <200508181752.j7IHq2Qq001692@d03av02.boulder.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Arnd Bergmann <arnd@arndb.de> wrote:
> The RTAS console driver can be used by all machines that abstract
> the system console through the {get,put}-term-char interface.
> It replaces the hvconsole on BPA, because we don't run under
> a hypervisor.
> 
> This driver needs to be redone as a special case of hvconsole,
> so there is no point in applying the patch to generic kernels.
> You will however need it if you intend to run on present Cell
> hardware.
> 
> From: Utz Bacher <utz.bacher@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

<snip>
 
> --- linux-cg.orig/drivers/char/rtascons.c       1969-12-31 19:00:00.000000000 -0500
> +++ linux-cg/drivers/char/rtascons.c    2005-08-18 17:31:21.912892064 

<snip>

> +#define RTASCONS_TIMEOUT       ((HZ + 99) / 100)

msecs_to_jiffies(10)? Or perhaps leave it in milliseconds with a
comment as such (see below)?

<snip>

> +static int
> +krtasconsd(void *unused)
> +{
> +       daemonize("krtasconsd");
> +
> +       for (;;) {
> +               if (cpus_empty(cpus_in_xmon)) {
> +                       rtascons_poll();
> +                       /* no need for atomic access */
> +                       if (rtascons_buffer_used) {
> +                               spin_lock(&rtascons_buffer_lock);
> +                               rtascons_flush_chars();
> +                               spin_unlock(&rtascons_buffer_lock);
> +                       }
> +               }
> +
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(RTASCONS_TIMEOUT);

Couldn't this be msleep_interruptible(RTASCONS_TIMEOUT) [if you make
RTASCONS_TIMEOUT in milliseconds]?

Thanks,
Nish
