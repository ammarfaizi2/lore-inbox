Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTFPSBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTFPSBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:01:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264097AbTFPSBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:01:45 -0400
Date: Mon, 16 Jun 2003 19:15:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Martin Diehl <lists@mdiehl.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030616181538.GQ6754@parcelfarce.linux.theplanet.co.uk>
References: <20030616182003.D13312@flint.arm.linux.org.uk> <Pine.LNX.4.44.0306161937010.2079-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306161937010.2079-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 08:00:33PM +0200, Martin Diehl wrote:
> with old procfs one would like to set the owner field of the 
> corresponding struct proc_dir_entry and/or file_operations at this point.
> 
> > - userspace opens new file (this does not increment the device drivers
> >   use count.)
> 
> given owner=THIS_MODULE was set, this would bump the module's use count

... and for objects that have lifetime different from that of any module
this approach fucks up with procfs just as badly as with sysctl or sysfs.

Folks, _forget_ modules.  ->owner is OK for many things, but for stuff
like procfs it's not enough.  It only protects code.  procfs and sysfs
entries are _data_.  And in cases when it is OK the data is protected
by separate refcounts.

Folks, please, stop assuming that rmmod is the root of all evil and/or
place to deal with said evil.  Objects can be and are destroyed regardless
of rmmod.
