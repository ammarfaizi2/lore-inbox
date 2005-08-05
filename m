Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVHEW0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVHEW0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVHEW0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:26:52 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:62510 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261947AbVHEWZD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:25:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=olSQm3UK0wHMxALiUYgJihahb0ls5hO7zAuh4WMSuryY6fFwFi7bLwnUSUwzCqnnOLeJGFg7KiCKPMlRWnW4iyjn2zWAMbhIQ02BfU1EEpsbyxvAsj8FnEG3MkjoT6951t+7TaLN1+DtIcN2Dx+PoXO7s/WJIHPTDE3ktxwT4ts=
Message-ID: <86802c4405080515257ddaa8d2@mail.gmail.com>
Date: Fri, 5 Aug 2005 15:25:02 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: mthca and LinuxBIOS
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <rolandd@cisco.com>,
       linville@tuxdriver.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
In-Reply-To: <20050805220015.GA3524@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440508041230143354c2@mail.gmail.com>
	 <86802c440508051103500f6942@mail.gmail.com>
	 <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com>
	 <86802c44050805112661d889aa@mail.gmail.com>
	 <86802c4405080512254b9cd496@mail.gmail.com>
	 <86802c4405080512451cdcae48@mail.gmail.com>
	 <86802c44050805132853070f1@mail.gmail.com>
	 <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org>
	 <20050805220015.GA3524@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In LinuxBIOS, We can allocate 64 bit region ( 0xfc0000000....) to the
mellanox Infiniband card. Some range above 4G.  So the mmio below 4G
is some smaller only 128M, Otherwise need 512M. If 4 IB cards are
used, the mmio will be 2G. For new opteron E stepping, We could use
hareware memhole support. But if the CPU is before opteron E, We only
can use SW mem mapping ( will lose some performance) or lose (2G RAM).
at such case We need 64bit pref mem. We only lose 128M even four IB
card are installed.

yesterday, someone add pci_restore_bars...., that will call
pci_update_resource, and it will overwirte upper 32 bit of BAR2 and
BAR4 of IB card.

So the patch make pci_restore_resource
1. don't touch BAR3, and BAR5, if BAR2, and BAR4 are 64 bit MEM IO
2. not assume BAR2 and BAR4 upper 32bit is 0 if if BAR2, and BAR4 are
64 bit MEM IO

YH



On 8/5/05, Greg KH <gregkh@suse.de> wrote:
> On Fri, Aug 05, 2005 at 01:38:37PM -0700, Linus Torvalds wrote:
> >
> > Hmm.. This looks half-way sane, but too ugly for words.
> >
> > I'd much rather see that when we detect a 64-bit resource, we always mark
> > the next resource as being reserved some way, and then we just make
> > pci_update_resource() ignore such reserved resources.
> >
> > The
> >
> >               if((resno & 1)==1) {
> >                       /* check if previous reg is 64 mem */
> >                       ..
> >
> > stuff is really too ugly.
> 
> Yeah, that's not nice.
> 
> But what's the real problem we are trying to fix here?  I seem to have
> missed that in the email thread somehow.
> 
> > Greg? Ivan?
> 
> Ivan's the pci resource guru, any thoughts as to how to do this in a
> nicer way?
> 
> thanks,
> 
> greg k-h
>
