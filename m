Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWGKHrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWGKHrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWGKHrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:47:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:42276 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750700AbWGKHry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:47:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PsW4S0HXTajMKd10Yae3BZ90EgZ/NeiYR+bFQStwC5pwBfEoqcZp/vS22rZ2TbudbKbiMu6EjUmQdp/cUyzqbP5vKahKRj3XOqblSQvzJy7uoysNUu9fiaDLky0HWS8Z5f8JdI3gEK5ZBA7qS7vryHcG18jmk68ijssViCzqpnA=
Message-ID: <b0943d9e0607110047x5f494981h1925c950d34459f0@mail.gmail.com>
Date: Tue, 11 Jul 2006 08:47:53 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Fix a memory leak in the i386 setup code
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607110025.57812.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710221308.5351.78741.stgit@localhost.localdomain>
	 <200607110025.57812.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Does x86_64 need a similar fix?

Doesn't look like it needs this.

> On Tuesday 11 July 2006 00:13, Catalin Marinas wrote:
> > --- a/arch/i386/kernel/setup.c
> > +++ b/arch/i386/kernel/setup.c
> > @@ -1327,7 +1327,10 @@ #endif
> >               res->start = e820.map[i].addr;
> >               res->end = res->start + e820.map[i].size - 1;
> >               res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> > -             request_resource(&iomem_resource, res);
> > +             if (request_resource(&iomem_resource, res)) {
> > +                     kfree(res);
> > +                     continue;
> > +             }
> >               if (e820.map[i].type == E820_RAM) {
> >                       /*
> >                        *  We don't know which RAM region contains kernel data,
>
> Evidently res is used if e820.map[i].type == E820_RAM, so it should
> be freed later on, it seems.

The "if" block I added has a "continue" and therefore the E820_RAM
case is skipped. There is no point in requesting a resource with "res"
as parent when "res" couldn't be successfully acquired.

-- 
Catalin
