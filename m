Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTDHPAz (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTDHPAz (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:00:55 -0400
Received: from havoc.daloft.com ([64.213.145.173]:32484 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261824AbTDHPAy (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:00:54 -0400
Date: Tue, 8 Apr 2003 11:12:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
       zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
Message-ID: <20030408151226.GA30285@gtf.org>
References: <20030408035210.02D142C06E@lists.samba.org> <1049802672.8120.14.camel@dhcp22.swansea.linux.org.uk> <20030408144644.GB30142@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408144644.GB30142@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 03:46:44PM +0100, Jamie Lokier wrote:
> Alan Cox wrote:
> > > Unless you can come up with a real *reason*, I'll move it back under
> > > "deprecated" and start substituting.
> > 
> > Thats fun, and the rest of us can play submit patches to substitute it
> > back. 
> 
> If Jeff's drivers are using <kcompat>, can't kcompat provide the macro
> for 2.4 and 2.5 kernels in the same way it does for 2.2 kernels?

No.  Because Rusty wanted to replace a "func_call()" object with a
direct reference to a structure.  Direct struct member references is the
big issue that we are trying to _avoid_, because they are the single
most painful issue to deal with, WRT source back-compat.  You can ifdef
around a function quite easily, but not a direct struct member use.

To give another concrete example, I was able to take a 2.4 PCI driver
and make it work under 2.2 transparently, with a single exception:  The
"driver_data" member of the new struct pci_dev.  Drivers were directly
referencing that, which was a new addition in 2.4.x (really 2.3.x).  So,
I created the abstraction wrappers pci_[gs]et_drvdata(), which does
nothing but a simple C assignment (or read, for _get_).  The addition of
this wrapper removed the need for nasty ifdefs in the drivers for 2.2
versus 2.4, and make it possible for the kernel source to continue to be
readable, "pretty", and ifdef-free.

	Jeff



