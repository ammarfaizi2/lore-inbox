Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWCXVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWCXVTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCXVTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:19:50 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:58017 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751435AbWCXVTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:19:49 -0500
X-IronPort-AV: i="4.03,126,1141632000"; 
   d="scan'208"; a="1788149178:sNHT2647658980"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 0 of 18] ipath driver - for inclusion in 2.6.17
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1143175292@eng-12.pathscale.com>
	<ada4q1nr7pu.fsf@cisco.com>
	<1143227515.30626.43.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Mar 2006 13:19:32 -0800
In-Reply-To: <1143227515.30626.43.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Fri, 24 Mar 2006 11:11:55 -0800")
Message-ID: <adaveu3pml7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Mar 2006 21:19:33.0772 (UTC) FILETIME=[A584ACC0:01C64F88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Would your preference be to slap #ifdefs around those, or
    Bryan> to just require CONFIG_NET in Kconfig?  The core driver
    Bryan> should work fine without any kernel-level networking
    Bryan> support, so I suppose the former makes more sense.

Having #ifdef CONFIG_NET all over is definitely suboptimal.
Unfortunately it looks kind of hard to untangle your skb use from the
rest of the driver, so putting a dependency on NET might be the best bet.

    Bryan> That's going to be interesting to test, because I don't
    Bryan> have any ia64 hardware to even compile on.  I have tested
    Bryan> on x86_64 and powerpc, so this seems like an arch-level
    Bryan> header deficiency.  Any idea what to do about it?

How are you building on powerpc?  I don't see any way to turn on
CONFIG_PCI_MSI except on i386/x86_64 and ia64.

Anyway building an ia64 cross toolchain is easy with http://kegel.com/crosstool

I would just get rid of your atomic_clear_mask() and atomic_set_mask()
calls.  They're bogus because you're not even operating on an
atomic_t, and not many architectures implement them.  Just take a lock
if you need to modify the bitmap atomically.  A spinlock is cheaper
than two atomic operations (although I guess for a slow path, it hurts
in .text size).

    Bryan> I've been building with C=1 for months.  I'll see if I can
    Bryan> figure out why you're getting such different results.

It's probably because I use CF=-D__CHECK_ENDIAN__ too.

There are a few other things I don't think we've really closed on:

 - The whole duplicated SMA / ipath_verbs doesn't work without ib_mad loaded.

 - Andrew raised some questions about the special "pick a device for
   me" that I'm not sure we satisfied him on.  I don't find the
   /dev/ptmx argument that convincing, since I don't think /dev/ptmx
   is considered the best example of interface design.

 - It looks like ipath_copy.c is completely unused now that you're not
   including the ipath_ether driver.

 - R.
