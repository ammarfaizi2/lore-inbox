Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTKIEa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 23:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTKIEa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 23:30:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:54145 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262176AbTKIEa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 23:30:27 -0500
Date: Sat, 8 Nov 2003 20:29:37 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bug (?) in subsystem kset refcounts
Message-ID: <20031109042936.GA8583@kroah.com>
References: <Pine.LNX.4.44L0.0311082209330.7127-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0311082209330.7127-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 10:20:03PM -0500, Alan Stern wrote:
> I hesitate to say this is definitely a bug, since it might be intended 
> behavior.  But it is rather strange.
> 
> Subsystems included an embedded kset, which itself includes an embedded 
> kobject and so is subject to reference counting.  Whenever a kobject 
> belonging to the kset is destroyed, the kset's reference count is 
> decremented.  However, kobjects can be added to a kset via the three 
> macros
> 
> 	kobj_set_kset_s, kset_set_kset_s, and subsys_set_kset
> 
> and these do _not_ increment the kset's reference count.  As a result, the 
> reference count only goes down, not up, quickly becoming negative.

See the patch that went into Linus's tree yesterday to fix where this
would happen.

But yes, usages of these macros is touchy, and we need to get it
correct.  Your proposed patch will never allow the reference counts to
go back to zero.

Also, notice that when the kobject is initialized, the kset set by these
macros is then incremented.

thanks,

greg k-h
