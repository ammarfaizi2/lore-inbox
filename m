Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWFML7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWFML7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWFML7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:59:46 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:28337 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932079AbWFML7p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:59:45 -0400
Subject: Re: NPTL mutex and the scheduling priority
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Pierre PEIFFER <pierre.peiffer@bull.net>
In-Reply-To: <20060613084819.GL3115@devserv.devel.redhat.com>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>
	 <1150115008.3131.106.camel@laptopd505.fenrus.org>
	 <20060612124406.GZ3115@devserv.devel.redhat.com>
	 <1150125869.3835.12.camel@frecb000686>
	 <20060613084819.GL3115@devserv.devel.redhat.com>
Date: Tue, 13 Jun 2006 14:04:32 +0200
Message-Id: <1150200272.3835.33.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/06/2006 14:03:26,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/06/2006 14:03:28,
	Serialize complete at 13/06/2006 14:03:28
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 04:48 -0400, Jakub Jelinek wrote:
> On Mon, Jun 12, 2006 at 05:24:28PM +0200, S?bastien Dugu? wrote:
> >   The patch you refer to is at
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=114725326712391&w=2
> > 
> >   But maybe a better solution for condvars would be to implement
> > something like a futex_requeue_pi() to handle the broadcast and
> > only use PI futexes all along in glibc.
> 
> FUTEX_REQUEUE certainly should be able to requeue from normal futex
> to a PI futex or vice versa, I don't think it is desirable to create
> a separate futex cmds for that.

  Indeed, that would be preferable but might get tricky.

> Now not sure what do you mean by "use PI futexes all along in glibc",
> certainly you don't mean using them for normal mutexes, right? 
> FUTEX_LOCK_PI has effects the normal futexes shouldn't have.
> The condvars can be also used with PP mutexes and using PI for the cv
> internal lock unconditionally wouldn't be the right thing either.

  I effectively meant using a PI futex for the cv __data.__futex but now
I realize it's a Really Bad Idea.

  To summarize (correct me if I'm wrong), we need a way in the broadcast
case to promote the cv __data.__futex type to the type of the external
mutex (PI, PP, normal) in the requeue path. Therefore we need the
ability to requeue waiters on a regular futex onto a PI futex.

  Ingo, Thomas, is this feasible?

  Sébastien.



