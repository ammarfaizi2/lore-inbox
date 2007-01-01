Return-Path: <linux-kernel-owner+w=401wt.eu-S932912AbXAAGhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbXAAGhY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 01:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbXAAGhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 01:37:24 -0500
Received: from web55601.mail.re4.yahoo.com ([206.190.58.225]:42985 "HELO
	web55601.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932912AbXAAGhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 01:37:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=JiQ4XdCYKvm3HJOaCOnwWmfS4EfHI36mZNmCRXLEeDAw1pvGrWvQ8dB/ZXDTUbOrmsmJ4sh4TP9v9Nco73Dcpm+ccSgZGPEYi/3NDvuw2jWb3NWKTEl1c1z5tpWhNRku+GjicOHMl15oW/gfN6NFwo9kPj/XzjsYCrG3//Q0NHY=;
X-YMail-OSG: A2c4AZsVM1nEyOYnZEMuhsLTbsADZAWK_RYvUKh90tEwLtc0hO8jtSpzv9LMfh9Mo9KIdQk4mUkofYDOPQjxDEyzyKgg35IlPt7G6mGjETMxCDrOSJAH73pk8HXt8.A_4Q1rdjz3Vgg9Mvg-
Date: Sun, 31 Dec 2006 22:37:22 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
To: Ingo Oeser <ioe-lkml@rameria.de>, Bernd Petrovitsch <bernd@firmix.at>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Amit Choudhary <amit2030@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200701010143.02870.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <88880.94256.qm@web55601.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Ingo Oeser <ioe-lkml@rameria.de> wrote:

> On Sunday, 31. December 2006 14:38, Bernd Petrovitsch wrote:
> > That depends on the decision/definition if (so called) "double free" is
> > an error or not (and "free(NULL)" must work in POSIX-compliant
> > environments).
> 
> A double free of non-NULL is certainly an error.
> So the idea of setting it to NULL is ok, since then you can
> kfree the variable over and over again without any harm.
> 
> It is just complicated to do this side effect free.
> 
> Maybe one should check for builtin-constant and take the address,
> if this is not an builtin-constant.
> 
> sth, like this
> 
> #define kfree_nullify(x) do { \
> 	if (__builtin_constant_p(x)) { \
> 		kfree(x); \
> 	} else { \
> 		typeof(x) *__addr_x = &x; \
> 		kfree(*__addr_x); \
> 		*__addr_x = NULL; \
> 	} \
> } while (0)
> 
> Regards
> 
> Ingo Oeser
> 

This is a nice approach but what if someone does kfree_nullify(x+20).

I decided to keep it simple. If someone is calling kfree_nullify() with anything other than a
simple variable, then they should call kfree().  But definitely an approach that takes care of all
situations is the best but I cannot think of a macro that can handle all situations. The simple
macro that I sent earlier will catch all the other usage at compile time. Please let me know if I
have missed something.

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
