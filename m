Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRLQSbI>; Mon, 17 Dec 2001 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLQSa6>; Mon, 17 Dec 2001 13:30:58 -0500
Received: from ASYNC8-CS2.NET.CS.CMU.EDU ([128.2.188.152]:56330 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S281735AbRLQSas>; Mon, 17 Dec 2001 13:30:48 -0500
Date: Mon, 17 Dec 2001 13:18:29 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: dzafman@kahuna.cag.cpqcorp.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: NFS client llseek
Message-ID: <20011217181748.GA15970@cs.cmu.edu>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	dzafman@kahuna.cag.cpqcorp.net, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@math.psu.edu>
In-Reply-To: <200112140057.fBE0vDm05648@kahuna.cag.cpqcorp.net> <15385.62936.632242.570507@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15385.62936.632242.570507@charged.uio.no>
User-Agent: Mutt/1.3.24i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 01:51:36PM +0100, Trond Myklebust wrote:
> Just one comment: Isn't it easier to do this in generic_file_llseek()
> itself using inode->i_op->revalidate()? That would make it work for
> coda and smbfs too...

Actually, as far as Coda is concerned this only adds overhead. Coda uses
AFS2 session semantics instead of UNIX semantics, so updates are only
propagated when a file is closed.

Adding this to the generic_file_llseek will force an useless but
expensive upcall (and RPC call to the server) to every seek to check for
an updated i_size while we already know that the i_size of the file
won't have to change until it is closed and reopened.

I guess we're just (mis-)using the revalidate call as a replacement of a
missing call to i_ops->getattr from sys_stat. So perhaps adding the
revalidate to the generic_llseek is fine, but I'll just have to get that
missing getattr call into the tree.

Jan

