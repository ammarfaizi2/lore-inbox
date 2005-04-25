Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVDYWRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVDYWRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVDYWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:17:17 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:4584
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261246AbVDYWRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:17:02 -0400
Date: Mon, 25 Apr 2005 15:08:40 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Olivier Galibert <galibert@pobox.com>
Cc: avi@argo.co.il, linux-kernel@vger.kernel.org
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
Message-Id: <20050425150840.5f27f77a.davem@davemloft.net>
In-Reply-To: <20050425220603.GA64842@dspnet.fr.eu.org>
References: <20050425170259.GA36024@dspnet.fr.eu.org>
	<426D40D4.8050900@argo.co.il>
	<20050425121953.6b5c3278.davem@davemloft.net>
	<20050425220603.GA64842@dspnet.fr.eu.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 00:06:03 +0200
Olivier Galibert <galibert@pobox.com> wrote:

> Do you think possible to extent the sendpage api to add some kind of
> "don't get the pages, copy them if you need them" flag?

No, not really.

Do you happen to run the scsi->done() function from iscsi
as soon as the write over the TCP socket completes returns
success?  That is likely what is causing the problem.

When you call scsi->done(), the buffer is effectively released
and the scsi/st.c driver can legally reuse it once you've done
that.

tcp_sendpages() is really meant to be invoked for page cache
pages, or temporary pages cons'd up specifically for that
send call.   Just look at what TCP sendmsg does, for example.
It carves up a per-socket cached PAGE to put the user's data
into.

You could do something similar in iSCSI and for now I highly
suggest that is what you do.

You could also:

	1) set TCP_CORK to 1
	2) tcp_sendmsg() the scsi tape data
	3) tcp_sendpage() to remaining pages
	4) set TCP_CORK to 0

so that tcp_sendmsg() does all the data copying for you.

Finally, you could also use "SIOCOUTQ" ioctl to watch the
write buffer get released.  Call it once before you do the send,
save that value, then after your send wait for it to hit
or pass the old value you saved.

In short, you're using an API in a way it was never designed
to be used.  We don't lock pages, and that is a deliberate
design decision.  When we send pages over the wire using
TCP sendpages out of the page cache, the file contents _CAN_
change mid-send, but that's OK because the card calculates
the packet checksums so no data corruption nor quality of
implementation issues arise as a result.

Again, this behavior and these mechanics were deliberately
made to function this way.
