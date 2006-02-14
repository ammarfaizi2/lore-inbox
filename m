Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWBNGQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWBNGQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWBNGQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:16:25 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:694 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1030485AbWBNGQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:16:24 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Date: Tue, 14 Feb 2006 06:16:11 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jan Kara <jack@suse.cz>, Nohez <nohez@cmie.com>
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <200602110540.57573.ctpm@rnl.ist.utl.pt> <20060213222606.GC20175@ca-server1.us.oracle.com>
In-Reply-To: <20060213222606.GC20175@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140616.11856.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 13 February 2006 22:26, Mark Fasheh wrote:
> I was easily able to reproduce your problem on my cluster and was able to
> git-bisect my way to some JBD changes which seem to be causing the issue.
> Reverting those patches fixes things. Can you apply the attached patch and
> confirm that it also fixes this particular problem for you? You'll have to
> apply to all kernels in your cluster and either run fsck.ocfs2 or create a
> new file system before testing again.
>

 Hi Mark,

 This patch does indeed seem to fix this particular problem. Now creating and 
deleting files/directories gives expected results across nodes.

 The bad news is that it didn't last long. While doing some more tests I found 
another problem, but judging from kernel messages I think this one is related 
to the DLM code.

 The test was simple: 

 On node 1 untar a kernel tree and wait for tar to finish.

 After tar finished I ran tar on nodes 0 and 2, each one *concurrently* 
creating a separate archive from *the same* kernel tree untarred on node 1.

 Again, since the files are big, I've put them online:

Node0:
http://coyote.ist.utl.pt/ocfs2/Feb14/kern-iscsi-teste.log

Node1:
http://coyote.ist.utl.pt/ocfs2/Feb14/kern-orateste1.log
 (this node's clock was 10 minutes off, sorry about that)

Node2:
http://coyote.ist.utl.pt/ocfs2/Feb14/kern-orateste2.log


 On node 0, tar exited with:
tar: 
build-AMD-linux-2.6.16-rc2-git3-jbdfix1/drivers/media/video/cx25840/cx25840-core.c: 
Cannot stat: Invalid argument

On node 2, tar exited with a segmentation fault.

Anyway, after that I am still able to read and write files on all three nodes 
with consistency.


Any ideas?

Thanks
Best regards

Claudio
 

