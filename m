Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWJAMWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWJAMWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWJAMWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:22:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:55335 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932104AbWJAMWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:22:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UWMa35z7HpnkYg+3Fqyfs+7cUqP/Qm95H6gbZ+YO75gVlAIyxa9rIl4YN/6lCUlkFwKJpC0dzCi3ooxjVNk6koUxHBVvEUqMdI7F6nkMDkJr0+qqZ0weEtCkOKCxQeSV/d8vD22yXw8U2IsGLQuJtT73BIyUl4/c8ortn5sts8I=
Message-ID: <a2ebde260610010522y916e77dvdad452c1042205fe@mail.gmail.com>
Date: Sun, 1 Oct 2006 20:22:22 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Cc: "Christoph Lameter" <clameter@sgi.com>, "Andi Kleen" <ak@suse.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <451F3A73.80800@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
	 <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com>
	 <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>
	 <451E8143.5030300@yahoo.com.au>
	 <a2ebde260609300909l5f33c152xa331f7600be67f6b@mail.gmail.com>
	 <Pine.LNX.4.64.0609301015060.3519@schroedinger.engr.sgi.com>
	 <451F3A73.80800@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/1, Nick Piggin <nickpiggin@yahoo.com.au>:
> It is in an unlikely path though. How many apps actually pass in a
> non NULL value for the timezone? Those that don't won't be affected.
> Even for those that do, it doesn't introduce any atomic ops or
> unpredictable branches, or cacheline pressure (because xtime lock is
> already touched by do_gettimeofday). IOW: I'm sure it would be
> unmeasurable.

I agree the above. Normally the unlikely path is not invoked after boot.

>
> OTOH, to be completely correct, it seems like the same xtime_lock
> read section should cover both the calculation of ktv, and that of
> ktz. So if it is going to be fixed at all, it should be done
> properly and looks like it needs to be a bit more intrusive (but
> no more expensive).
>

That means either 1. Move the seq lock from within do_gettimeofday()
to out of do_gettimeofday(), or 2. pass ktz into do_gettimeofday() and
compute it in the preexisting read section in do_gettimeofday().

The first changes the semantic of do_gettimeofday() so it would be
unacceptable since the function is invoked from many places. The
second changes the signature of the function so every caller need to
be changed to passing an extra NULL pointer in order to satisfy the
changed invocation agreement.

I think the race condition is not unacceptable so long as comments is
changed to state the situation clearly. To move everything into the
same read (and write) section (respectively) is a bit bigger work but
it does not introduce performance penalty at run time. Or perhaps we
could tolerate some middle point, that is, as the initial patch, still
protect ktz and ktv in separated section and let the comments state
the not-so-perfect situation clearly.
