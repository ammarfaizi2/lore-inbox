Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266317AbUGAWva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUGAWva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUGAWva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:51:30 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:421 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266317AbUGAWv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:51:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: PPC64: vio_find_node removal?
Date: Thu, 1 Jul 2004 17:51:25 -0500
User-Agent: KMail/1.6.2
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
References: <200407011454.55440.dtor_core@ameritech.net> <1088720772.22742.21.camel@localhost>
In-Reply-To: <1088720772.22742.21.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011751.25738.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 05:26 pm, Hollis Blanchard wrote:
> On Thu, 2004-07-01 at 14:54, Dmitry Torokhov wrote:
> 
> > kset_find_obj that is now only used by vio_find_name/vio_find_node needs to
> > take kobject reference otherwise use of this function is generally unsafe.
> > 
> > I was looking at vio_find_name users and it is only used in rpaphp hotplug
> > driver. When creating a hotplug slot the function first tries to find already
> > existing vio node and if unsuccessfull tries to create a new one. The only
> > time when vio node would already exist if previous call to register_vio_slot
> > failed (the function does not do cleanup of created vio device node and it's
> > the only place where vio devices are created). So it seems to me that if
> > register_vio_slot would do proper cleanup we can get rid of vio_find_name/
> > vio_find_node.
> 
> At boot time, all the virtual IO devices are registered and matched with
> their drivers (or not). Later on (possibly when loading a module),
> rpaphp initializes. rpaphp needs a reference to the already-registered
> VIO devices so that it can hotplug-remove them later by calling
> vio_unregister_device().
>

Ah, I see.. I missed the call to vio_register_device_node in
probe_bus_pseries...

Ok, so if we add call to kobject_get in kset_find_obj we can just add
kobject_put right in vio_find_name because there can be only one-to-one
match between a slot and a vio device and we don't need refcounting there,
right?

-- 
Dmitry
