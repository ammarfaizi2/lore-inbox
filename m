Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTI3V1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTI3V1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:27:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53522 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261753AbTI3V1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:27:13 -0400
Date: Tue, 30 Sep 2003 22:27:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] expand_resource
Message-ID: <20030930222708.A10154@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Tue, Sep 30, 2003 at 10:04:10PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:04:10PM +0100, Matthew Wilcox wrote:
> Rewrite expand_resource() to be racefree and move it to kernel/resource.c.
> 
>...
> +/*
> + * Expand an existing resource by size amount.
> + */
> +int expand_resource(struct resource *res, unsigned long size,
> +			   unsigned long align)
> +{

Could we have the kerneldoc stuff added to this function?  My main
question though is - what is the intended purpose of "align" ?  As
it is implemented, it seems to have a weird behaviour:

- if we expand the "end" of the resource, we round it towards an
  address which is a multiple of align, but "start" may not be
  a multiple of align.
- if we expand "start", we round it down towards a multiple of
  align.  However, "end" may not be a multiple of align.

This may actually be of use to PCMCIA IO space handling - we only
have two windows, but we may need to expand them if we have a multi-
function card if we have more than 2 areas to map.  In this case,
we'd need to know whether "start" was expanded or "end" was expanded
since we can't change the use of the already-allocated resource.

It may make sense to do something more generic, like:

int adjust_resource(struct resource *res, unsigned long start,
		    unsigned long end);

so that the caller knows what he's requesting and knows whether that
change succeeded or failed.  However, it is something I'd need to
look deeper into when I have more time available to look at such
stuff, so please don't take the above as a well thought-out solution.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
