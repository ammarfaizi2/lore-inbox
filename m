Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWFAR0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWFAR0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWFAR0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:26:33 -0400
Received: from pat.uio.no ([129.240.10.4]:55292 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965200AbWFAR0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:26:32 -0400
Subject: Re: Why must NFS access metadata in synchronous mode?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140606010927t308e7d6ag5a9fc112c859aa45@mail.gmail.com>
References: <4ae3c140605312104m441ca006j784a93354456faf8@mail.gmail.com>
	 <1149141341.13298.21.camel@lade.trondhjem.org>
	 <4ae3c140606010927t308e7d6ag5a9fc112c859aa45@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 13:26:18 -0400
Message-Id: <1149182779.3549.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.938, required 12,
	autolearn=disabled, AWL 1.06, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 12:27 -0400, Xin Zhao wrote:
> Question 1: ...and how many NFS implementations have you seen based on
> that paper?
> I don't know. I only read the NFS implementations distributed with
> Linux kernel. But some paper mentioned that the soft update mechanism
> suggested in that paper has been adopted by FreeBSD.

FreeBSD does not use soft updates for NFS afaik.

> Question 2: NFS permissions are checked by the _server_, not the client.
> That's true. But I was not saying that all metadata access must be
> asynchronous. Even for permission checking, speculative execution
> mechanism proposed in Ed Nightingale's "speculative execution ...."
> paper published in SOSP 2005 can be used to avoid waiting. The basic
> idea is that a NFS client speculatively assume permission checking
> returns "OK" and set a checkpoint, then the client can go ahead to
> send further requests. If the actual result turns out to be "OK", the
> client can discard the checkpoint, otherwise, it rolls back to the
> checking point. This can make waiting time overlap with the sending
> time of subsequent requests.

...and how does that help the user that has been told the operation
succeeded?

> Question 3: Cache consistency requirements are _much_ more stringent
> for asynchronous operation.
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

'man 5 exports'. Read _carefully_ the entry on the "async" export
option, and see the NFS FAQ, nfs mailing list archives, etc... why it is
a bad idea.


Cheers,
  Trond

