Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSLUGvj>; Sat, 21 Dec 2002 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSLUGvi>; Sat, 21 Dec 2002 01:51:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41438 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266535AbSLUGvi>;
	Sat, 21 Dec 2002 01:51:38 -0500
Date: Fri, 20 Dec 2002 22:54:11 -0800 (PST)
Message-Id: <20021220.225411.34743908.davem@redhat.com>
To: maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1040313919.2650.31.camel@localhost>
References: <1040225146.1873.21.camel@localhost>
	<1040313919.2650.31.camel@localhost>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bunch of problems with this patch:

1) Module leak.  If try_module_get(npf->owner) works but sock_alloc()
   fails, we never put the module.  It just branches to the "out"
   label in that case, which unlocks the net_family table and returns
   err.

2) Bigger issue, why not attach the owner to struct sock
   instead of socket?  The sock can exist, and thus reference
   the protocol family code, long after the socket (ie. the
   user end) is killed off and closed.

   For example, this could happen for just about any protocol family
   due to stray device sk_buff references to the sock and thus the
   protocol family.

Please address this stuff.
