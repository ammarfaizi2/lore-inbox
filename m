Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269443AbUICJOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269443AbUICJOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269522AbUICJOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:14:01 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:63138 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269476AbUICJGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:06:41 -0400
Date: Fri, 3 Sep 2004 11:06:17 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: Andrew Morton <akpm@osdl.org>
cc: Simon Derr <Simon.Derr@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible race in sysfs_read_file() and sysfs_write_file()
In-Reply-To: <20040902155758.1eba30a5.akpm@osdl.org>
Message-ID: <Pine.A41.4.53.0409031056280.122970@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
 <20040901163436.263802bc.akpm@osdl.org> <Pine.A41.4.53.0409020917350.122970@isabelle.frec.bull.fr>
 <20040902155758.1eba30a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Andrew Morton wrote:

> Simon Derr <Simon.Derr@bull.net> wrote:
> >
> > @@ -140,13 +145,17 @@
> >   	struct sysfs_buffer * buffer = file->private_data;
> >   	ssize_t retval = 0;
> >
> >  -	if (!*ppos) {
> >  +	down(&buffer->sem);
> >  +	if ((!*ppos) || (!buffer->page)) {
> >   		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
> >  -			return retval;
> >  +			goto out;
>
> Why are we testing *ppos at all in here?

To keep the original behaviour, that is, after lseek() to offset zero,
ops->show() is called again and the contents of the file are refreshed.

Some applications maybe rely on it, or it may be completely useless, I
don't known.

And if we open a sysfs file with O_RDWR, and write() into it, then this is
needed if we want to read(), because else the buffer will have been
allocated, but ops->show() not called. I'm not too sure about this being
useful either.


PS: just in case my previous patch is of any interest, note that I made an
interesting typo in the 'Signed-off-by' email field.
