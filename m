Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVAUWuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVAUWuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAUWuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:50:21 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13264
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262532AbVAUWuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:50:02 -0500
Date: Fri, 21 Jan 2005 14:47:38 -0800
From: "David S. Miller" <davem@davemloft.net>
To: David Dillow <dave@thedillows.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, dave@thedillows.org
Subject: Re: [RFC 2.6.10 3/22] xfrm: Add offload management routines
Message-Id: <20050121144738.7155893e.davem@davemloft.net>
In-Reply-To: <20041230035000.12@ori.thedillows.org>
References: <20041230035000.11@ori.thedillows.org>
	<20041230035000.12@ori.thedillows.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 03:48:35 -0500
David Dillow <dave@thedillows.org> wrote:

> +static inline struct xfrm_offload *
> +xfrm_offload_alloc(int sizeof_priv, struct net_device *dev)

This whole scheme looks buggy.  The intent is to 8-byte align
the object, but look at what the code is actually doing.

Whatever kmalloc() returns to xfrm_offload_alloc() is directly
used as the xfrm_offload pointer, and the members are initialized.

Then xfrm_offload_priv() does the alignments.

It is clear that kmalloc() is always giving you 8-byte aligned
data else the first time xfrm_offload_priv() is used you'd
get a bogus pointer since xfrm_offload_alloc() initialized
the object without first aligning the pointer.

We do something similar when we allocate netdevs, so have a look
at how net/core/dev.c:alloc_netdev() works.
