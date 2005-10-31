Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVJaVhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVJaVhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVJaVhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:37:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:19889 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932541AbVJaVhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:37:35 -0500
In-Reply-To: <4365775B.9080209@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]IPv6: doubt about ipv6_sk_mc_lock usage.
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF1E5FA9D.8ED1B981-ON882570AB.00756304-882570AB.0076CB1C@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Mon, 31 Oct 2005 13:37:46 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 10/31/2005 14:37:47,
	Serialize complete at 10/31/2005 14:37:47
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have one more question. 
> Why ip6_mc_source() uses read_lock_bh(&ipv6_sk_mc_lock) and 
ip6_mc_msfilter() 
> doesn't use ipv6_sk_mc_lock at all. 
> when ipv6_mc_list's sflist are accessed by inet6_mc_check(), Can it be 
> modified by ip6_mc_source() or ip6_mc_msfilter() ?
> (For example ipv6_mc_list's sflist is freed up by sock_kfree_s(), when 
> inet6_mc_check() uses it)

Yan,

There certainly may be a bug, but removing the lock isn't the fix. :-)

inet6_mc_check() does not have the socket locked, but is acquiring a
read lock on ipv6_sk_mc_lock.

I've looked some more into this, and I believe ip6_mc_msfilter() needs
at least a read lock on ipv6_sk_mc_lock to protect it from races with
changes to the list, just as ip6_mc_source() has.

I convinced myself at the time that the sflist does not require an
additional lock, but I don't see that now. It seems to me now that
there should be a lock on each individual socklist entry and changes
to the socket source filter should be protected by that. A simpler,
but less performant, fix would be to make both ipv6_mc_source() and
ip6_mc_msfilter() acquire ipv6_sk_mc_lock for writing, to prevent
races with inet6_mc_check's search of the sflist.

It'd be much better if only that socklist entry is locked, of course.

I'll look some more.

                        +-DLS

