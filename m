Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUALWMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUALWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:12:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:47787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266495AbUALWMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:12:44 -0500
Date: Mon, 12 Jan 2004 14:13:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH(s)][RFC] variable size and signedness issues in ldt.c -
 potential problem?
Message-Id: <20040112141350.085d32dc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0401122243270.2130@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
	<Pine.LNX.4.58.0401090440180.27298@devserv.devel.redhat.com>
	<Pine.LNX.4.56.0401110300080.13633@jju_lnx.backbone.dif.dk>
	<Pine.LNX.4.56.0401122243270.2130@jju_lnx.backbone.dif.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> 
> >
> > -static int read_ldt(void __user * ptr, unsigned long bytecount)
> > +static int read_ldt(void __user *ptr, unsigned long bytecount)
> >  {
> >  	int err, i;
> >  	unsigned long size;
> > +	unsigned long bytes;
> >  	struct mm_struct * mm = current->mm;
> >
> >  	if (!mm->context.size)
> > @@ -144,7 +145,7 @@ static int read_ldt(void __user * ptr, u
> >  	__flush_tlb_global();
> >
> >  	for (i = 0; i < size; i += PAGE_SIZE) {
> > -		int nr = i / PAGE_SIZE, bytes;
> > +		int nr = i / PAGE_SIZE;
> >  		char *kaddr = kmap(mm->context.ldt_pages[nr]);
> >
> >  		bytes = size - i;
> >

There is no additional overhead with the original code and it has the
advantage that the scope of `bytes' covers the minimum amount of code.  I
see no need to change this.

Well.  There is a little bit of overhead of the code does:

foo()
{
	...
	{
		int i;
		...
	}
	...
	{
		int i;
		...
	}
	...
}

because the compiler (some versions, at least) will use eight bytes of
stack rather than four.  But this is rarely a problem.

> After creating the initial cleanup patch I've noticed several more
> instances of this 'bad style'. If there's any interrest in cleaning them
> up I'll be happy to create a patch.  Is this wanted?

I'd say that this and the whitespace adjustments are far too trivial to be
raising patches at this time.

