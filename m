Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCHTuI>; Thu, 8 Mar 2001 14:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbRCHTts>; Thu, 8 Mar 2001 14:49:48 -0500
Received: from pat.uio.no ([129.240.130.16]:13520 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129072AbRCHTti>;
	Thu, 8 Mar 2001 14:49:38 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andreas.helke@lionbioscience.com (Andreas Helke),
        linux-kernel@vger.kernel.org, nfs@sourceforge.net,
        sg_info@lionbioscience.com, kirschh@lionbioscienc.com
Subject: Re: :Redhat [Bug 30944] - Kernel 2.4.0 and Kernel 2.2.18: with some programs
In-Reply-To: <E14ahiC-0001JG-00@the-village.bc.nu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 08 Mar 2001 20:49:00 +0100
In-Reply-To: Alan Cox's message of "Wed, 7 Mar 2001 17:26:54 +0000 (GMT)"
Message-ID: <shsy9ug3utv.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > Irix at least used to have an export option to do mappings to
     > keep clients that had 32/64bit inode problems happy. Do those
     > help ?

No. The problem here is a Linux one: NFS uses 32/64-bit unsigned
cookies, whereas glibc expects 64-bit *signed* offsets. Even with the
'32bitclients' export option, IRIX spits out cookies such as
'0xfeebdaed'. These confuse glibc because the VFS exports most of them
as 32-bit offsets that are sign-extended to 64-bits (the one exception
to this rule being the last dirent in the series which gets filled
directly with the 64-bit file->f_pos).

My last patch for this simply ensures that the NFS layer does a
pseudo-'64-bit sign extension' on such cookies:

   cookie --> (0xffffffff00000000 ^ cookie)

This mimics what happens in filldir64() for all cookies, and is of
course reversible due to the use of xor.

I've been testing it out at Connectathon, and it does indeed seem to
work as expected...

Cheers,
  Trond
