Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUF1VVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUF1VVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUF1VTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:19:37 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:7894 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S265224AbUF1VTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:19:13 -0400
Date: Mon, 28 Jun 2004 17:18:57 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Oliver Neukum <oliver@neukum.org>, scott@timesys.com, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628211857.GA5508@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com> <200406282257.11026.oliver@neukum.org> <20040628140343.572a0944.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628140343.572a0944.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 02:03:43PM -0700, David S. Miller wrote:
> You have not considered what is supposed to happen when this
> structure is embedded within another one.  What kind of alignment
> rules apply in that case?  For example:
> 
> struct foo {
> 	u32	x;
> 	u8	y;
> 	u16	z;
> } __attribute__((__packed__));
> 
> struct bar {
> 	u8		a;
> 	struct foo 	b;
> };

As long as bar is not packed, why shouldn't the beginning of bar.b be
aligned?

If you did it the other way around, and had bar packed but foo not
(or if both had nopadding specified), that would be a problem, and
should probably at least generate a warning (if not an error) if you
take the address of the inner struct.

However, doing something like that is already broken; if you use a
pointer to the inner struct rather than going through the base, GCC
will use normal loads and stores to unaligned data, without even a
warning.  Fixing that, other than by disallowing it, would likely
require making unalignedness a pointer qualifier.

-Scott
