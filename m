Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbSJJVsC>; Thu, 10 Oct 2002 17:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSJJVrl>; Thu, 10 Oct 2002 17:47:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:16829 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262441AbSJJVqb>;
	Thu, 10 Oct 2002 17:46:31 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] EVMS core (3/9) discover.c
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDCDB46A2.2BDBA992-ON85256C4E.00748716@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 10 Oct 2002 17:05:00 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/10/2002 05:52:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/2002 at 03:48 PM, Andi Kleen wrote:

> > + list_for_each_entry(plugin, &plugin_head, headers) {
> > +       if (GetPluginType(plugin->id) == EVMS_DEVICE_MANAGER) {
> > +             spin_unlock(&plugin_lock);
> > +             DISCOVER(plugin, disk_list);
> > +             spin_lock(&plugin_lock);
> > +       }

> How do you know "plugin" and its successors are still valid when retaking
> the spinlock? Looks like you need a reference count on the object here.

The spinlock itself should protect the integrity of the
list. If a prev or next element in the list should be
removed, while in a discover function, then the prev
or next field in the current plugin will get updated,
but I don't believe that should cause the list_for_each_entry
macro problems traversing the remainding elements in the list.

The first instruction in every plugin's discover function
is a MOD_INC_USE_COUNT and the last before the return is
MOD_DEC_USE_COUNT. So there exists a small window by
which the current plugin might be unloaded between the
spinlock release and MOD_INC_USE_COUNT, and the
MOD_DEC_USE_COUNT and the spinlock reacquire.

We plan to register a "__this_module.can_unload()" that
should prevent plugin modules from unloading during
discovery.

Mark


