Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbVJYGoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVJYGoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 02:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVJYGoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 02:44:23 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:7657 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751471AbVJYGoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 02:44:23 -0400
Date: Tue, 25 Oct 2005 08:44:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, jglauber@redhat.com, xenia@us.ibm.com,
       wein@de.ibm.com
Subject: Re: dev->release = (void (*)(struct device *))kfree;
Message-ID: <20051025064416.GA14902@osiris.boeblingen.de.ibm.com>
References: <20051024201018.153550d6.zaitcev@redhat.com> <1130214982.7919.96.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130214982.7919.96.camel@gaston>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 02:36:21PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2005-10-24 at 20:10 -0700, Pete Zaitcev wrote:
> > I seem to recall the discussion about this, but very dimly. Would someone
> > be so kind to remind me, why the attached patch cannot be used?
> 
> If your struct device becomes a member of your vmlogrdr_priv structure,
> then you need to tie the lifetime of that structure to the one of the
> struct device kobject. Thus, you need to provide a "release" callback
> that frees your entire vmlogrdr_priv structure and of course not free it
> yourself (but simply consider it lost after you have called
> device_unregister).
> 
> In addition, if you are in the module, you get into funky issues since
> you must make sure your free routine doesn't "go away" with your module
> before the object is freed (it may be held a long time in memory by some
> userland thing opening a sysfs file to it). If you set the owner field
> of the kobj, your module should be held there (but may become totally
> un-rmmod'able in some circumstances, how fun...)
> 
> If you need to keep your vmlogrdr_priv structure around a little while
> longer after device_unregister(), just increase it's refcount before
> doing device_unregister() and drop it when you don't need it anymore. It
> will still be unregistered (removed from the various lists) but the
> release() callback won't be called until the last user.

For the same reason I tried several times to _introduce_ the 
"dev->release = (void (*)(struct device *))kfree" stuff in the zfcp device
driver, but Greg objected every time that it wouldn't be necessary.
I still disagree with him and that's why the zfcp module doesn't have a
module_exit function :)

Heiko
