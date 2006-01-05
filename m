Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWAEPNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWAEPNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWAEPNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:13:54 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:45611 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbWAEPNx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:13:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qcc+7bdUSpYUnBl0vYLchPtlyZbVJgGfPOBFwE8hn6sOsn8j6RnffK617e3ndm9g//aYHFbYuA4AyJzcI+sGVLQH80gzRloa89XevdSRAMDfdQKGRwcSqeeNFAH4Rf1DbstgA0EabkKFAVtQDYshtbrThObKPgAUqculDIrPmZo=
Message-ID: <ee9e417a0601050713k3c778142k430c5329bbd8e841@mail.gmail.com>
Date: Thu, 5 Jan 2006 10:13:52 -0500
From: Russ Cox <rsc@swtch.com>
To: Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [V9fs-developer] [PATCH 3/3] v9fs: zero copy implementation
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <20060105005731.GC27375@ionkov.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105005731.GC27375@ionkov.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +char *v9fs_str_copy(char *buf, int buflen, struct v9fs_str *str)
> +{
> +       int n;
> +
> +       if (buflen < str->len)
> +               n = buflen;
> +       else
> +               n = str->len;
> +
> +       memmove(buf, str->str, n - 1);
> +
> +       return buf;
> +}


The above is wrong.  You'll chop the end of the string off
when str->len <= buflen.

n = str->len;
if (n > buflen-1)
        n = buflen-1;
memmove(buf, str->str, n);
buf[n] = 0;

> +int v9fs_str_compare(char *buf, struct v9fs_str *str)
> +{
> +       int n, ret;
> +
> +       ret = strncmp(buf, str->str, str->len);
> +
> +       if (!ret) {
> +               n = strlen(buf);
> +               if (n < str->len)
> +                       ret = -1;
> +               else if (n > str->len)
> +                       ret = 1;
> +       }
> +
> +       return ret;
> +}

You go through all this work to avoid copying the strings,
which has questionable benefit, and then this routine
walks the length of the string twice, unnecessarily.
Also if strlen(buf) < str->len, then strncmp can't return 0.

ret = strncmp(buf, str->str, str->len);
if (!ret && buf[str->len])
        ret = 1;
return ret;

>  static inline int buf_check_size(struct cbuf *buf, int len)
>  {
[snip deleted lines]
> +       if (buf->p + len > buf->ep && buf->p < buf->ep) {
> +               eprintk(KERN_ERR, "buffer overflow: want %d has %d\n",
> +                       len, (int)(buf->ep - buf->p));
> +               dump_stack();
> +               buf->p = buf->ep + 1;
> +               return 0;
>         }
>
>         return 1;

I think it's weird that you return 1 when you've already overflowed.
It's fine that you don't print more than once, but what's the harm
in returning 0 always when buf->p + len > buf->ep?

Russ
