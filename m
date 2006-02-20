Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWBTQn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWBTQn5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWBTQn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:43:57 -0500
Received: from stinky.trash.net ([213.144.137.162]:29658 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1161025AbWBTQn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:43:57 -0500
Message-ID: <43F9F16D.4060802@trash.net>
Date: Mon, 20 Feb 2006 17:42:21 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwin.torok@level7.ro>,
       netfilter-devel@lists.netfilter.org,
       fireflier-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       martinmaurer@gmx.at
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both
 incoming and outgoing packets
References: <200602181410.59757.edwin.torok@level7.ro> <Pine.LNX.4.64.0602201122330.21034@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.64.0602201122330.21034@excalibur.intercode>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> Have a look at my skfilter patches:
> http://people.redhat.com/jmorris/selinux/skfilter/kernel/
> 
> These implement a scheme for matching incoming packets against sockets by 
> adding a new hook in the socket layer.
> 
> For upstream merge, the issues are:
> - should the new socket hook be used for all incoming packets?
> - ensure IP queuing still works
> 
> Patrick: any other issues?

Confirmation of conntrack entries. They shouldn't be confirmed before
packets have passed the socket hooks. This is the tricky part because
we don't know if packets will be delivered to a raw socket or not
when calling the regular LOCAL_IN hook. The only way to solve this
seems to be to use the socket hooks for all incoming packets, that
way we can defer confirmation unconditionally. The nicest way would
be to just move the regular LOCAL_IN hook to the socket hooks, but
this doesn't work with SNAT in LOCAL_IN because the socket lookup
needs the already NATed address.

I'll probably continue to work on this soon unless someone beats
me to the punch.
