Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTKQIsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 03:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTKQIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 03:48:12 -0500
Received: from holomorphy.com ([199.26.172.102]:16803 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263400AbTKQIsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 03:48:09 -0500
Date: Mon, 17 Nov 2003 00:48:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117084804.GB22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20031117083007.GA22764@holomorphy.com> <Pine.LNX.4.44.0311170832030.1089-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311170832030.1089-100000@einstein.homenet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 08:38:24AM +0000, Tigran Aivazian wrote:
> The reason why I didn't use pread(2) is because I have to do multiple
> calls to read(2). There is no way that I know of to pack more than a
> single page into a single read(2) with seq_file API.

Well, one way to do it is to say that if you don't get a short read,
then the file is longer.


On Mon, Nov 17, 2003 at 08:38:24AM +0000, Tigran Aivazian wrote:
> Yes, I remember Al saying "it's not a page" but in practice it still
> appears to be limited to a page unless someone shows a sample seq_file
> module which can provide more than a page of data on a single read(2). The
> implementations I have looked at in the kernel (e.g. mm/slab.c) are
> limited to a single page per read(2).

There's a retry loop where the buffer size is doubled each iteration
that looks to me like automagic sizing in the code for seq_read(). I
can't say I've actually tried to rely on getting more than a page
at a time through seq_read(), though.


-- wli


The retry loop:

        while (1) {
                pos = m->index;
                p = m->op->start(m, &pos);
                err = PTR_ERR(p);
                if (!p || IS_ERR(p))
                        break;
                err = m->op->show(m, p);
                if (err)
                        break;
                if (m->count < m->size)
                        goto Fill;
                m->op->stop(m, p);
                kfree(m->buf);
                m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
                if (!m->buf)
                        goto Enomem;
                m->count = 0;
        }
