Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVECPcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVECPcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVECPcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:32:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:2456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261783AbVECPcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:32:25 -0400
Date: Tue, 3 May 2005 08:32:17 -0700
From: cliff white <cliffw@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
Message-ID: <20050503083217.35545e71@es175>
In-Reply-To: <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com>
References: <20050421152345.6b87aeae@es175>
	<20050503144325.GF4501@atrey.karlin.mff.cuni.cz>
	<1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 May 2005 08:01:03 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> On Tue, 2005-05-03 at 07:43, Jan Kara wrote:
> >   Hello,
> > 
> > > Started seeing some odd behaviour with recent kernels, haven't been able to
> > > run it down, could use some suggestions/help.
> > > 
> > > Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or
> > > reiserfs things work just fine.
> > > 
> > > With ext3, the  test stalls, such that:
> > > CPU is 50% idle, 50% waiting IO (top)
> > > vmstat shows one process blocked wio
> >   I've looked through your dumps and I spotted where is the problem -
> > it's our well known and beloved lock inversion between PageLock and
> > transaction start (giving CC to Badari who's the author of the patch
> > that introduced it AFAIK).
> 
> Yuck. It definitely not intentional.
> 
> >   The correct order is: first get PageLock and *then* start transaction.
> > But in ext3_writeback_writepages() first ext3_journal_start() is called
> > and then __mpage_writepages is called that tries to do LockPage and
> > deadlock is there. Badari, could you please fix that (sadly I think that
> > would not be easy)? Maybe we should back out those changes until it gets
> > fixed...
> 
> Hmm.. let me take a closer look. You are right, its not going to be
> simple fix.
> 
> Cliff, here is the patch to backout writepages() for ext3. Can you
> verify that problems goes away with this patch ?

Sure, it's semi-random behavior, so it'll take a few runs to be sure.
cliffw

> 
> Thanks,
> Badari


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
