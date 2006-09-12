Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWILFdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWILFdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWILFdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:33:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:55223 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750820AbWILFdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:33:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N2tI+5Rb1bOBOAobuzNPHZAeIqVIZ0wddowNDNvUTQlSLrrsnoeV7FESAFgd4WFk3gT02oa0+V6trs6AB9+aNj+bt60Ez6vAig0qp38MYA/Yyxi+po7h37BYmkQz4gxbE26sjrwd4h0oK+3t+Zohb2MwaDf6Wby7ypzsqzi3JFM=
Message-ID: <787b0d920609112233u16a1cbcv2bf4ffa6b378dcd7@mail.gmail.com>
Date: Tue, 12 Sep 2006 01:33:21 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jgarzik@pobox.com, paulus@samba.org, torvalds@osdl.org, akpm@osdl.org,
       segher@kernel.crashing.org
Subject: Re: [RFC] MMIO accessors & barriers documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

>  1- io_to_io_barrier() : This barrier provides ordering requirement #1
> between two MMIO accesses. It's to be used in conjuction with fully
> relaxed accessors of Class 3.
>
>  2- memory_to_io_wb() : This barrier provides ordering requirement #2
> between a memory store and an MMIO store. It can be used in conjunction
> with write accessors of Class 2 and 3.
>
>  3- io_to_memory_rb(value) : This barrier provides ordering requirement
> #3 between an MMIO read and a subsequent read from memory. For
> implementation purposes on some architectures, the value actually read
> by the MMIO read shall be passed as an argument to this barrier. (This
> allows to generate the appropriate CPU instruction magic to force the
> CPU to consider the value as being "used" and thus force the read to be
> performed immediately). It can be used in conjunction with read
> accessors of Class 2 and 3
>
>  4- io_to_lock_wb() : This barrier provides ordering requirement #4
> between an MMIO store and a subsequent spin_unlock(). It can be used in
> conjunction with write accessors of Class 2 and 3.

These can really multiply: read or write, RAM and various types
of IO space, etc.

Let's have a generic arch-provided macro and let gcc do some work
for us.

Example usage:
fence(FENCE_READ_RAM|FENCE_READ_PCI_IO, FENCE_WRITE_PCI_MMIO);

Example implementation for PowerPC:

#define PPC_RAM (FENCE_READ_RAM|FENCE_WRITE_RAM)
#define PPC_MMIO (FENCE_READ_PCI_MMIO|FENCE_READ_PCI_CONFIG|\
 FENCE_READ_PCI_RAM|FENCE_READ_PCI_IO | FENCE_WRITE_PCI_MMIO|\
 FENCE_WRITE_PCI_CONFIG|FENCE_WRITE_PCI_RAM|FENCE_WRITE_PCI_IO)
#define PPC_OTHER (~(PPC_RAM|PPC_MMIO))

#define fence(before,after) do{ \
if(before&PPC_RAM && after&PPC_MMIO) \
        __asm__ __volatile__ ("sync" : : : "memory"); \
else if(before&PPC_MMIO && after&PPC_RAM) \
        __asm__ __volatile__ ("sync" : : : "memory"); \
else if((before|after) & PPC_OTHER) \
        __asm__ __volatile__ ("sync" : : : "memory"); \
else if(before && after) \
        __asm__ __volatile__ ("eieio" : : : "memory"); \
}while(0)
