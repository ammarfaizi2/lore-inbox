Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWHJAZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWHJAZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWHJAZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:25:11 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:43891 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932444AbWHJAZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:25:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=ddtNQXnhM2hoqN2gOFXDoj0m2goh5+4w5DqEzSlgxQ2jcSHSpGMG19Hno1aqkVDrM/J5B76hMVUYDjrS+BCtCJGpjZ89A2x8NuZVL63bpH9E/57X6SX470cgOfv5+Bcr+PZKVGCLZNq3Gwh3z935FcnN31X7xwdKVTPLTM/0hMo=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: "Om N." <xhandle@gmail.com>
Subject: Re: [KJ] [patch] fix common mistake in polling loops
Date: Wed, 9 Aug 2006 20:25:01 -0400
User-Agent: KMail/1.9.1
Cc: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com> <82faac5b0608071753q71050d72uadcf55bc1e54f30e@mail.gmail.com> <6de39a910608071953l39ce0873w713d59eda4aa5d84@mail.gmail.com>
In-Reply-To: <6de39a910608071953l39ce0873w713d59eda4aa5d84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092025.02259.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending due to delivery failure.]

On Monday 07 August 2006 22:53, Om N. wrote:
> On 8/7/06, Darren Jenkins <darrenrjenkins@gmail.com> wrote:
> > G'day
> >
> > On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:
> > >
> > > But you have to make sure YOU CHECK READY AFTER THE TIMEOUT. Linus'
> > > code does not do that.
> > >                                                                 Pavel
> >
> >
> > Sorry I did not realise that was your problem with the code.
> > Would it help if we just explicitly added a
> >
>       unsigned long timeout = jiffies + HZ/2;
>        for (;;) {
>                if (ready())
>                        return 0;
> [IMAGINE HALF A SECOND DELAY HERE]
>                if (time_after(timeout, jiffies)) {
>                        if (ready())
>                               return 0;
>                        break;
>                 }
>                msleep(10);
>        }
> Wouldn't this be better than adding a check after the break of loop?

You're getting duplicated code there. That'll be an issue in more
complex loops. How about:

unsigned long timeout = jiffies + HZ/2;
int timeup = 0;

for (;;;) {
	if (ready())
 		return 0;
	if (timeup)
		break;
	msleep(10);
	timeup = time_after(timeout, jiffies);
};
... timeout ...

However care is needed with the use of timeup, since timeup==1 only
indicates failure at the point it's tested in the loop; in particular
it won't indicate failure after the loop if "return 0" is changed to
"break".

Andrew Wade
