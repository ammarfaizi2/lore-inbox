Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWAENCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWAENCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWAENCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:02:18 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:35009 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750916AbWAENCR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:02:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o73FXYmBKMmyAJbWNF7mT3Mohvx5xEY9w03nAoVm6cT7eeQA/uf8XI6LNX3faCjaoS4SdD37voLXT3VdyaRv6H1EfYbM2Ctq6vwi9Ord3hQ/xqLcKOm2Sf7ERBU8XkNWICT0eK3DPfLnX9dRnGJknAez1arO/KbNLLnLmXNAF/g=
Message-ID: <84144f020601050502x3da089e7n55655db85f716ae9@mail.gmail.com>
Date: Thu, 5 Jan 2006 15:02:16 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] v9fs: zero copy implementation
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

On 1/5/06, Latchesar Ionkov <lucho@ionkov.net> wrote:
>  v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
> -             u32 fid, u32 afid, struct v9fs_fcall **fcall)
> +             u32 fid, u32 afid, struct v9fs_fcall **rcp)
>  {

[snip]

>
> -       return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
> +       ret = -ENOMEM;

This assignment is redundant. You always override it below.

> +       tc = v9fs_create_tattach(fid, afid, uname, aname);
> +       if (!IS_ERR(tc)) {
> +               ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
> +               kfree(tc);
> +       } else
> +               ret = PTR_ERR(tc);

[seen in various other places as well]

> --- a/fs/9p/9p.h
> +++ b/fs/9p/9p.h
> +struct v9fs_str {
> +       u16 len;
> +       char *str;
> +};

[snip]

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
> +
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

Do you really need these? If yes, could you please put them in lib/?

                                      Pekka
