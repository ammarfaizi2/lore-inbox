Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270061AbUJSXmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270061AbUJSXmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbUJSXlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:41:53 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:45717
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269905AbUJSWsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:48:12 -0400
Date: Tue, 19 Oct 2004 15:42:49 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: herbert@gondor.apana.org.au, vda@port.imtp.ilyichevsk.odessa.ua,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
Message-Id: <20041019154249.6afcaaad.davem@davemloft.net>
In-Reply-To: <1098225729.23628.2.camel@krustophenia.net>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
	<1098222676.23367.18.camel@krustophenia.net>
	<20041019215401.GA16427@gondor.apana.org.au>
	<1098223857.23367.35.camel@krustophenia.net>
	<20041019153308.488d34c1.davem@davemloft.net>
	<1098225729.23628.2.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 18:42:11 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-10-19 at 18:33, David S. Miller wrote:
> > On Tue, 19 Oct 2004 18:10:58 -0400
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > >   /*
> > >    * Since receiving is always initiated from a tasklet (in iucv.c),
> > >    * we must use netif_rx_ni() instead of netif_rx()
> > >    */
> > > 
> > > This implies that the author thought it was a matter of correctness to
> > > use netif_rx_ni vs. netif_rx.  But it looks like the only difference is
> > > that the former sacrifices preempt-safety for performance.
> > 
> > You can't really delete netif_rx_ni(), so if there is a preemptability
> > issue, just add the necessary preemption protection around the softirq
> > checks.
> > 
> 
> Why not?  AIUI the only valid reason to use preempt_disable/enable is in
> the case of per-CPU data.  This is not "real" per-CPU data, it's a
> performance hack.  Therefore it would be incorrect to add the preemption
> protection, the fix is not to manually call do_softirq but to let the
> softirq run by the normal mechanism.
> 
> Am I missing something?

In code paths where netif_rx_ni() is called, there is not a softirq return
path check, which is why it is checked here.

Theoretically, if you remove the check, softirq processing can be deferred
indefinitely.

What I'm saying, therefore, is that netif_rx_ni() it not just a performance
hack, it is necessary for correctness as well.
