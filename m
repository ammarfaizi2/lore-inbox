Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVHOIoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVHOIoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVHOIoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:44:15 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:63757 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbVHOIoO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:44:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Re+7VURMvpQDkmMXC5CNAVI0XPryxHn8VUDvgvmGFmRqLgtk9os81FXF3yaptw5c33Izx52slTCbV2aTY/8gcm+uoQAl8PJC6IvHfAJfYkyRFHZVmy+hE4CBxtsOuECCv5xei5XlbxawRaWLO1uuKbTOqC3VB7OgrsK4bZJmFNA=
Message-ID: <98df96d305081501441bc9b121@mail.gmail.com>
Date: Mon, 15 Aug 2005 17:44:13 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: linux-kernel@vger.kernel.org, Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <1124090190.3228.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
	 <98df96d305081403222e75b232@mail.gmail.com>
	 <1124015743.3222.17.camel@laptopd505.fenrus.org>
	 <98df96d30508142343407b4d61@mail.gmail.com>
	 <1124090190.3228.3.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I appreciate your suggestion.

On 8/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > Anyway we could not find the cache aware version of __copy_from_user_ll
> > has a big regression yet.
> 
> 
> that is because you spread the cache misses out from one place to all
> over the place, so that no one single point sticks out anymore.
> 
> Do you agree that your copy is less optimal for the case where the
> kernel will (almost) immediately use the data?

Yes, I do.

My server has 8KB of L1 cache. (512KB of L2/2MB of L3)

If you move more than 4KB of data using by __copy_from_user_ll(), the
data will be spilled over L1 cache but in L2 (or L3)
When you move huge data (> 1MB), even L3 cache will not help you.
(This is known as a cache pollution.)

> I agree that your copy is really nice for places where the kernel will
> NOT use the data in the cpu, say for big write() system calls.
> 
> My suggestion is to realize there are basically 2 different use cases,
> and that in the code the first one is very common, while in your
> profiles the second one is very common. Based on that I suggest to make
> a special copy_from_user_nocache() API for the cases where the kernel
> will not use the data (and ignore software raid5 here) and use your
> excellent version for that API, while leaving the code for the cases
> where the kernel WILL use the data alone. Code wise the "will use" case
> is the vast majority, so only changing the few places that know they
> don't use the data will be very efficient, and will give immediate big
> improvement in your profile data, since those few places tend to get
> used a lot in the cases you benchmark.

copy_from_user_nocache() is fine.

But I don't know where I can use it. (I'm not so
 familiar with the linux kernel file system yet.) 

Regards,
  Hiro
