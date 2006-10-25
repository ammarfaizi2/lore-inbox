Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWJYNVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWJYNVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWJYNVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:21:36 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:30987 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965211AbWJYNVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:21:36 -0400
Date: Wed, 25 Oct 2006 09:17:47 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, akpm@osdl.org,
       maxk@qualcomm.com, linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Message-ID: <20061025131747.GA8141@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <1161660875.10524.535.camel@localhost.localdomain> <20061024125306.GA1608@hmsreliant.homelinux.net> <1161729762.10524.660.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161729762.10524.660.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 08:42:42AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-10-24 at 08:53 -0400, Neil Horman wrote:
> > On Tue, Oct 24, 2006 at 01:34:34PM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2006-10-23 at 13:19 -0400, Neil Horman wrote:
> > > > Hey All-
> > > > 	Janitor patch to clean up return code handling and exit from failed
> > > > calls to misc_register accross several modules.
> > > 
> > > The patch doesn't match the description... What are those INIT_LIST_HEAD
> > > things ? Is this something I've missed or is this a new requirement for
> > > all misc devices ? Can't it be statically initialized instead ?
> > > 
> > 
> > The INIT_LIST_HEAD is there to prevent a potential oops on module removal.
> > misc_register, if it fails, leaves miscdevice.list unchanged.  That means its
> > next and prev pointers contain NULL or garbage, when both pointers should contain
> > &miscdevice.list. If we don't do that, then there is a chance we will oops on
> > module removal when we do a list_del in misc_deregister on the moudule_exit
> > routine.  I could have done this statically, but I thought it looked cleaner to
> > do it with the macro in the code.
> 
> Hrm... I see, but I still for some reason don't like it that much.. I'd
> rather have misc_register() do the initialisation unconditionally before
> it can fail, don't you think ?
> 
> We would theorically have a similar problem with any driver that does
> 
> 
> xxxx_register(&static_struct)
> 
> and
> 
> xxxx_unregister(&static_struct)
> 
> (pci, usb, etc...)
> 
> As long as there are list heads involved. I think the proper solution
> here is to have either the unregister be smart and test for NULL/NULL or
> the register initialize those fields before it has a chance to fail.
> 
> Ben.
> 

I agreed with you in my last note regarding this, I think moving the
INIT_LIST_HEAD inside the misc_register function is a good idea, but since this
is a cleanup patch with several other fixups in it, I'd just as soon get this
integrated, and make that change in a separate patch.

Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
