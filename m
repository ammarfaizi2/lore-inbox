Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWIRS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWIRS3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWIRS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:29:40 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:36589 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S1751025AbWIRS3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:29:39 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Stuart MacDonald'" <stuartm@connecttech.com>,
       "'Andi Kleen'" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: TCP stack behaviour question
Date: Mon, 18 Sep 2006 14:29:14 -0400
Organization: Connect Tech Inc.
Message-ID: <005a01c6db50$587929c0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart MacDonald [mailto:stuartm@connecttech.com] 
> What happened was this: I had a run where I captured output with
> tcpdump. My original post was based on that, and the results of the
> debug output from my app. For whatever reason, it appears the stack
> didn't generate all of the packets it should have. When the log showed
> a second-last to last retransmit time of about 27 seconds, and then a
> gap of about 400 to the very next packet of any kind, I assumed that
> meant the stack had given up on the retransmits when it appears
> something else was going on.

I did another run and confirmed this. The tcpdump capture shows that
seven retransmits are sent, obeying the exponential backoff. Then
something odd happens. Instead of the 8th retransmit at 7th + 26.88
seconds, there is an arp at 7th + 4.159722 seconds. There are three
arps in fact, each one second apart and directed to the MAC of the
powered-off machine. After this there are further arps (in groups of
three one second apart), but they are broadcast and have a backoff
schedule.

The kernel debugging shows that tcp_write_timeout() and
tcp_retransmit_timer() are still being called though, right up to what
would be the 16th retransmit.

I suppose that the TCP retransmits aren't being sent because the
ethernet and/or IP layers don't know what's going on, which is what's
producing the arps. Is that correct? Is that documented anywhere?

I was expecting to see all 15 retransmits, and was confused when I
didn't see them.

..Stu

