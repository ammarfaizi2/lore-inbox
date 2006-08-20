Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWHTVOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWHTVOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWHTVOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:14:35 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:47919 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751574AbWHTVOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:14:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XbH9FRlYiKS/OXamQsDSOXMstuPg/3ihVqVRdmoHgwUDosoYEScsHwVxbZm8wGKBoAR84ZYqF8h4RJXbXSl9vTC5mGcKLK35GHoGUo1F+KtKi7NcKJtnoD9ywGSE16dceGPwFU8rCMFno+SZKt6op3MwfKnTuJ6jvwOBduZAF9E=
Date: Sun, 20 Aug 2006 23:14:56 +0200
From: Luca <kronos.it@gmail.com>
To: Julio Auto <mindvortex@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17.9 Incorrect string length checking in param_set_copystring()
Message-ID: <20060820211456.GA32343@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d709710608200747k3323b23cq70eb52fdb9032554@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julio Auto <mindvortex@gmail.com> ha scritto:
> As for 2.6.17.9, linux/include/linux/moduleparam.h suggests the user
> of module_param_string() to set the maxlen parameter to
> strlen(string), ie. '\0' excluded. However the function that actually
> sets the string (param_set_copystring()), doesn't accept inputs with
> maxlen-1 characters, reporting that the supplied string should fit
> maxlen-1 chars.
> See patch below.
> Cheers,
> 
>    Julio Auto
> 
> --- linux-2.6.17.9/kernel/params.c.old  2006-08-19 20:48:30.000000000 -0700
> +++ linux-2.6.17.9/kernel/params.c      2006-08-19 20:49:15.000000000 -0700
> @@ -351,9 +351,9 @@ int param_set_copystring(const char *val
> {
>        struct kparam_string *kps = kp->arg;
> 
> -       if (strlen(val)+1 > kps->maxlen) {
> +       if (strlen(val) > kps->maxlen) {
>                printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
> -                      kp->name, kps->maxlen-1);
> +                      kp->name, kps->maxlen);
>                return -ENOSPC;
>        }
>        strcpy(kps->string, val);

Hi,
I believe that the code is correct. kps->maxlen is the lenght of the
buffer; when dealing with a string of N chars you need an array of (N +
1) bytes in order to store the terminator ('\0').

Look again at the check:

        if (strlen(val) > kps->maxlen) {

Suppose that val is a string of 10 chars (strlen(val) == 10), suppose
that the buffer holds 10 bytes (kps->maxlen == 10). The expression:

        if (10 > 10) {

is false, so strcpy() ends up writing 11 bytes in a buffer of 10 bytes.

Also, for future patches see point 11 of
Documentation/SubmittingPatches.

Luca
-- 
Home: http://kronoz.cjb.net
"Su cio` di cui non si puo` parlare e` bene tacere".
 Ludwig Wittgenstein
