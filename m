Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUK0RI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUK0RI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUK0RIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:08:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26320 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261269AbUK0RIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:08:31 -0500
Date: Sat, 27 Nov 2004 12:07:48 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Miklos Szeredi <miklos@szeredi.hu>
cc: akpm@osdl.org, torvalds@osdl.org, hbryan@us.ibm.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CV6vf-0006q1-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.61.0411271200580.12575@chimarrao.boston.redhat.com>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
 <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu> <20041118130601.6ee8bd97.akpm@osdl.org>
 <E1CV6vf-0006q1-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Miklos Szeredi wrote:

> The solution I'm thinking is along the lines of accounting the number
> of writable pages assigned to FUSE filesystems.  Limiting this should
> solve the deadlock problem.  This would only impact performance for
> shared writable mappings, which are rare anyway.

Note that NFS, and any filesystems on iSCSI or g/e/ndb block
devices have the exact same problem.  To explain why this is
the case, lets start with the VM allocation and pageout
thresholds:

   pages_min ------------------

  GFP_ATOMIC ------------------

PF_MEMALLOC ------------------

 	  0 ------------------

When writing out a dirty page, the pageout code is allowed
to allocate network buffers down to the PF_MEMALLOC boundary.

However, when receiving the ACK network packets from the server,
the network stack is only allowed to allocate memory down to the
GFP_ATOMIC watermark.

This means it is relatively easy to get the system to deadlock,
under a heavy shared mmap workload.  Limiting the number of
simultaneous writeouts might make the problem harder to trigger,
but is still no solution since the network layer could exhaust
its allowed memory for other packets, and never get around to
processing the ACKs for the pageout related network traffic!

I have a solution in mind, but it's not pretty. It might be safe
now that DaveM no longer travels.  Still have to come up with a
way to avoid being maimed by the other network developers, though...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
