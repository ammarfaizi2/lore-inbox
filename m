Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTGHRJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTGHRJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:09:43 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:9226 "EHLO
	light-brigade.mit.edu") by vger.kernel.org with ESMTP
	id S264486AbTGHRJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:09:40 -0400
Date: Tue, 8 Jul 2003 13:24:17 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerald Britton <gbritton@alum.mit.edu>, emperor@EmperorLinux.com,
       LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_ sub-optimal
Message-ID: <20030708132417.B10882@light-brigade.mit.edu>
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think> <200307071412.00625.durey@EmperorLinux.com> <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk> <20030708112016.A10882@light-brigade.mit.edu> <1057678950.4358.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1057678950.4358.53.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jul 08, 2003 at 04:42:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 04:42:30PM +0100, Alan Cox wrote:
> On Maw, 2003-07-08 at 16:20, Gerald Britton wrote:
> > Some of them have issues with PCI resource allocation though.  Their BIOSes
> > don't allocate resources to Cardbus bridges so insertted devices can't get
> > resources and last i checked, we didn't handle this fixup.
> 
> Thats actually a Linux bug.
> 
> > On the notebooks I worked with it required relocating the AGP bridge and
> > several other devices to make all the resources work out (quick hack is to
> > just shove new resources into the config registers prior to the kernel's
> > initial pci scan).
> 
> Interesting. I wonder why our fixup would have failed - its not something I've
> seen but we should fixup cardbus resource blocks (2.4 isnt smart enough to
> handle multidevice cardbus but Rmk has 2.5 code that is), but for the normal
> case it ought to have worked.

Is it smart enough to handle a case like this:

[device resource 00-01]
[bridge resource 01-04]
   [device resource 01-02]
   [cardbus bridge no resources]
   [cardbus bridge no resources]
   [device resource 02-04]
[bridge resoruce 04-06]
   [device resource 04-06]
[device resource 06-07]

Numbers simplified for example purposes.  The cardbus bridges are behind a
PCI-PCI bridge, and in this case, that bridge's resources need to be expanded
to allow the cardbus cards to have any resources since it's already full.
and the top level devices will need to be moved to allow space for the bridge
to expand.  Glancing through the 2.5 pci init for i386 it doesn't look like it
does things differently from 2.4.  IIRC, it's smart enough to handle things
if the cardbus bridge is at the top level (we allocate when the cardbus bridge
driver is loaded), but this will fail if it cannot allocate it (as is the case
when it's behind a full bridge).

				-- Gerald

