Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272276AbTHIIJm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 04:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272277AbTHIIJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 04:09:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58020 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272276AbTHIIJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 04:09:40 -0400
Date: Sat, 9 Aug 2003 01:04:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030809010418.3b01b2eb.davem@redhat.com>
In-Reply-To: <20030809074459.GQ31810@waste.org>
References: <20030809074459.GQ31810@waste.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 02:44:59 -0500
Matt Mackall <mpm@selenic.com> wrote:

> The attached (lightly tested) patch gets rid of the SHA in the
> /dev/random code and replaces it with cryptoapi, leaving us with just
> one SHA implementation.
 ...
>  __u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
>  		__u16 dport, __u32 sseq, __u32 count, __u32 data)
 ...
> +	tfm = crypto_alloc_tfm("sha1", 0);

secure_tcp_syn_cookie() is called from software interrupt
context, therefore it may not sleep.

So you cannot call crypto_alloc_tfm() here, which can sleep.

Not to mention that calling crypto_alloc_tfm() for every TCP
connection creation is absurdly expensive.

Same thing in check_tcp_syn_cookie().

Also, same problem exists with extract_entropy() which also must be
callable from software interrupt context, and thus the
crypto_alloc_tfm() alloc calls you added there are illegal too.

This patch needs tons of work.
