Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752038AbWCFIRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWCFIRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWCFIRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:17:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:6044 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752038AbWCFIQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:16:59 -0500
Date: Mon, 6 Mar 2006 08:16:51 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Dave Jones <davej@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306081651.GG27946@ftp.linux.org.uk>
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net> <20060306072346.GF27946@ftp.linux.org.uk> <20060306072823.GF21445@redhat.com> <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 09:56:22AM +0200, Pekka Enberg wrote:
> On 3/6/06, Dave Jones <davej@redhat.com> wrote:
> > I wonder if we could get away with something as simple as..
> >
> > #define kfree(foo) \
> >         __kfree(foo); \
> >         foo = KFREE_POISON;
> >
> > ?
> 
> It's legal to call kfree() twice for NULL pointer. The above poisons
> foo unconditionally which makes that case break I think.

Legal, but rather bad taste.  Init to NULL, possibly assign the value
if kmalloc(), then kfree() unconditionally - sure, but that... almost
certainly one hell of a lousy cleanup logics somewhere.

There's worse problem with that, though:
	kfree(container_of(......));
and it simply won't compile.
