Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269629AbUICJkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269629AbUICJkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269627AbUICJkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:40:08 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:19364 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269620AbUICJjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:39:24 -0400
Date: Fri, 3 Sep 2004 11:39:02 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: Simon Derr <Simon.Derr@bull.net>
cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible race in sysfs_read_file() and sysfs_write_file()
In-Reply-To: <Pine.A41.4.53.0409031056280.122970@isabelle.frec.bull.fr>
Message-ID: <Pine.A41.4.53.0409031134040.122970@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
 <20040901163436.263802bc.akpm@osdl.org> <Pine.A41.4.53.0409020917350.122970@isabelle.frec.bull.fr>
 <20040902155758.1eba30a5.akpm@osdl.org> <Pine.A41.4.53.0409031056280.122970@isabelle.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Simon Derr wrote:

> On Thu, 2 Sep 2004, Andrew Morton wrote:
>
> > Simon Derr <Simon.Derr@bull.net> wrote:
> > >
> > > @@ -140,13 +145,17 @@
> > >   	struct sysfs_buffer * buffer = file->private_data;
> > >   	ssize_t retval = 0;
> > >
> > >  -	if (!*ppos) {
> > >  +	down(&buffer->sem);
> > >  +	if ((!*ppos) || (!buffer->page)) {
> > >   		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
> > >  -			return retval;
> > >  +			goto out;
> >
> > Why are we testing *ppos at all in here?
>
> And if we open a sysfs file with O_RDWR, and write() into it, then this is
> needed if we want to read(), because else the buffer will have been
> allocated, but ops->show() not called. I'm not too sure about this being
> useful either.

Hmmm...
We are still screwed if we read at offset >0 after a write.

Possible fix would be to add a 'dirty' flag to the sysfs_buffer when
write() is called, so we force a call to fill_read_buffer() on the next
read().

Or maybe simply forbid O_RDWR open() ? Are they of any use ?
