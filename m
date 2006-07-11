Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWGKQDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWGKQDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWGKQDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:03:01 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:34663 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751110AbWGKQDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:03:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YdFkHGdeVkgpTGIkcLZoD/5mq7rTowsAj9Z+ENQQUS7+J9MfmnDa9m0OG7nITf/xHHYHUWS8B2nxCmhdqOpwD9Ms6Bvmhi6RCmS/MvOlJou6MDmSxlVxTYzq0FdXcL5SMp5WKjkvewNrvK8vlO3UjxHc5vM1vafB+bCu81rrQKk=
Message-ID: <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
Date: Tue, 11 Jul 2006 18:02:59 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > orphan pointer 0xc6113bec (size 28):
> >   c017392a: <__kmalloc_track_caller>
> >   c01631b1: <__kzalloc>
> >   c010b7d7: <legacy_init_iomem_resources>
> >   c010b89c: <request_standard_resources>
> >   c0100b8b: <do_initcalls>
> >   c0100c3d: <do_basic_setup>
> >   c0100cdb: <init>
>
> That's a real leak. I posted a patch last night that solves this issue
> - http://lkml.org/lkml/2006/7/10/370

Thanks.

>
> > This is most common
> > orphan pointer 0xf5a6fd60 (size 39):
> >   c0173822: <__kmalloc>
> >   c01df500: <context_struct_to_string>
> >   c01df679: <security_sid_to_context>
> >   c01d7eee: <selinux_socket_getpeersec_dgram>
> >   f884f019: <unix_get_peersec_dgram>
> >   f8850698: <unix_dgram_sendmsg>
> >   c02a88c2: <sock_sendmsg>
> >   c02a9c7a: <sys_sendto>
>
> Looking at the call trace, the pointer to the memory allocated in
> context_struct_to_string() is stored in the "cb" variable in struct
> sk_buff (argument passed to selinux_socket_getpeersec_dgram from
> unix_get_peersec_dgram).
>
> This pointer should be found when scanning the "struct sk_buff"
> blocks, unless you also get a comparable number of "struct sk_buff"
> reports (from __alloc_skb). If not, it might be a real leak.

So if we got 3970
orphan pointer 0xf5a6fd60 (size 39):
  c0173822: <__kmalloc>
  c01df500: <context_struct_to_string>
  c01df679: <security_sid_to_context>
  c01d7eee: <selinux_socket_getpeersec_dgram>
  f884f019: <unix_get_peersec_dgram>
  f8850698: <unix_dgram_sendmsg>
  c02a88c2: <sock_sendmsg>
  c02a9c7a: <sys_sendto>

and 4673
orphan pointer 0xf4249488 (size 29):
  c0173822: <__kmalloc>
  c01df500: <context_struct_to_string>
  c01df679: <security_sid_to_context>
  c01d7eee: <selinux_socket_getpeersec_dgram>
  f884f019: <unix_get_peersec_dgram>
  f8850698: <unix_dgram_sendmsg>
  c02a8d68: <do_sock_write>
  c02a8e85: <sock_aio_write>

It's not a memleak?

http://www.stardust.webpages.pl/files/o_bugs/kml/ml3.txt

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
