Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbUC2S4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUC2S4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:56:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42971 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263063AbUC2S4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:56:31 -0500
Subject: Re: [EXT3/JBD] Periodic journal flush not enough?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>
In-Reply-To: <20040326154851.7a3ad417.akpm@osdl.org>
References: <20040326231958.GA484@gondor.apana.org.au>
	 <20040326154851.7a3ad417.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080586577.2285.107.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Mar 2004 19:56:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-03-26 at 23:48, Andrew Morton wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > I've encountered a problem with the journal flush timer.  The problem
> > is that when a filesystem is short on space, relying on a timer-based
> > flushing mechanism is no longer adequate.  For example, on my P4 2GHz
> > I can trigger an ENOSPC error by doing
> > 
> > while :; do echo test > a; [ -s a ] || break; rm a; done; echo Out of space
> > 
> > on an ext3 file system with 12Mb of free space using the usual 5s
> > journal flush timer.
> 
> I cannot reproduce this.  Please send more details.  Journalling mode,
> kernel version, etc.

Sounds like it's due to the "b_committed_data" avoidance code.  Ext3
cannot immediately reuse disk space after a delete, because of lazy
writeback --- until the final writeback of the delete hits disk, we have
to be able to undo it.  And because in non-data-journaled modes we allow
new disk writes to hit disk before a transaction commit, that means we
can't reuse deleted blocks until after they are committed.

I've never seen it reported as a problem outside of artificial test
scenarios, but if it is something we need to address, Andreas Dilger's
patch looks good.

Cheers,
 Stephen


