Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWERWZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWERWZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWERWZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:25:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750885AbWERWZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:25:31 -0400
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: Jan Kara <jack@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <446C8EB1.3090905@bull.net>
References: <446C2F89.5020300@bull.net>
	 <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
	 <446C8EB1.3090905@bull.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 23:25:17 +0100
Message-Id: <1147991117.5464.124.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-05-18 at 17:11 +0200, Zoltan Menyhart wrote:

> > +		was_dirty = buffer_dirty(bh);
> 
> Why do not we use "buffer_jbddirty()"?

jbddirty is what we use for metadata that we don't want to get written
to disk yet.

For journaling to work, we must ensure that the transaction's metadata
gets written to and committed in the journal before it is allowed to be
written back to main backing store.  If we don't, and writeback occurs
early, then on a crash we can't rollback to the previous transaction.

So when we mark metadata as dirty we set the jbddirty flag but do *not*
set the normal dirty flag; so until the buffer is journaled, it is not
eligible for normal writeback.

This whole mechanism is only useful for metadata (plus data if we're in
data=journal mode.)  For normal ordered data writes, we never use
jbddirty because there's just no problem if the data is written before
the transaction completes.

--Stephen


