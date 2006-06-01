Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWFAQ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWFAQ1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWFAQ1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:27:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:15623 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030227AbWFAQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:27:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8jtlCbiHLrdSaEYLDWU6rdcdYgor66ijs05TA3DpSLyyMEAad6RQGFSKDFa3EQ/zocp+YgvhvZQLE5FcVKL2bI1NrL6j3XMejwKNmKgazaenF1Abg82jJN67M6Y2CgSIInPxSUcW0iWFbCGMwJ3QVaLiAbkFRqin6k9AZBIqqg=
Message-ID: <4ae3c140606010927t308e7d6ag5a9fc112c859aa45@mail.gmail.com>
Date: Thu, 1 Jun 2006 12:27:06 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: Why must NFS access metadata in synchronous mode?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <1149141341.13298.21.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140605312104m441ca006j784a93354456faf8@mail.gmail.com>
	 <1149141341.13298.21.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question 1: ...and how many NFS implementations have you seen based on
that paper?
I don't know. I only read the NFS implementations distributed with
Linux kernel. But some paper mentioned that the soft update mechanism
suggested in that paper has been adopted by FreeBSD.

Question 2: NFS permissions are checked by the _server_, not the client.
That's true. But I was not saying that all metadata access must be
asynchronous. Even for permission checking, speculative execution
mechanism proposed in Ed Nightingale's "speculative execution ...."
paper published in SOSP 2005 can be used to avoid waiting. The basic
idea is that a NFS client speculatively assume permission checking
returns "OK" and set a checkpoint, then the client can go ahead to
send further requests. If the actual result turns out to be "OK", the
client can discard the checkpoint, otherwise, it rolls back to the
checking point. This can make waiting time overlap with the sending
time of subsequent requests.

Question 3: Cache consistency requirements are _much_ more stringent
for asynchronous operation.
I agree. But I am not sure how local file system like Ext3 handle this
problem. I don't think Ext3 must synchronously write metadata (I will
double check the ext3 code). If I remember correctly, when change
metadata, Ext3 just change it in memory and mark this page to be
dirty. The page will be flushed to disk afterward. If the server
exports an Ext3 code, it should be able to do the same thing. When a
client requests to change metadata, server writes to the mmaped
metadata page and then return to client instead of having to sync the
change to disk. With this mechanism, at least the client does not have
to wait for the disk flush time. Does it make sense? To prevent
interleave change on metadata before it is flushed to disk, the server
can even mark the metadata page to be read-only before it is flushed
to disk.

Xin
On 6/1/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Thu, 2006-06-01 at 00:04 -0400, Xin Zhao wrote:
> > Until kernel 2.6.16, I think NFS still access metadata synchronously,
> > which may impact performance significantly. Several years ago, paper
> > "metadata update performance in file systems" already suggested using
> > asynchronous mode in metadata access.
>
> ...and how many NFS implementations have you seen based on that paper?
>
> > I am curious why NFS does not adopt this suggestion? Can someone explain this?
>
> a) NFS permissions are checked by the _server_, not the client.
>
> b) Cache consistency requirements are _much_ more stringent for
> asynchronous operation. Think for instance about an asynchronous
> mkdir(): how should the client guarantee exclusive semantics (i.e. that
> mkdir either creates a new directory or returns an EEXIST error)? how
> should it guarantee that the server will have enough disk space to
> satisfy your request? how should it guarantee that nobody will change
> the permissions on the parent directory before the metadata was synced
> to disk?,...
>
> People are considering how to implement this sort of thing using the
> NFSv4 concept of delegations and applying them to directories. It is not
> yet obvious how all the details will be solved.
>
> Trond
>
>
