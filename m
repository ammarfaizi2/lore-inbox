Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWHRWtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWHRWtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWHRWtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:49:53 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:23186 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751565AbWHRWtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:49:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rRngFaQzK3SUi+hfO1AzaOkJ+KiZ/90e5z+uSWqvOx5aIYsH/f5BrUz6f6Q2EBKMMhun8fRgwg8/7LTfViPJKd49bOw5Z6KpZubXMtlXNJ6MLK+Zlt6lWGvWfik4fH7vL/aieynI2NsGvTyrrAOorrSZEePlvOAR4nl4zGuyUuQ=
Message-ID: <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
Date: Sat, 19 Aug 2006 00:49:50 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608181447t5503b24eyfea6f3903c2ba27d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608180528ocadc36ck8868ae1a33342bb9@mail.gmail.com>
	 <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
	 <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
	 <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
	 <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
	 <6bffcb0e0608181438m3406de08q9a168d486127aef@mail.gmail.com>
	 <b0943d9e0608181447t5503b24eyfea6f3903c2ba27d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 18/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > cat /sys/kernel/debug/memleak + LTP + patching repo = oops?
> >
> > BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
>
> I got this as well today on an 4-CPU ARM platform. I changed some list
> traversal to the RCU variants but forgot to change the list_del/add. I
> attach another patch which fixes this (haven't tested it extensively
> yet).

Thanks.

I just added your "Fix memory leak in vc_resize/vc_allocate" patch to
my series file.

orphan pointer 0xc6110000 (size 12288):
  c017480e: <__kmalloc>
  c024dda4: <vc_resize>
  c020ed9c: <fbcon_startup>
  c0251028: <register_con_driver>
  c02511e0: <take_over_console>
  c020e21e: <fbcon_takeover>
  c0212b08: <fbcon_fb_registered>
  c0212ce1: <fbcon_event_notify>
orphan pointer 0xf55b0000 (size 8208):
  c017480e: <__kmalloc>
  c0211bb8: <fbcon_set_font>
  c0251b17: <con_font_set>
  c0251c7b: <con_font_op>
  c0249a97: <vt_ioctl>
  c024432e: <tty_ioctl>
  c0189fd1: <do_ioctl>
  c018a269: <vfs_ioctl>

This is interesting. Is it too large?
orphan pointer 0xfe09f000 (size 4194304):
  c016cb9c: <__vmalloc_node>
  c016cbb2: <__vmalloc>
  c016cbc7: <vmalloc>
  fdd3bbe1: <txInit>
  fdd23b73: <init_jfs_fs>
  c0149fea: <sys_init_module>

A simple way to reproduce:

while true
do
sudo mount -o loop -t jfs /home/fs-farm/jfs.img /mnt/fs-farm/jfs/
sudo umount /mnt/fs-farm/jfs/
done

A large collection of false positives :)
http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.9/ml_collection/ml1.tar

>
> Thanks.
>
> --
> Catalin
>
>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
