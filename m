Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272236AbTGYRjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTGYRjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:39:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:50866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272230AbTGYRjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:39:51 -0400
Date: Fri, 25 Jul 2003 13:54:47 -0400
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030725175447.GB2410@kroah.com>
References: <20030725173900.D7DE12C2A9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725173900.D7DE12C2A9@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 04:00:18AM +1000, Rusty Russell wrote:
> Hi all,
> 
> 	When the initial module patch was submitted, it made modules
> start isolated, so they would not be accessible until (if)
> initialization had succeeded.  This broke partition scanning, and was
> immediately reverted, leaving us with a module reference count scheme
> identical to the previous one (just a faster implementation): we still
> have cases where modules can be access on failed load.
> 
> 	Then Dave decided that the work of reference counting network
> driver modules everywhere is too invasive, so network driver modules
> now have zero reference counts always.  The idea is that if you don't
> want the module removed, don't do it.  ie. only remove the module if
> there's a bug, or you want to replace it.

Hm, as long as we add a kobject to the module structure, so that users
of a module can be tracked somehow to know if it is safe to unload the
module or not.

This is because there is a difference between device reference counts,
and code reference counts, which is why I added the module owner logic
to sysfs attributes, to prevent code from being unloaded when the device
might already be gone.

So can the following situation still work with this proposed patch:
	- device created
	- sysfs files created associated with that device
	- user opens sysfs file
	- user disconnects sysfs files.
	- device goes away, driver no longer references device, but
	  kobject count is still incremented.
	- driver associated with device is unloaded.
	- user reads sysfs file previously opened (which calls into
	  module memory that is now gone.)

Can we still prevent this from happening now?  I think if we add a
kobject (or something, we still need a kobject to get module
parameters so might as well use that), we might be safe.

thanks,

greg k-h
