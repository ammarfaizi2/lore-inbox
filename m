Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272130AbTHNB6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 21:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272131AbTHNB6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 21:58:32 -0400
Received: from waste.org ([209.173.204.2]:49105 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272130AbTHNB6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 21:58:31 -0400
Date: Wed, 13 Aug 2003 20:58:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Robert Love <rml@tech9.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030814015820.GH325@waste.org>
References: <20030813233957.GE325@waste.org> <3F3AD5F1.8000901@pobox.com> <1060821251.4709.449.camel@lettuce>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060821251.4709.449.camel@lettuce>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 05:34:12PM -0700, Robert Love wrote:
> On Wed, 2003-08-13 at 17:21, Jeff Garzik wrote:
> 
> > Do you really want to schedule inside preempt_disable() ?
> 
> in_atomic() includes a check for preempt_disable() ... that is actually
> all it checks (the preempt_count).  So this fix prevents that.
> 
> This patch is interesting, though, because if right now we are
> scheduling in the middle of per-CPU code there is a bug (regardless of
> kernel preemption -- and with kernel preemption off, the in_atomic()
> check might return false even though the code is accessing per-processor
> data).
> 
> So I think what we really want is to just never call this crypto_yield()
> thing when in any sort of critical section, which includes any
> per-processor data.

This is part of cryptoapi and given the large chunks of work you could
potentially hand to it, it's probably a good idea for it to work this
way. You hand it a long list of sg segments, it does the transform and
reschedules if it thinks it's safe. But its test of when it was safe
was not complete.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
