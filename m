Return-Path: <linux-kernel-owner+w=401wt.eu-S964963AbWLMNVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWLMNVu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWLMNVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:21:50 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:8790 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964963AbWLMNVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:21:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qSaDQ0u6bpcvDGhU66xnHdyqGuwN1YKaCawlQPAemc/KYTmZkUy+8R2+0fYlPsF7DpV3w8OWmvlBfHHlkjVICdizjf/PuGHBHVoOJtyCry6yId6XZJUdb0yOTHJbZHVbotH/EOkTP1KOlKuVBoW4nsA/kckLZxq8xhG7L6bMNho=
Message-ID: <e8ac1af10612130521i2bc2032fl81c82b7c513b69c4@mail.gmail.com>
Date: Wed, 13 Dec 2006 18:51:47 +0530
From: "Tushar Adeshara" <adesharatushar@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: Kevent POSIX timers support.
In-Reply-To: <20061123085243.GA11575@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061113105458.GA8182@2ka.mipt.ru>
	 <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com>
	 <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com>
	 <20061121174334.GA25518@2ka.mipt.ru>
	 <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com>
	 <20061122104416.GD11480@2ka.mipt.ru>
	 <20061123085243.GA11575@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Wed, Nov 22, 2006 at 01:44:16PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> +static int posix_kevent_init_timer(struct k_itimer *tmr, int fd)
> +{
> +       struct ukevent uk;
> +       struct file *file;
> +       struct kevent_user *u;
> +       int err;
> +
> +       file = fget(fd);
> +       if (!file) {
> +               err = -EBADF;
> +               goto err_out;
> +       }
> +
> +       if (file->f_op != &kevent_user_fops) {
> +               err = -EINVAL;
> +               goto err_out_fput;
> +       }
> +
> +       u = file->private_data;
> +
> +       memset(&uk, 0, sizeof(struct ukevent));
> +
> +       uk.type = KEVENT_POSIX_TIMER;
> +       uk.id.raw_u64 = (unsigned long)(tmr); /* Just cast to something unique */
> +       uk.ptr = tmr;
> +
> +       tmr->it_sigev_value.sival_ptr = file;
> +
> +       err = kevent_user_add_ukevent(&uk, u);

I think these four lines are not required. Irrespective of return
value of kevent_user_add_ukevent(), we are going to release file, and
return err.

> +       if (err)
> +               goto err_out_fput;
> +
> +       fput(file);
> +
> +       return 0;


> +
> +err_out_fput:
> +       fput(file);
> +err_out:
> +       return err;
> +}
> +

-- 
Regards,
Tushar
--------------------
It's not a problem, it's an opportunity for improvement. Lets improve.
