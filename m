Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933793AbWK0V4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793AbWK0V4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbWK0V4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:56:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:51310 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933793AbWK0V4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:56:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fLrGAS2aCfeqSW0ZNZQfM1e+xBvhPpVXju/hI6ccYGMazD3xRMBMwNUKdMEaSvxJge10OksY6TiDp4RZimGeso3k13Le0YZPC16zcth5zhAVjNdDvp0UWhI6/Zjl1wrb8XGqvRC1Wh/I4rDD8lWkBfyWcqtQhf9ngB8mhxuOKhA=
Message-ID: <9a8748490611271356m3fe0fe39of8c38b176d7da708@mail.gmail.com>
Date: Mon, 27 Nov 2006 22:56:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] potential NULL pointer deref in net/key/af_key.c
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, gem@asplinux.ru,
       davem@redhat.com, kuznet@ms2.inr.ac.ru, kunihiro@ipinfusion.com,
       miyazawa@linux-ipv6.org, derek@ihtfp.com
In-Reply-To: <20061127.135333.28790424.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611272244.08189.jesper.juhl@gmail.com>
	 <20061127.135333.28790424.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/06, David Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Mon, 27 Nov 2006 22:44:07 +0100
>
> > In net/key/af_key.c::pfkey_send_policy_notify() there's a check at the
> > beginning of the function :
> >
> >     if (xp && xp->type != XFRM_POLICY_TYPE_MAIN)
> >
> > this implies that 'xp' may be null when the function is called. But later
> > on in the function we have this code :
> >
> >     return key_notify_policy(xp, dir, c);
> >
> > key_notify_policy() passes 'xp' to pfkey_xfrm_policy2msg_prep() that pass
> > it on to pfkey_xfrm_policy2msg_size() which dereferences it.
> > key_notify_policy() also passes 'xp' to pfkey_xfrm_policy2msg() which
> > also dereferences it.
> >
> > So, in pfkey_send_policy_notify() in the cases where we end up calling
> > key_notify_policy(), we should test 'xp' for NULL.
> >
> > (note: patch is compile tested only)
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>
> We really need to teach your automated tool about context.
>
> The NULL case can only occur for XFRM_MSG_FLUSHPOLICY.
>
> Look at the km_policy_notify() call sites.  You can even see from the
> net/xfrm/xfrm_user.c:xfrm_send_policy_notify() implementation of this
> callback that for XFRM_MSG_FLUSHPOLICY the "xp" argument is ignored.
>
Arrgh, you are right. I really need to check call sites more carefully :(

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
