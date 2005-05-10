Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVEJKPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEJKPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVEJKPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:15:42 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:27328 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261584AbVEJKPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:15:36 -0400
Message-ID: <42808B84.BCC00574@tv-sign.ru>
Date: Tue, 10 May 2005 14:23:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru>
	 <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org> <Pine.LNX.4.58.0505091449580.29090@graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> 
> On Mon, 9 May 2005, Andrew Morton wrote:
> 
> > ptype_base is an array, but I cannot see any race around ptype_base.  So
> > look to see if ptype_base is corrupted as well, keep walking back through
> > memory, see where the scribble starts.
> 
> There is no corruption around ptype_all as you can see from the log. There
> is a list of hex numbers which are from ptype_all -8 to ptype_all +8.
> Looks okay to me.

Still ptype_all could be accessed (and corrupted) as ptype_base[16].

Christoph, could you please reboot with this patch?
Just to be sure.

--- 2.6.12-rc4/net/core/dev.c~	Tue May 10 12:24:11 2005
+++ 2.6.12-rc4/net/core/dev.c	Tue May 10 14:19:29 2005
@@ -157,7 +157,9 @@
 
 static DEFINE_SPINLOCK(ptype_lock);
 static struct list_head ptype_base[16];	/* 16 way hashed list */
+static unsigned long ptype_before[4] = { [0 ... 3] = -1 };
 static struct list_head ptype_all;		/* Taps */
+static unsigned long ptype_after[4] = { [0 ... 3] = -1 };
 
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy);
