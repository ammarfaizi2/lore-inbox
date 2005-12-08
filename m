Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVLHXB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVLHXB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVLHXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:01:58 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:46782 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932698AbVLHXBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:01:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lMd5Qs4Bngw67FKNIWwg/llbM6+M7Lysf1rBbSKqVj31KMNXiDN1dD5sE9Uy90gBRrjmNF6Y6AbQUY2PxfmniWmyix27arXrKL7ClGHfG6klbHVK5K182vTODP6ylK0JdL/PSBWwQHa9YbsHfRgpjXlCO4sLViNY/ySc3Y/B9LI=
Message-ID: <d120d5000512081501q6537401dn68fa1a15160559ea@mail.gmail.com>
Date: Thu, 8 Dec 2005 18:01:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: Driver bind/unbind and __devinit
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208222618.GA26295@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d5000512081314r6b574eb3jf5516ef5bc28730d@mail.gmail.com>
	 <20051208215522.GA25925@suse.de>
	 <d120d5000512081422r650815dewb174119b743e87c4@mail.gmail.com>
	 <20051208222618.GA26295@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, Greg KH <gregkh@suse.de> wrote:
> On Thu, Dec 08, 2005 at 05:22:12PM -0500, Dmitry Torokhov wrote:
> > On 12/8/05, Greg KH <gregkh@suse.de> wrote:
> > > On Thu, Dec 08, 2005 at 04:14:58PM -0500, Dmitry Torokhov wrote:
> > > > Hi,
> > > >
> > > > Many drivers have their probe routines declared as __devinit which is
> > > > a no-op unless CONFIG_HOTPLUG is set. However driver's bind/unbind
> > > > attributes are created unconditionally, as fas as I can see. Would not
> > > > it cause an oops if someone tries to use these attributes with
> > > > CONFIG_HOTPLUG=N? Am I missing something?
> > >
> > > You are missing the CONFIG_HOTPLUG checks around the functions that add
> > > and check the device ids from these sysfs files.  If CONFIG_HOTPLUG is
> > > not enabled, those files do not do anything.
> > >
> >
> > I am slow today... I don't see any dependencies on CONFIG_HOTPLUG in
> > drivers/base... Or you talking about one particular subsystem that
> > handles this correctly?
>
> Ugh, very sorry about that, I was thinking of the USB and PCI new_id
> stuff.  You are right.
>
> Yes, bind happening after the __init data section is thrown away, if
> CONFIG_HOTPLUG is not enabled would be a bad thing.  But unbind can
> stay.  I'll go make up a patch for that.
>

Unbind may invoke ->remove code which is __devexit[_p] and may be also
discarded if !MODULE && !HOTPLUG.

> > > > Also, unbind implementation does not seem safe - we check the driver
> > > > before taking device's semaphore so we risk unbinding wrong driver (in
> > > > the unlikely event that we manage to unbind and bind another driver in
> > > > another thread).
> > >
> > > Do you have a suggestion as to how to fix this?
> > >
> >
> > I think we could take the semaphore before checking driver and then
> > use __device_release_driver(). But we'd need to make it global or move
> > bind/unbind code into drivers/base/dd.c
>
> I don't have a problem moving the code if it makes it easier.  Have a
> patch?  :)
>

Just handwaving for now ;)

--
Dmitry
