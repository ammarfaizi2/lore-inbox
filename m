Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWDOMip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWDOMip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 08:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWDOMio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 08:38:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62144 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932507AbWDOMio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 08:38:44 -0400
Date: Sat, 15 Apr 2006 16:38:34 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>, Matt Helsley <matthltc@us.ibm.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060415123832.GA19850@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604150350x8e7dea1sbf1f83cb800dd1c3@mail.gmail.com> <20060415111443.GA4079@2ka.mipt.ru> <87hd4vvxpk.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87hd4vvxpk.fsf@briny.internal.ondioline.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 15 Apr 2006 16:38:35 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 10:18:31PM +1000, Paul Collins (paul@briny.ondioline.org) wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:
> 
> > On Sat, Apr 15, 2006 at 12:50:46PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> >> Hi
> >
> > Hello.
> >
> >> > Why do you want to send big messages over netlink?
> >> > Netlink is fast but not faster than char device for example, or read
> >> > from mapped area, although it is much more convenient to use.
> >> >
> >> > Well, I can increase CONNECTOR_MAX_MSG_SIZE to maximum allowed 64k, if
> >> > there is really strong justification.
> >> 
> >> I need to send messages containing several (1 to 3) file names. And
> >> "MAXPATHLEN" is 1024b (usually it's much less but I can't rely on
> >> that).
> >
> > $ touch `perl -e 'print "A"x1024'`
> > touch: cannot touch
> > `AA...AA':
> > File name too long
> >
> > Only 255 is allowed in my system.
> 
> There are two limits though, the component length limit (NAME_MAX),
> and the overall length limit (PATH_MAX).  For example:
> 
> $ mkdir -p `perl -e 'print "A"x255'`/`perl -e 'print "B"x255'`/`perl -e 'print "C"x255'`/`perl -e 'print "D"x255'`
> 
> works fine here.
> 
> However, with 256 I get "File name too long", as you did.

Sure, as pointed in previous e-mail, several concatenated directories can exceed any resonable limit,
even PATH_MAX (4k):
$ pwd | wc
      1       1    4113

So it is wrong idea to transfer the whole name in one message, which
will not only add huge overhead (for each subdir one must transfer the
whole path for the parent dir), but can be impossible to allocate such a
buffer in kernelspace to store the whole pathname.

> -- 
> Dag vijandelijk luchtschip de huismeester is dood

-- 
	Evgeniy Polyakov
