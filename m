Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWHTVjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHTVjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHTVjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:39:46 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:47225 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWHTVjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:39:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SJayWIs2g99K1gDa1QHyzBF7ObocLRnbd77qhVsQJ3DeVof/v6jaUdOuwOblI7MtXDIwnWFqek+VlnFdWV9yHybXOr6t6JL7eqBJQmEdFEmz44hGHQWd5pK3LRrF+mENgLSjE84vdxcYiJ9JUsgc9GKvo9njiv/Z6rYQ11d/gx4=
Message-ID: <18d709710608201439s63889d2ey1dc26028082e1ad7@mail.gmail.com>
Date: Sun, 20 Aug 2006 18:39:45 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: Luca <kronos.it@gmail.com>
Subject: Re: [PATCH] 2.6.17.9 Incorrect string length checking in param_set_copystring()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060820211456.GA32343@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18d709710608200747k3323b23cq70eb52fdb9032554@mail.gmail.com>
	 <20060820211456.GA32343@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks for the reply. I'll take the afore mentioned
point of SubmittingPatches in consideration in the future.

And yes, you're correct.
I was misled by an incorrect use of sizeof() and it made believe that
its return would strip the null terminator. Once again, my bad. :)

    Julio Auto

On 8/20/06, Luca <kronos.it@gmail.com> wrote:
> Julio Auto <mindvortex@gmail.com> ha scritto:
> > As for 2.6.17.9, linux/include/linux/moduleparam.h suggests the user
> > of module_param_string() to set the maxlen parameter to
> > strlen(string), ie. '\0' excluded. However the function that actually
> > sets the string (param_set_copystring()), doesn't accept inputs with
> > maxlen-1 characters, reporting that the supplied string should fit
> > maxlen-1 chars.
> > See patch below.
> > Cheers,
> >
> >    Julio Auto
> >
> > --- linux-2.6.17.9/kernel/params.c.old  2006-08-19 20:48:30.000000000 -0700
> > +++ linux-2.6.17.9/kernel/params.c      2006-08-19 20:49:15.000000000 -0700
> > @@ -351,9 +351,9 @@ int param_set_copystring(const char *val
> > {
> >        struct kparam_string *kps = kp->arg;
> >
> > -       if (strlen(val)+1 > kps->maxlen) {
> > +       if (strlen(val) > kps->maxlen) {
> >                printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
> > -                      kp->name, kps->maxlen-1);
> > +                      kp->name, kps->maxlen);
> >                return -ENOSPC;
> >        }
> >        strcpy(kps->string, val);
>
> Hi,
> I believe that the code is correct. kps->maxlen is the lenght of the
> buffer; when dealing with a string of N chars you need an array of (N +
> 1) bytes in order to store the terminator ('\0').
>
> Look again at the check:
>
>         if (strlen(val) > kps->maxlen) {
>
> Suppose that val is a string of 10 chars (strlen(val) == 10), suppose
> that the buffer holds 10 bytes (kps->maxlen == 10). The expression:
>
>         if (10 > 10) {
>
> is false, so strcpy() ends up writing 11 bytes in a buffer of 10 bytes.
>
> Also, for future patches see point 11 of
> Documentation/SubmittingPatches.
>
> Luca
> --
> Home: http://kronoz.cjb.net
> "Su cio` di cui non si puo` parlare e` bene tacere".
>  Ludwig Wittgenstein
>
