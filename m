Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUALV4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUALV4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:56:18 -0500
Received: from [193.138.115.2] ([193.138.115.2]:26381 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266211AbUALV4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:56:14 -0500
Date: Mon, 12 Jan 2004 22:53:13 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH(s)][RFC] variable size and signedness issues in ldt.c -
 potential problem?
In-Reply-To: <Pine.LNX.4.56.0401110300080.13633@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.56.0401122243270.2130@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
 <Pine.LNX.4.58.0401090440180.27298@devserv.devel.redhat.com>
 <Pine.LNX.4.56.0401110300080.13633@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Found some errors in my earlier reply. I've added additional
comments below.
I've not quoted the long style cleanup patch in this reply as I trust you
can find it in the previous mail in the thread.
I've also not quoted the bits where I have no corrections - please see the
previous email for those.

On Sun, 11 Jan 2004, Jesper Juhl wrote:

>
> One additional thing I noticed in the ldt code is that it seems to me that
> there could be some bennefit to moving the declaration of 'bytes' in the
> for() loop in read_ldt() outside the loop. It gets initialized by
> 'bytes = size - i;' every time through the loop before it's used, so I se
> no reason to re-create the variable every time through the loop.
> If that makes sense, then here's a patch to make this change (it's against
> 2.6.1-mm1) :
>
> --- linux-2.6.1-mm1-orig/arch/i386/kernel/ldt.c	2004-01-09 19:04:23.000000000 +0100
> +++ linux-2.6.1-mm1-juhl/arch/i386/kernel/ldt.c	2004-01-11 03:36:02.000000000 +0100
> @@ -118,10 +118,11 @@ void destroy_context(struct mm_struct *m
>  	mm->context.size = 0;
>  }
>
> -static int read_ldt(void __user * ptr, unsigned long bytecount)
> +static int read_ldt(void __user *ptr, unsigned long bytecount)
>  {
>  	int err, i;
>  	unsigned long size;
> +	unsigned long bytes;
>  	struct mm_struct * mm = current->mm;
>
>  	if (!mm->context.size)
> @@ -144,7 +145,7 @@ static int read_ldt(void __user * ptr, u
>  	__flush_tlb_global();
>
>  	for (i = 0; i < size; i += PAGE_SIZE) {
> -		int nr = i / PAGE_SIZE, bytes;
> +		int nr = i / PAGE_SIZE;
>  		char *kaddr = kmap(mm->context.ldt_pages[nr]);
>
>  		bytes = size - i;
>
>
In the above patch 'unsigned long bytes;' should ofcourse have been
'int bytes' - I should have read the patch more closely after
running diff on my own tree.
As I've been unable to find any scenario where an int can actually
overflow there is ofcourse no need to change the type - my bad.


>
> > > and finally a purely style related thing (sure, call me pedantic); in both
> > > read_ldt() and write_ldt() 'mm' is declared as
> > >
> > > struct mm_struct * mm = current->mm;
> >
> > yep, you are right, this is the wrong style.
> >
>
> Ok, thank you for confirming that.
>
> Since this /is/ incorrect style I've created a patch to clean it up, as
> well as a bunch of other instances of the same style issue I found nearby.
> I certainly haven't cleaned up *all* instances of this inccorect style,
> but I have nailed 26 files with such instances, and I believe I've nailed
> all occourances of this style issue in those files.
>

After creating the initial cleanup patch I've noticed several more
instances of this 'bad style'. If there's any interrest in cleaning them
up I'll be happy to create a patch.  Is this wanted?


-- Jesper Juhl

