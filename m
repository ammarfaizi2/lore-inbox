Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262010AbTCQWNu>; Mon, 17 Mar 2003 17:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbTCQWNu>; Mon, 17 Mar 2003 17:13:50 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:22178 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262010AbTCQWNt>; Mon, 17 Mar 2003 17:13:49 -0500
Message-Id: <200303172224.h2HMO0Gi014874@locutus.cmf.nrl.navy.mil>
To: linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [ATM] first pass at fixing atm spinlock
In-reply-to: Your message of "Wed, 05 Mar 2003 10:08:46 EST."
             <OFAFD4106C.6053931B-ON85256CE0.004F1DD6@gdeb.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 17 Mar 2003 17:24:00 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch

this should apply cleanly to the stock 2-5-64 sources.  its an attempt
to make the atm spinlock a little less obnoxious.  atm_dev_lock is now a
read/write lock that now protects the list of atm devices.  an individual
spinlock protect the various members of atm_dev, like the vcc list and
addr lists.  atm_dev's are refcounted, so there is no longer any need
to hold a lock across the ioctl.  atm_find_dev is gone, in favor of
atm_dev_lookup, atm_dev_release, and atm_dev_hold.  atm_dev_lookup()
and atm_dev_hold() increment the ref count.  atm_dev_release() drops
the ref count.

this patch also makes atm and clip modular.  the clip arp 'interface' in
ipv4/arp.c isn't very pretty.  it seems to me that there should be a
better way.  anyway, instead of clip_tbl, its now clip_tbl_hook which
is exported for the clip module to set as it desires (the atm proc interface
also uses this instead of exporting clip_tbl via atm_clip_ops)

things are not set in stone yet, so i would like some advice -- the per 
device vcc list will probably be traversed (read-only) in the bottom
half of the kernel during receive for some adapters.  is it simply
enough to use list_for_each_safe() when traversing the list?  otherwise
the per device spinlock will need to shared between the top and bottom half
of the kernel.  the vcc's shouldnt need to be ref counted since they
are rather tightly coupled to a struct sock which is.  i dont like
the 'shutdown on last reference' in atm_dev_release().  you can only
safely call release when you know you can sleep.  is shutdown_atm_dev()
really that useful?

i would like a few brave souls test and comment on this code.  i could
possibly provide a 2.4.20 patch in a couple days.
