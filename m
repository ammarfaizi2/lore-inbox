Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131434AbRAKQTL>; Thu, 11 Jan 2001 11:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRAKQTB>; Thu, 11 Jan 2001 11:19:01 -0500
Received: from colorfullife.com ([216.156.138.34]:1299 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131434AbRAKQSq>;
	Thu, 11 Jan 2001 11:18:46 -0500
Message-ID: <3A5DDD09.C8C70D36@colorfullife.com>
Date: Thu, 11 Jan 2001 17:19:21 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrea Arcangeli <andrea@suse.de>, Russell King <rmk@arm.linux.org.uk>,
        Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <20010110013755.D13955@suse.de> <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk> <20010110163158.F19503@athlon.random> <shszogy2jmr.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> 
> As for the issue of casting 'fh->data' as a 'struct knfsd' then that
> is a perfectly valid operation.
>
No it isn't.

fh->data is an array of characters, thus without any alignment
restrictions.
'struct knfsd' begins with a pointer, thus it must be 4 or 8 byte
aligned.

The portable 'struct nfs_fh' structure would be

#define NFS_HANDLESIZE	64
struct nfs_fh
{
	unsigned short len;
	void* data[NFS_HANDLESIZE/sizeof(void*)];
};

But now its too late for such a change - it breaks at least i386,
probably all platforms.

Does knfsd actually need all 64 bytes in the nfs_fh?
What about aligning the 'struct knfsd' manually?

-	struct knfsd* ptr = fh->data;
+	struct knfsd* ptr = (fh->data+15)&(~15);

That would be kernel only, no ABI problems.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
