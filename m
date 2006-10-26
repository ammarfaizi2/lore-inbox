Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423528AbWJZOpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423528AbWJZOpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423534AbWJZOpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:45:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:12782 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423528AbWJZOpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:45:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IEQKpwDwM4UTcNFs8MbLDAKRw/U3HPRGrJetA9dBCkkXc0rnKBjuMngKKzP9Ol6MvwUnrBWY7eMpYE4H8fCZAnGU3ut+yHbOSJeeWl4iPosyXt1bc5ouUA21PbqXU6MgNpgrh5/0FleM0jQA6EovNi+xXZ7RcSeYOfUEbigDIEw=
Message-ID: <653402b90610260745w59b740d2x5961e40252f5b76@mail.gmail.com>
Date: Thu, 26 Oct 2006 14:45:34 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE143.3070909@innova-card.com>
	 <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
	 <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> On 10/23/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> > On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > >
> > > [ note I'm not familiar with lcds...just try to understand what you've
> > >   done ]
> > >
> > > What I was worry about is that you actually wrote a frame buffer
> > > driver, which are normally located in drivers/video, and put it in a
> > > new directory drivers/auxdisplay. So now we have two places for frame
> > > buffer drivers. It looks like, now some frame buffer drivers in
> > > drivers/video should be moved in drivers/auxdisplay, shouldn't it ?
> > >
> > > Maybe just a stupid idea but why not restructuring the thing like:
> > >
> > >                 drivers
> > >                 |-- display
> > >                 |      |-- video
> > >                 |      |-- aux
> > >                 |      |-- fbmem.c
> > >                 |      |-- ...
> > >
> > >
> >
> > Yes, I got your idea in your first message, and well, that was
> > discussed (however, not being a fbdev), and the people thought that
> > putting them together will, maybe, cause confusion; so having them out
> > from drivers/video should be better. Your idea, which merge them into
> > a "drivers/display" could be a good one, but I don't think people will
> > like to change such critical tree right now. Also, I'm not the one who
> > maintain such tree, so my opinion won't make changes about that ;)
> >
>
> well, if it is the right thing to do, why not doing it. (note: I don't
> claim it's the right thing to do though). Futhermore such change is
> going to move a lot of files _but_ if after the move it compiles, then
> it works...
>
> > >
> > > Another point: does the ks0108 controller is only used with the 'cfag'
> > > display ? If not, suppose I'm using the same controller with another
> > > lcd different from 'cfga'...Am I supposed to reuse your code in
> > > cfag12864b.c ?
> > >
> >
> > No. You are supposed to _use_ the ks0108's exported functions: I split
> > the code into the ks0108 and the cfag12864b because I thought it was
> > the logical way, as the cfag12864b LCD just send the data through two
> > different ks0108 controllers. The same way, you can use the ks0108's
> > exported functions to create another whateverlcd.c which has one or
> > more ks0108 controllers.
> >
>
> So, to sum up, if I have a lcd named 'foo_lcd' which use 4 ks0108
> controllers (256x128), and want to make your fb driver work on it, I
> need to copy your  cfag12864b.c file, rename it to foo_lcd256128.c and
> just change the number of controllers, is that correct ?
>

No way. Each controller would have different wirings, pins, in-outs,
specifications (...) You will need to code an almost whole new fbdev
driver (althought maybe it will be so similar to cfag12864b so you
only need to make few little changes, but that is unsure).

>
> > >
> > > BTW, did you try to mmap your fbdev ? Does it work ?
> > >
> >
> > Why it shouldn't? It doesn't work for you? AFAIK, it is a usual fbdev,
> > and you can map any fbdev as they are simple character file devices.
> >
>
> well you actually haven't answered to the initial question... I
> suspect it won't work since you haven't setup "info->fix.smem_start"
> anywhere. But I may be wrong since I don't know fb code.
>

Well, you were right about mmaping, but you weren't about
"info->fix.smem_start". smem_start expects a physical address. RAM
addresses can't be mmapped as usual, so I have made some changes and
coded the nopage and mmap ops.

I'm sending the patch in a few moments. Thanks for pointing it: Now it
can be mmaped as well.
