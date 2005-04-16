Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVDPFCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVDPFCT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 01:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVDPFCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 01:02:19 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62349 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261691AbVDPFCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 01:02:15 -0400
Subject: Re: ACPI/HT or Packet Scheduler BUG?
From: Steven Rostedt <rostedt@goodmis.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Graf <tgraf@suug.ch>, hadi@cyberus.ca, netdev <netdev@oss.sgi.com>,
       Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>, kuznet@ms2.inr.ac.ru,
       devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050416014906.GA3291@gondor.apana.org.au>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
	 <1113601029.4294.80.camel@localhost.localdomain>
	 <1113601446.17859.36.camel@localhost.localdomain>
	 <1113602052.4294.89.camel@localhost.localdomain>
	 <20050415225422.GF4114@postel.suug.ch>
	 <20050416014906.GA3291@gondor.apana.org.au>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 16 Apr 2005 01:01:37 -0400
Message-Id: <1113627698.4294.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-16 at 11:49 +1000, Herbert Xu wrote:


> Here is a quick'n'dirty fix to the problem at hand.  What happened
> between 2.6.10-rc1 and 2.6.10-rc2 is that qdisc_destroy started
> changing the next pointer of qdisc entries which totally confuses
> the readers because qdisc_destroy doesn't always take the tree lock.
> 
> This patch tries to ensure that all top-level calls to qdisc_destroy
> come under the tree lock.  As Thomas correctedly pointed out, most
> of the other qdisc_destroy calls occur after the top qdisc has been
> unlinked from the device qdisc_list.  However, someone should go
> through each one of the remaining ones (they're all in the individual
> sch_* implementations) and make sure that this assumption is really
> true.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> If anyone has cycles to spare and a stomach strong enough for
> this stuff, here is your chance :)
> 

FYI,

I ran the test case that Tarhon-Ohn had, but had to change his tc
execution from batch to single lines since the version of tc I have
segfaults on newlines.  Anyway, I did see the lock up with 2.6.11.2
after 7 iterations. I applied your patch, and it ran for 30 iterations
before I manually killed it. I didn't test any more than that, but this
seems to be the quick fix for now.

-- Steve


