Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVKTVEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVKTVEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKTVEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:04:36 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:43311 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750861AbVKTVEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:04:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fs3RWCILzjiKcjCwr/qBPE8forwLLb/UiVHsVFb/+NrNXXr02LKgkEvK850LUwGewCHQruZZ4+M3ZqTtnTcPbjDyPItP7WozN1eZZrKz5syQS7gqJ41rlFxaMyI6Kml90U/7QTAjgMY9NRioAGrlMYtTCxHQxaFE7GV11sTOpyk=
Message-ID: <29495f1d0511201304p4b5bd863p4c8fccab6f5ef8d6@mail.gmail.com>
Date: Sun, 20 Nov 2005 13:04:35 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
Cc: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1132501080.2857.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43809652.8000904@comhem.se>
	 <1132501080.2857.3.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Arjan van de Ven <arjan@infradead.org> wrote:
> >   static void op_ok(void)
> >   {
> > -     aztTimeOutCount = 0;
> > +     aztTimeOut = jiffies + 2;
> >       do {
> >               aztIndatum = inb(DATA_PORT);
> > -             aztTimeOutCount++;
> > -             if (aztTimeOutCount >= AZT_TIMEOUT) {
> > +             if (time_after(jiffies, aztTimeOut)) {
> >                       printk("aztcd: Error Wait OP_OK\n");
> >                       break;
> >               }
> > +             schedule_timeout_interruptible(1);
>
> this I think is not quite right; schedule_timeout_*() doesn't do
> anything unless you set current->state to something. And at that point
> you might as well start using msleep()!

Not true, as Thomas points out. You are right for schedule_timeout(),
but that's why we introduced the _interruptible() and
_uninterruptible(). And there are reasons to use schedule_timeout_*()
instead of msleep() [not necessarily in this case, but in general],
specifically the presence of wait-queues.

> but what you're doing is generally a good idea; busy waits as the
> original code did is quite wrong...

I agree, and I recommend Daniel post to LKML to get some testing / see
if anyone actually uses this driver :)

Thanks,
Nish
