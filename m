Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUDRJhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDRJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 05:37:12 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:4000 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263107AbUDRJhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 05:37:09 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Sun, 18 Apr 2004 11:35:28 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <200404172217.10994.baldrick@free.fr> <200404172233.03552.oliver@neukum.org>
In-Reply-To: <200404172233.03552.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404181136.32308.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 April 2004 22:33, Oliver Neukum wrote:
> > riddled with races of this kind.  The simplest solution is to
> > systematically take ps->dev->serialize when entering the usbfs routines,
> > which is what my patches do.  This should be regarded as a first step: it
>
> What is the alternative?

The alternative is to start at the lower levels and work up (while here I propose
starting at the top levels and working down): trying to lock small regions in many
places.  I rejected this as too error prone (remember that usbfs is a bit of a mess).
Anyway, if done correctly the end result would be much the same as applying this
patch and doing step (2).

> > gives correctness, but at the cost of a probable performance hit.  In
> > later steps we can (1) turn dev->serialize into a rwsem
>
> Rwsems are _slower_ in the normal case of no contention.

Right, but remember that dev->serialize is per device, not per interface.  So if two
programs grab different interfaces of the same device using usbfs, or if multiple
threads in the same program beat on the same interface, then they could lose time
fighting for dev->serialize when in fact they could run in parallel.  Personally I doubt
it matters much, but since most of usbfs only requires read access to the data structures
protected by dev->serialize, it seems logical to use a rwsem.

> > (2) push the acquisition of dev->serialize down to the lower levels as
> > they are fixed up.
>
> Why?

Efficiency.  The main reason is that the copy to/from user calls are inside the locked region :)
As for the other places where the lock could be dropped, I guess measurement is required to
see if it gains anything.

Ciao,

Duncan.
