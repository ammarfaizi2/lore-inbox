Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311918AbSCTIbD>; Wed, 20 Mar 2002 03:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311919AbSCTIao>; Wed, 20 Mar 2002 03:30:44 -0500
Received: from mons.uio.no ([129.240.130.14]:22998 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S311918AbSCTIal>;
	Wed, 20 Mar 2002 03:30:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: NIIBE Yutaka <gniibe@m17n.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Date: Wed, 20 Mar 2002 09:30:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no> <E16nKrq-0007uP-00@charged.uio.no> <200203200042.g2K0gnL19526@mule.m17n.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16nbUL-0004Ga-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20. March 2002 01:42, NIIBE Yutaka wrote:

> IMO, it's no use to check the correctness for the inode when ->i_count ==
> 0. We can reuse the memory of the client side inode, that's true,
> but we don't need to check old data against new one at that time.

I don't understand what you mean by this. As I see it, close-to-open 
consistency checking mandates that you do this. What if somebody changed the 
data on the server while you had the file closed?

Furthermore, inode->i_count == 0 offers no guarantees that the client doesn't 
for instance have dirty pages to write out.

Messing around with the value of i_mode in nfs_find_actor as you want to do 
in your patch is going to introduce new dimensions to this problem. For 
instance, magically changing a regular file into a symlink without first 
flushing out dirty pages and clearing the page cache is certainly going to 
produce som "interesting" results...
As I said yesterday: a test of the form

	if ((inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
		return 0;

in nfs_find_actor might make sense since that forces the creation of a new 
inode. However it doesn't help at all with the same race if inode->i_mode 
hasn't changed. There is simply no way you can test for whether or not the 
file is the same on the server.

Cheers,
  Trond
