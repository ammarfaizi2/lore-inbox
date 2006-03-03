Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752163AbWCCCoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbWCCCoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbWCCCoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:44:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:4548 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752163AbWCCCoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:44:06 -0500
Date: Fri, 3 Mar 2006 02:44:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Peterson <dsp@llnl.gov>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH 13/15] EDAC: kobject/sysfs fixes
Message-ID: <20060303024403.GA27946@ftp.linux.org.uk>
References: <200603021748.13853.dsp@llnl.gov> <20060302183153.452f93d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302183153.452f93d9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 06:31:53PM -0800, Andrew Morton wrote:
> Dave Peterson <dsp@llnl.gov> wrote:
> >
> > - After we unregister a kobject, wait for our kobject release method
> >    to call complete().  This causes us to wait until the kobject
> >    reference count reaches 0.  Otherwise, a task accessing the EDAC
> >    sysfs interface can hold the reference count above 0 until after the
> >    EDAC module has been unloaded.  When the reference count finally
> >    drops to 0, this will result in an attempt to call our release
> >    method inside the EDAC module after the module has already been
> >    unloaded.
> 
> That's not really the way to do it.  If you have all the correct
> module_get()s and try_module_get()s and module_put()s in all the right
> places, kenrel/module.c:wait_for_zero_refcount() should do this for you.

Fundamentally, you _can't_ wait for sysfs references to go away when 
doing rmmod.  You can fail with -EBUSY, but waiting is an instant deadlock.
Why?  Because rmmod your_turd </sys/something_from_your_turd is going to
wait for itself to exit if you do that.
