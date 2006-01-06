Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWAFCCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWAFCCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWAFCCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:02:06 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:40127 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932459AbWAFCCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:02:04 -0500
Date: Thu, 5 Jan 2006 21:05:59 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Russ Cox <rsc@swtch.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH 3/3] v9fs: zero copy implementation
Message-ID: <20060106020559.GA13804@ionkov.net>
References: <20060105005731.GC27375@ionkov.net> <ee9e417a0601050713k3c778142k430c5329bbd8e841@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9e417a0601050713k3c778142k430c5329bbd8e841@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:13:52AM -0500, Russ Cox said:
> > +char *v9fs_str_copy(char *buf, int buflen, struct v9fs_str *str)
> > +{
> > +       int n;
> > +
> > +       if (buflen < str->len)
> > +               n = buflen;
> > +       else
> > +               n = str->len;
> > +
> > +       memmove(buf, str->str, n - 1);
> > +
> > +       return buf;
> > +}
> 
> 
> The above is wrong.  You'll chop the end of the string off
> when str->len <= buflen.

You are right.

> 
> n = str->len;
> if (n > buflen-1)
>         n = buflen-1;
> memmove(buf, str->str, n);
> buf[n] = 0;
> 
> > +int v9fs_str_compare(char *buf, struct v9fs_str *str)
> > +{
> > +       int n, ret;
> > +
> > +       ret = strncmp(buf, str->str, str->len);
> > +
> > +       if (!ret) {
> > +               n = strlen(buf);
> > +               if (n < str->len)
> > +                       ret = -1;
> > +               else if (n > str->len)
> > +                       ret = 1;
> > +       }
> > +
> > +       return ret;
> > +}
> 
> You go through all this work to avoid copying the strings,
> which has questionable benefit, and then this routine
> walks the length of the string twice, unnecessarily.
> Also if strlen(buf) < str->len, then strncmp can't return 0.

I avoid copying the strings not because of the copy itself, but to not
bother freeing them when v9fs_fcall structure is freed. You are right, the
logic is wrong. I was trying (obviously unsuccessfully) to match strcmp
semantics, although I only use the function to check for equality of the
strings.

> 
> ret = strncmp(buf, str->str, str->len);
> if (!ret && buf[str->len])
>         ret = 1;
> return ret;
> 
> >  static inline int buf_check_size(struct cbuf *buf, int len)
> >  {
> [snip deleted lines]
> > +       if (buf->p + len > buf->ep && buf->p < buf->ep) {
> > +               eprintk(KERN_ERR, "buffer overflow: want %d has %d\n",
> > +                       len, (int)(buf->ep - buf->p));
> > +               dump_stack();
> > +               buf->p = buf->ep + 1;
> > +               return 0;
> >         }
> >
> >         return 1;
> 
> I think it's weird that you return 1 when you've already overflowed.
> It's fine that you don't print more than once, but what's the harm
> in returning 0 always when buf->p + len > buf->ep?

It is not just weird, it is wrong and can lead to writing outside of the
buffer.

Thanks for reviewing the code.

	Lucho
