Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVLCNBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVLCNBG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 08:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLCNBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 08:01:05 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:42720 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751253AbVLCNBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 08:01:04 -0500
Message-ID: <02cd01c5f809$95a94620$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: "Dave Kleikamp" <shaggy@austin.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp> <1133447539.8557.14.camel@kleikamp.austin.ibm.com> <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp> <20051202185805.GS14509@schatzie.adilger.int>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Date: Sat, 3 Dec 2005 22:00:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Dec 02, 2005  22:18 +0900, Takashi Sato wrote:
>> I also found another problem on generic quota code.  In
>> dquot_transfer(), the file usage is calculated from i_blocks via
>> inode_get_bytes().  If the file is over 2TB, the change of usage is
>> less than expected.
>> 
>> To solve this problem, I think inode.i_blocks should be 8 byte.
> 
> Actually, it should probably be "sector_t", because it isn't really
> possible to have a file with more blocks than the size of the block
> device.  This avoids memory overhead for small systems that have no
> need for it in a very highly-used struct.  It may be for some network
> filesystems that support gigantic non-sparse files they would need to
> enable CONFIG_LBD in order to get support for this.

I think sector_t is ok for local filesystem as you said.  However,
on NFS, there may be over 2TB file on server side, and inode.i_blocks
for over 2TB file will become invalid on client side in case CONFIG_LBD
is disabled.

So, I think inode.i_blocks should be a type of 8 byte
(ex. unsigned long long).  How does it look?

-- Takashi Sato
