Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTKOUmC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTKOUmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:42:02 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:9606 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262071AbTKOUlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:41:55 -0500
Date: Sat, 15 Nov 2003 20:41:45 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Harald Welte <laforge@netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031115201444.GO24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311152031590.743-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > The thing to be aware of is that seq API is limited to 1 page of data per
> > read(2) call. Some people loudly proclaim "seq API is unlimited, unlike
> > the old /proc formalism which was limited to 1 page" but they are 
> > quiet about 1-page limitation for a single read(2) (due to hardcoded
> > kmalloc(size) in seq_file.c). Why is this important? Because if your
> 
> What?  It will happily return more than 1 page if you get an entry longer
> than that.
> 
> What hardcoded kmalloc(size)?
> 

in fs/seq_file.c:seq_read()

        if (!m->buf) {
                m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);


> > ->start/stop routines take/drop some spinlocks then you have to know your
> > position and re-verify it on the next read(2) if your data is more than 1
> > page and thus could not be read atomically (i.e. while holding the
> > spinlocks).
> 
> If you mean that read(2) can decide to return less than full user buffer even
> though more data is available - tough, that's something userland *must* be
> able to deal with.

are you saying that it is possible for userspace to request, say, 256K and 
say 250K of available data could be returned (with seq_file API) on a 
single read(2) call? I thought this is impossible and hence in the 
->show() routine I do this (similar to seq_printf()):

        struct task_struct *p = (struct task_struct *)v;
        struct proc *proc = (struct proc *)m->private;

	pack some data from task_struct into 'proc' ...

        if (m->count + PROCLEN < m->size) {
                memcpy(m->buf + m->count, proc, PROCLEN);
                m->count += PROCLEN;
                return 0;
        } else {
                m->count = m->size;
                return -1;
        }

So, as soon as ->show() is asked to display an element which didn't fit in
the m->buf page it returns -1 and so the user gets a page (or almost a
page, i.e.  as many entries as fit in there).

If you know of a way to return more than a page of data in one go, please 
do tell me.

But if such way existed then why in mm/slab.c:s_start() does exactly what 
I described, i.e. walks the list to the offset '*pos' saved from previous 
page?

Kind regards
Tigran

> 
> Especially on syntetic and potentially large files - the only alternative
> would be immediate DoS on OOM.  Regardless of the implementation.
> 


