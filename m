Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWJXWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWJXWna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWJXWna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:43:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:27604 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422771AbWJXWn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:43:29 -0400
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
	several drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, akpm@osdl.org,
       maxk@qualcomm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061024125306.GA1608@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <1161660875.10524.535.camel@localhost.localdomain>
	 <20061024125306.GA1608@hmsreliant.homelinux.net>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:42:42 +1000
Message-Id: <1161729762.10524.660.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 08:53 -0400, Neil Horman wrote:
> On Tue, Oct 24, 2006 at 01:34:34PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2006-10-23 at 13:19 -0400, Neil Horman wrote:
> > > Hey All-
> > > 	Janitor patch to clean up return code handling and exit from failed
> > > calls to misc_register accross several modules.
> > 
> > The patch doesn't match the description... What are those INIT_LIST_HEAD
> > things ? Is this something I've missed or is this a new requirement for
> > all misc devices ? Can't it be statically initialized instead ?
> > 
> 
> The INIT_LIST_HEAD is there to prevent a potential oops on module removal.
> misc_register, if it fails, leaves miscdevice.list unchanged.  That means its
> next and prev pointers contain NULL or garbage, when both pointers should contain
> &miscdevice.list. If we don't do that, then there is a chance we will oops on
> module removal when we do a list_del in misc_deregister on the moudule_exit
> routine.  I could have done this statically, but I thought it looked cleaner to
> do it with the macro in the code.

Hrm... I see, but I still for some reason don't like it that much.. I'd
rather have misc_register() do the initialisation unconditionally before
it can fail, don't you think ?

We would theorically have a similar problem with any driver that does


xxxx_register(&static_struct)

and

xxxx_unregister(&static_struct)

(pci, usb, etc...)

As long as there are list heads involved. I think the proper solution
here is to have either the unregister be smart and test for NULL/NULL or
the register initialize those fields before it has a chance to fail.

Ben.


