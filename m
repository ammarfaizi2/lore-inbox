Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWBPC4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWBPC4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 21:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWBPC4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 21:56:21 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:7876 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751370AbWBPC4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 21:56:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ukxDML9l1oNyNQSgRXrcIL/FiWNXYiWEsSTr6pIzCxGiKsui7ZKEVMdjOFLIWz0Ia2kFv67Rs0iO39xKD5n1RM343kPuooMYoYsU28LJPNLk3cXzbaDyIClcIzQMSLepJFW/RikM+lSKXl2KvBDlbJuxJoJAWL5+NErJ9vyV07g=
Date: Thu, 16 Feb 2006 00:56:09 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] strndup_user, v2
Message-Id: <20060216005609.fbc35236.davi.arnaut@gmail.com>
In-Reply-To: <1140053156.14831.43.camel@localhost.localdomain>
References: <20060215182258.03505613.davi.arnaut@gmail.com>
	<1140053156.14831.43.camel@localhost.localdomain>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006 01:25:56 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2006-02-15 at 18:22 -0300, Davi Arnaut wrote:
> > +static inline char *strdup_user(const char __user *s)
> > +{
> > +	return strndup_user(s, 4096);
> > +}
> 
> Still shouldn't exist. Its just a bad idea to give people broken
> function they don't yet use.

Ok, I will remove it. But it's a sane default, if someone wants more
than 4096, they should use strndup_user.
 
> > +	length = strlen_user(s);
> 
> Should use strnlen_user or this function is useless for most cases.

Ok.

> > +
> > +	if (!length)
> > +		return ERR_PTR(-EFAULT);
> 
> Zero isn't an -EFAULT length. Its a null string and valid

strlen_user returns _0_ on exception. If you don't belive me,
kernel/module.c or arch/x86_64/lib/usercopy.c are a good starting
point.

> > +
> > +	if (length > n)
> > +		length = n;
> > +
> > +	p = kmalloc(length, GFP_KERNEL);
> > +
> > +	if (!p)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (strncpy_from_user(p, s, length) < 0) {
> > +		kfree(p);
> > +		return ERR_PTR(-EFAULT);
> > +	}
> > +
> > +	p[length - 1] = '\0';
> 
> And still broken.
> 
> "Hello" -> length = 5   "Hello\0"[4] = 0 "Hell"
> 

NO! strlen_user("Hello") -> length = 6

strlen_user returns the size of the string INCLUDING the
terminating NUL.

Are we talking in the same language ? 

--
Davi Arnaut
