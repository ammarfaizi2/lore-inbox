Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVLHWWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVLHWWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVLHWWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:22:13 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:8044 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932263AbVLHWWN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:22:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GLVmZDXvRu4BihHb4bhxFUmdeZVYiLVN9ZKbwYQcZRatwdhekzjVSD18lc8i/w+Foj91AeIee50RkLQtQa5yJ/lBZS3D1BpR2p34iBc+tip6NUFTXwtj74tTFJ1t68lWZAGdQV9HgpoxAEW3B9yeJb8RjWpZg3LSJucXv38j8vU=
Message-ID: <d120d5000512081422r650815dewb174119b743e87c4@mail.gmail.com>
Date: Thu, 8 Dec 2005 17:22:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: Driver bind/unbind and __devinit
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208215522.GA25925@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d5000512081314r6b574eb3jf5516ef5bc28730d@mail.gmail.com>
	 <20051208215522.GA25925@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, Greg KH <gregkh@suse.de> wrote:
> On Thu, Dec 08, 2005 at 04:14:58PM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > Many drivers have their probe routines declared as __devinit which is
> > a no-op unless CONFIG_HOTPLUG is set. However driver's bind/unbind
> > attributes are created unconditionally, as fas as I can see. Would not
> > it cause an oops if someone tries to use these attributes with
> > CONFIG_HOTPLUG=N? Am I missing something?
>
> You are missing the CONFIG_HOTPLUG checks around the functions that add
> and check the device ids from these sysfs files.  If CONFIG_HOTPLUG is
> not enabled, those files do not do anything.
>

I am slow today... I don't see any dependencies on CONFIG_HOTPLUG in
drivers/base... Or you talking about one particular subsystem that
handles this correctly?

> In 2.6.16, CONFIG_HOTPLUG is moving under CONFIG_EMBEDDED, so the odds
> of people disabling it are going to be pretty small now.
>

I dont think this is a valid argument.

> > Also, unbind implementation does not seem safe - we check the driver
> > before taking device's semaphore so we risk unbinding wrong driver (in
> > the unlikely event that we manage to unbind and bind another driver in
> > another thread).
>
> Do you have a suggestion as to how to fix this?
>

I think we could take the semaphore before checking driver and then
use __device_release_driver(). But we'd need to make it global or move
bind/unbind code into drivers/base/dd.c

--
Dmitry
