Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTKOVaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTKOVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:30:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15848 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262050AbTKOVay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:30:54 -0500
Date: Sat, 15 Nov 2003 21:30:53 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115213053.GQ24159@parcelfarce.linux.theplanet.co.uk>
References: <20031115201444.GO24159@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311152031590.743-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311152031590.743-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 08:41:45PM +0000, Tigran Aivazian wrote:
> in fs/seq_file.c:seq_read()
> 
>         if (!m->buf) {
>                 m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);

... and below
                m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);

> are you saying that it is possible for userspace to request, say, 256K and 
> say 250K of available data could be returned (with seq_file API) on a 
> single read(2) call? I thought this is impossible and hence in the 

> So, as soon as ->show() is asked to display an element which didn't fit in
> the m->buf page it returns -1 and so the user gets a page (or almost a
> page, i.e.  as many entries as fit in there).

a) it's not a page; if any ->show() will need more, buffer will grow.

b) unless you are willing to allocate 250Kb per read(), you *can't* do
what you are asking for.  Regardless of implementation.  Which is an
immediate DoS (again, regardless of implementation).

read() is not atomic.  Never had been.  With seq_file you are guaranteed
that what you get will consist of entire entries (IOW, if previous read()
had ended inside the entry, the rest will be preserved for the next read()).
There are no stronger warranties and there never had been.
