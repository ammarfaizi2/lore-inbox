Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288481AbSADLoU>; Fri, 4 Jan 2002 06:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288603AbSADLoK>; Fri, 4 Jan 2002 06:44:10 -0500
Received: from mons.uio.no ([129.240.130.14]:35713 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S288481AbSADLoA>;
	Fri, 4 Jan 2002 06:44:00 -0500
To: Urban Widmark <urban@teststation.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs fsx'ed
In-Reply-To: <Pine.LNX.4.33.0201032257300.28529-100000@cola.teststation.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Jan 2002 12:43:50 +0100
In-Reply-To: <Pine.LNX.4.33.0201032257300.28529-100000@cola.teststation.com>
Message-ID: <shsu1u2l4sp.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Urban Widmark <urban@teststation.com> writes:

     > The current code synchronizes all threads on the same mount
     > since all threads use "server->packet" as a buffer for send and
     > receive. I have some code where I have tried to copy how I
     > believe nfs does things with a "struct request" for each
     > caller.

All NFS does is to wrap the pages to read/write with a struct
'nfs_page' that allows us to string them together in a list. When
somebody calls sync_page() or decides to flush out the pending writes,
we collate these 'nfs_page' things into appropriately sized private
lists (NFS has a server-provided upper limit on the number of bytes
you can send) and generate an RPC call.
In addition, there is code to limit the total number of pending
nfs_page structs (in order to avoid trouble due to flooding memory
with cached requests), and for managing request timeouts.

See the files include/linux/nfs_page.h, and fs/nfs/pagelist.c for details.



The struct nfs_page does contain one or 2 entries which are
NFS-specific (the RPC credential and commit cookie), but if you ignore
them, the rest of the machinery should be fairly easily adaptable for
reuse in the SMB code. One would perhaps have to rip out the
NFS_SERVER() stuff in pagelist.c (which is used to maintain a couple
of mount-global lists), and replace it with a slightly more generic
interface, but that's all trivial stuff.

Cheers,
   Trond
