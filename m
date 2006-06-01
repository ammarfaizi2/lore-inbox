Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWFAVkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWFAVkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWFAVkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:40:14 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:35203 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750821AbWFAVkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:40:11 -0400
Date: Thu, 1 Jun 2006 15:40:14 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Why must NFS access metadata in synchronous mode?
Message-ID: <20060601214014.GI5964@schatzie.adilger.int>
Mail-Followup-To: Xin Zhao <uszhaoxin@gmail.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <4ae3c140605312104m441ca006j784a93354456faf8@mail.gmail.com> <1149141341.13298.21.camel@lade.trondhjem.org> <4ae3c140606010927t308e7d6ag5a9fc112c859aa45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140606010927t308e7d6ag5a9fc112c859aa45@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01, 2006  12:27 -0400, Xin Zhao wrote:
> > Question 3: Cache consistency requirements are _much_ more stringent
> > for asynchronous operation.
> I agree. But I am not sure how local file system like Ext3 handle this
> problem. I don't think Ext3 must synchronously write metadata (I will
> double check the ext3 code). If I remember correctly, when change
> metadata, Ext3 just change it in memory and mark this page to be
> dirty. The page will be flushed to disk afterward. If the server
> exports an Ext3 code, it should be able to do the same thing. When a
> client requests to change metadata, server writes to the mmaped
> metadata page and then return to client instead of having to sync the
> change to disk. With this mechanism, at least the client does not have
> to wait for the disk flush time. Does it make sense? To prevent
> interleave change on metadata before it is flushed to disk, the server
> can even mark the metadata page to be read-only before it is flushed
> to disk.

The difference between local filesystems and remote filesystems is that
if asynchronous operations on a local filesystem are lost due to node
failure, the application is also generally failed at the same time,
so when the node restarts the application it gets the old state from disk.
If applications care about on-disk consistency (say because the application
is itself sharing state with a remote system, like sendmail) then it will
fsync the file(s) before updating the remote state.

In the NFS case, a remote client keeps the "new" state, which is inconsistent
with what the server has on disk (if server is running asynchronously) so
there is no way to reconcile this.  In the case of Lustre the clients are
stateful and keep a record of all operations they do (until the server later
confirms that it is safe on disk).  In case of server failure the clients
replay uncommitted operations to the server after a failure.  This allows
the server filesystem to run asynchronously.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

