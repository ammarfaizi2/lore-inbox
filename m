Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVHVV5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVHVV5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVHVV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:57:21 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:4793 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751297AbVHVV5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:57:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fIqdaFEHfsbA4CsIWO6pesWLZ/YbkONcYZKXTwWMYGziKZW4Jo9rhcb85HU/k3TZODh3Irk69u8SOP9fTPo07PVyGYaZqSJ8xnQQzs3nx192DE569BRqIrO7weOtJP0MIvIDFZ+Qe/XkPIMpkbiQrkXhkjqm51nCqG9DKONjLVw=
Message-ID: <9a87484905082214573a50c58b@mail.gmail.com>
Date: Mon, 22 Aug 2005 23:57:19 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Peter Staubach <staubach@redhat.com>
Subject: Re: [PATCH] Suppress deprecated f_maxcount in 'struct file'
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4309CE32.50408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	 <1124467911.9329.11.camel@kleikamp.austin.ibm.com>
	 <20050819122122.0852de3a.akpm@osdl.org> <43064ED1.40805@cosmosbay.com>
	 <20050819143344.4a6c49b2.akpm@osdl.org>
	 <430656AA.6030805@cosmosbay.com> <4309CE32.50408@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Peter Staubach <staubach@redhat.com> wrote:
> Eric Dumazet wrote:
> 
> > Andrew Morton a écrit :
> >
> >> Eric Dumazet <dada1@cosmosbay.com> wrote:
> >>
> >>> Considering :
> >>>
> >>> [root@dada1 linux-2.6.13-rc6]# find .|xargs grep f_maxcount
> >>> ./fs/file_table.c:      f->f_maxcount = INT_MAX;
> >>> ./fs/read_write.c:      if (unlikely(count > file->f_maxcount))
> >>> ./include/linux/fs.h:   size_t                  f_maxcount;
> >>>
> >>>
> >>> I was wondering if f_maxcount has a real use these days...
> >>
> >>
> >>
> >> No, I guess we can just stick a hard-wired INT_MAX in there.
> >>
> >>
> >
> > OK here is a patch doing the hard wiring then :)
> >
> > * struct file cleanup : f_maxcount has an unique value (INT_MAX). Just
> > use the hard-wired value.
> >
> > Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> >
> >------------------------------------------------------------------------
> >diff -Nru linux-2.6.13-rc6/fs/read_write.c linux-2.6.13-rc6-ed/fs/read_write.c
> >--- linux-2.6.13-rc6/fs/read_write.c   2005-08-07 20:18:56.000000000 +0200
> >+++ linux-2.6.13-rc6-ed/fs/read_write.c        2005-08-19 23:51:20.000000000 +0200
> >@@ -188,7 +188,7 @@
> >       struct inode *inode;
> >       loff_t pos;
> >
> >-      if (unlikely(count > file->f_maxcount))
> >+      if (unlikely(count > INT_MAX))
> >               goto Einval;
> >       pos = *ppos;
> >       if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
> >
> 
> And depending upon how you feel about read(2) and write(2) returning larger
> than can be represented by a ssize_t, you can get rid of this test too and
> apply the attached patch to prevent failures occuring in the direct-io
> subsystem.
> 
> Limiting i/o requests to INT_MAX is starting to seem a little small.
> 
>     Thanx...
> 
>        ps
> 
> Signed-off-by: Peter Staubach <staubach@redhat.com>
> 
[snip]
> +       if (niov)
> +               kfree(niov);

Just make this simply
     kfree(niov);
kfree() makes the check for NULL itself internally, no need to do it twice.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
