Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTH1VTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTH1VTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:19:32 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:29562 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264242AbTH1VTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:19:30 -0400
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0308281555540.1044-100000@neptune.local>
References: <Pine.LNX.4.44.0308281555540.1044-100000@neptune.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1062105549.17230.421.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Aug 2003 22:19:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2003-08-28 at 14:57, Pascal Schmidt wrote:

> > Many thanks --- I was able to reproduce this very easily, and I know of
> > one or two very unusual things that fsx does which might well be the
> > trigger here.  I'll let you know how things go.
> 
> Good, at least it's not a bug that only happens here and is hard to
> reproduce elsewhere.
> 
> I hope this does not happen under normal fs usage. ;)

It's all down to ext3_writepage() using data-journaling rather than
metadata journaling.  

The obvious fix is just to make the journal_dirty_async_data() code
commit its writes as metadata if the inode is marked for
data-journaling, and to set the transaction handle to be synchronous in
that case.  Sounds like a recipe for deadlock if done incorrectly,
though, so I'll give it a more careful look tomorrow.

Cheers,
 Stephen

