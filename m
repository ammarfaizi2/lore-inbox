Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTLKJgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264892AbTLKJgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:36:36 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:59035
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264891AbTLKJgf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:36:35 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 10:36:33 +0100
User-Agent: KMail/1.5.4
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312101318330.850-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312101318330.850-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111036.33115.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 19:19, Alan Stern wrote:
> On Wed, 10 Dec 2003, Duncan Sands wrote:
> > On Wednesday 10 December 2003 18:34, David Brownell wrote:
> > > > Unfortunately, usb_physical_reset_device calls usb_set_configuration
> > > > which takes dev->serialize.
> > >
> > > Not since late August it doesn't ...
> >
> > In current 2.5 bitkeeper it does.
>
> I don't understand the problem.  What's wrong with dropping dev->serialize
> before calling usb_reset_device() or usb_set_configuration() and then
> reacquiring it afterward?

The problem is that between dropping the lock and usb_set_configuration (or
whatever) picking it up again, the device may be disconnected, so usb_set_configuration
needs to handle the case of being called after disconnect (it doesn't seem to
check for that right now, but I only had a quick look).  Also, after usbfs picks up
the lock again it needs to check for disconnect.  None of this is a big deal, but
it could all be avoided by a simpler change: provide a usb_physical_set_configuration
(or whatever), which is usb_set_configuration without taking dev->serialize.

Duncan.
