Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWFXSpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWFXSpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWFXSpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:45:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:13249 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751029AbWFXSpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:45:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rBb5q1WFQyQzsbMjNCsSdfzL/TXoWDqwp0b5jyHc+YFaRbEM7pbiRPbgIVHQPusR3F1zUf/4GsJ8T7LiISHPTivjTSb1LCYGVLqA7nhaQ9RgNXhYOmMxZB0sxtxanrMOMojucliKjepW8IWPPSifWJtYaeEl5n6Wio0dfw0Yet8=
Message-ID: <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
Date: Sat, 24 Jun 2006 11:45:40 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: make PROT_WRITE imply PROT_READ
Cc: "Jason Baron" <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151072280.3204.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
> you ask for it, and the kernel is supposed to deliver the best behavior
> it can.

The kernel should provide

- a stable, reliable interface

- a consistent interface at least accross architectures, maybe even platforms


Providing write-only support for memory falls into none of these
categories.  When Jason and I discussed this my position actually was
to disallow PROT_WRITE without PROT_READ completely, making it an
error of mmap and mprotect.  That's perfectly legal according to POSIX
and it will teach those who write broken code like this.

Jason's proposal to implicitly set PROT_READ is the second best
solution.  It gets rid of the error cases which a developer might not
notice, either because of lucky circumstances or details of the
architecture.

The reality is that almost no platform can really implement write-only
memory.  RISC architectures implement sub-word write as word reads,
modify, word write.  And even for CISC archs the compiler, for
instance, might decide to read memory, be it for prefetching or
explicit write-combining.

I'm strongly in favor of adding of adding one of the two possible
patches (forbidding, implicitly setting PROT_READ).  This will help
preventing these kinds of programming mistakes from spreading and we
already _know_ that there are such programs out there.
