Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTJAAcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJAAcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:32:21 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:8462 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261836AbTJAAcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:32:20 -0400
Date: Wed, 1 Oct 2003 02:32:11 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Arun Sharma <arun.sharma@intel.com>,
       linux-kernel@vger.kernel.org, kevin.tian@intel.com
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-ID: <20031001003211.GA1520@win.tue.nl>
References: <3F79ED60.2030207@intel.com> <20030930140805.0e3158e7.akpm@osdl.org> <20030930222556.GG24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930222556.GG24824@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 11:25:56PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 30, 2003 at 02:08:05PM -0700, Andrew Morton wrote:
> > Arun Sharma <arun.sharma@intel.com> wrote:
> > >
> > > Some drivers seem to use macros such as _IOR/_IOW in a way that ends up
> > > calling the sizeof() operator twice. For eg:
> > > 
> > > -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> > > +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)

But this changes the define. You want

#define FBIO_ATY128_GET_MIRROR	_IOR_BAD('@', 1, __u32*)

> +#define _IOR(type,nr,size)     _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)
> ))
> +#define _IOR_BAD(type,nr,size) _IOC(_IOC_READ,(type),(nr),sizeof(size))

Something else we should do is to change all occurrences of 'size'
here into 'argtype'. All this nonsense came because of the bad choice
of identifier.

