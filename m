Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUI1V60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUI1V60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUI1V60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:58:26 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:33452 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S268054AbUI1V6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:58:19 -0400
Subject: Re: [patch] inotify: use the idr layer
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096407964.4911.90.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <1096407964.4911.90.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096408694.16622.1.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 17:58:14 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.28.3
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+       spin_lock(&dev->lock);
+       ret = idr_get_new(&dev->idr, watcher, &watcher->wd);
+       spin_lock(&dev->lock);

I think you mean spin_unlock on the third line? Other than that I think
it should work.

John
On Tue, 2004-09-28 at 17:46, Robert Love wrote:
> OK, I told John I would post this ASAP, as soon as I finished testing
> it, but I got backed up, so here it is without much testing.  It does
> compile fine.
> 
> This patch removes our current bitmap-based allocation system and
> replaces it with the idr layer.  The idr layer allows us to use a radix
> tree, rooted at each device instance, to trivially map between watcher
> descriptors and watcher structures.  In idr terminology, the watcher
> descriptor is the id and the watcher structure is the pointer.
> 
> Allocating a new watcher descriptor and associating it with a given
> watcher structure is done in the same place as before,
> inotify_dev_get_wd().  The code for doing this is a bit weird.  The idr
> layer's interface leaves a bit to be desired.
> 
> The function dev_find_wd() is used to map from a given watcher
> descriptor to a watcher structure.  This used to be our least scalable
> function: O(n), but at a small fixed n, so you could call it O(1).  Now
> it is O(lg n); n is still fixed, so you can still call it O(1).
> 
> I also cleaned up some locking and added some comments.
> 
> Like I said, I have not tested this, probably won't until tomorrow, but
> here it is to play with earlier if anyone so chooses.  The idr layer is
> rather nice for this sort of thing.
> 
> Patch is on top of all of my previous patches.
> 
> 	Robert Love
> 
