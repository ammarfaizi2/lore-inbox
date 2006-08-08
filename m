Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWHHCx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWHHCx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHHCx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:53:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:62807 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751217AbWHHCx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:53:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NOBXUrbwXCkceSmzePgBReqBZEyuk10q8ldFjFWvy0qEi/PG4tZb03uiuUq63Q86FFE+CwkheK+sdUsj9sMKaYcoJi0wUJ4DRCw43/5WyIYM++sSsIGNtERp7XCq2p1srsWDTPjKa5Qlb0ypDEd6H6KUp02/kpMlTD/VJMwexSE=
Message-ID: <6de39a910608071953l39ce0873w713d59eda4aa5d84@mail.gmail.com>
Date: Mon, 7 Aug 2006 19:53:55 -0700
From: "Om N." <xhandle@gmail.com>
Subject: Re: [KJ] [patch] fix common mistake in polling loops
Cc: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <82faac5b0608071753q71050d72uadcf55bc1e54f30e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
	 <20060805114052.GE4506@ucw.cz> <20060805114547.GA5386@ucw.cz>
	 <82faac5b0608061639v315c6fa9l17cd4bf44b6bbc51@mail.gmail.com>
	 <20060807233453.GK2759@elf.ucw.cz>
	 <82faac5b0608071753q71050d72uadcf55bc1e54f30e@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Darren Jenkins <darrenrjenkins@gmail.com> wrote:
> G'day
>
> On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:
> > Hi!
> >
> > > >> Well, whoever wrote thi has some serious problems (in attitude
> > > >> department). *Any* loop you design may take half a minute under
> > > >> streange circumstances.
> > >
> > > 6.
> > > common mistake in polling loops [from Linus]:
> >
> > Yes, Linus was wrong here. Or more precisely, he's right original code
> > is broken, but his suggested "fix" is worse than the original.
> >
> >         unsigned long timeout = jiffies + HZ/2;
> >         for (;;) {
> >                 if (ready())
> >                         return 0;
> > [IMAGINE HALF A SECOND DELAY HERE]
> >                 if (time_after(timeout, jiffies))
> >                         break;
> >                 msleep(10);
> >         }
> >
> > Oops.
> >
> > > >Actually it may be broken, depending on use. In some cases this loop
> > > >may want to poll the hardware 50 times, 10msec appart... and your loop
> > > >can poll it only once in extreme conditions.
> > > >
> > > >Actually your loop is totally broken, and may poll only once (without
> > > >any delay) and then directly timeout :-P -- that will break _any_
> > > >user.
> > >
> > > The Idea is that we are checking some event in external hardware that
> > > we know will complete in a given time (This time is not dependant on
> > > system activity but is fixed). After that time if the event has not
> > > happened we know something has borked.
> >
> > But you have to make sure YOU CHECK READY AFTER THE TIMEOUT. Linus'
> > code does not do that.
> >                                                                 Pavel
>
>
> Sorry I did not realise that was your problem with the code.
> Would it help if we just explicitly added a
>
      unsigned long timeout = jiffies + HZ/2;
       for (;;) {
               if (ready())
                       return 0;
[IMAGINE HALF A SECOND DELAY HERE]
               if (time_after(timeout, jiffies)) {
                       if (ready())
                              return 0;
                       break;
                }
               msleep(10);
       }
Wouldn't this be better than adding a check after the break of loop?

> if (ready())
>         return 0;
>
> after the loop, in the example code? so people wont miss adding
> something like that in?
