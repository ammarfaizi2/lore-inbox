Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWHIQEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWHIQEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWHIQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:04:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751038AbWHIQEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:04:30 -0400
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
From: David Smith <dsmith@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
In-Reply-To: <20060808162421.GA28647@infradead.org>
References: <20060807115537.GA15253@in.ibm.com>
	 <20060808162421.GA28647@infradead.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 11:01:45 -0500
Message-Id: <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 17:24 +0100, Christoph Hellwig wrote:
> On Mon, Aug 07, 2006 at 05:25:37PM +0530, Ananth N Mavinakayanahalli wrote:

... stuff deleted ...

>  
> +	/*
> +	 * If we have a symbol_name argument look it up,
> +	 * and add it to the address.  That way the addr
> +	 * field can either be global or relative to a symbol.
> +	 */
> +	if (p->symbol_name) {
> +		if (p->addr)
> +			return -EINVAL;
> +		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
> +	}

What if kprobe_lookup_name() fails or if CONFIG_KALLSYMS isn't set?  The
code following this might work, but the kprobe isn't going to be set at
the location that was intended.

Perhaps this needs something like:

	if (p->symbol_name) {
		if (p->addr)
			return -EINVAL;
		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
		if (p->addr == p->offset)
			return -EINVAL;
	}

-- 
David Smith
dsmith@redhat.com
Red Hat, Inc.
http://www.redhat.com
256.217.0141 (direct)
256.837.0057 (fax)


