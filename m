Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUDHLLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 07:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUDHLLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 07:11:03 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:56206 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261668AbUDHLLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 07:11:00 -0400
Message-ID: <4075333B.4C90934C@nospam.org>
Date: Thu, 08 Apr 2004 13:10:51 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
References: <20040407074239.GG18264@zax> <4073C33B.7B7808E7@nospam.org> <20040408015327.GB20320@zax>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:

> > Why not just add a flag for a VMA telling if you want / do not want to
> > copy it on "fork()" ? E.g.:
> >
> > dup_mmap():
> >
> >       for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
> >
> >               if (mpnt->vm_flags & VM_HUGETLB_DONT_COPY)
> >                       <do nothing>
> >       }
> >
> 
> Um.. why would that be useful?

I think there are 2 major cases:

- A big hugepage-using program creates threads to take advantage
  of all of the CPUs => use clone2(...CLONEVM...), it works today.
- Another big hugepage-using program calling a little shell function
  with system() => just skip the VMA of the huge page area in
	do_fork():
		copy_process():
			copy_mm():
				dup_mmap()
  The child will have no copy of the huge page area. No problem, it will
  exec() soon, and the stack, the usual data, the malloc()'ed data, etc.
  are not in the huge page area => exec() will will work correctly.

I do not think we need a COW of the huge pages.

Regards,

Zoltán Menyhárt
