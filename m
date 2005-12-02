Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVLBNST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVLBNST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 08:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVLBNST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 08:18:19 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:10670 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750732AbVLBNSS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 08:18:18 -0500
Message-ID: <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Dave Kleikamp" <shaggy@austin.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp> <1133447539.8557.14.camel@kleikamp.austin.ibm.com>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Date: Fri, 2 Dec 2005 22:18:04 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailsv.tnes.nec.co.jp id jB2DI8T79684
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Hi all,
> >
> > I found a problem at stat64 on 32bit architecture.
> >
> > When I called stat64 for a file which is larger than 2TB, stat64
> > returned an invalid number of blocks at st_blocks on 32bit
> > architecture, although it returned a valid number of blocks on 64bit
> > architecture(ia64).
>
> For jfs, it's a bigger problem than just stat64.  When writing the inode
> to disk, jfs calculates the number of blocks from the 32-bit value:
> dip->di_nblocks = cpu_to_le64(PBLK2LBLK(ip->i_sb, ip->i_blocks))
>
> So it won't only report the wrong number of blocks, but it will actually
> store the wrong number.  :-(

I also found another problem on generic quota code.  In
dquot_transfer(), the file usage is calculated from i_blocks via
inode_get_bytes().  If the file is over 2TB, the change of usage is
less than expected.

To solve this problem, I think inode.i_blocks should be 8 byte.

>> 2. Change the type of architecture dependent stat64.st_blocks in
>>    include/asm/asm-*/stat.h from unsigned long to unsigned long long.
>>    I tried modifying only stat64 of 32bit architecture
>>    (include/asm-i386/stat.h).
>
>This changes the API, but the structure does suggest that the 4-byte pad
>should be used for the high-order bytes of st_blocks, so that's not
>really a problem.  A correct fix would replace __pad4 with
>st_blocks_high (or something like that) and ensure that the high-order
>word was stored there.  Your proposed fix would only be correct on
>little-endian hardware, as Jörn pointed out.

Thank you for your advice.  I'll research for glibc and consider
how to implement.
By the way I think, as Avi Kivity said, it's always little-endian on i386,
is it correct?

-- Takashi Sato 

