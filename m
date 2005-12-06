Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbVLFDgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbVLFDgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbVLFDgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:36:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751578AbVLFDgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:36:46 -0500
Date: Tue, 6 Dec 2005 14:36:31 +1100
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: nfs unhappiness with memory pressure
Message-Id: <20051206143631.08b4e8e6.akpm@osdl.org>
In-Reply-To: <1133822367.8003.5.camel@lade.trondhjem.org>
References: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>
	<1133822367.8003.5.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> Argh... Not sure entirely how to deal with that... We definitely don't
>  want the thing futzing around inside throttle_vm_writeout(), 'cos
>  writeout isn't going to happen while the socket blocks.
> 

As far as the core VM is concerned, these pages are really "dirty", only it
happens to be a different flavour of dirtiness.  So perhaps we should
continue to mark these pages as dirty and let NFS internally take care
of which end of the wire they're dirty at.

Presumably calling writepage() a second time won't be very useful.  Or will
it?  Perhaps when NFS sees writepage against a PageDirty && PageUnstable
page it can recognise that as a hint to kick off a server-side write.

>  ...OTOH, I'm not entirely sure we want to use GFP_ATOMIC and risk
>  bleeding the emergency pools dry: we also need those in order to receive
>  replies from the server.

You can use (GFP_ATOMIC & !__GFP_HIGH) to avoid draining emergency pools.

