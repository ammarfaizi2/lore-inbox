Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270513AbTGNDVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270514AbTGNDVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:21:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10389 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270513AbTGNDVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:21:48 -0400
Date: Mon, 14 Jul 2003 04:35:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714033552.GB23534@mail.jlokier.co.uk>
References: <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com> <20030714025644.GA23110@mail.jlokier.co.uk> <20030714031242.GC23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132015230.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307132015230.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > To be more precise, using the POLLRDHUP patch as-is, if someone sends
> > your program some data, then an URGent segment, then a FIN with
> > optional data in between, your program won't notice the second data or
> > FIN and will fail to clean up the socket.
> 
> And why ? To me it looks fairly simple. When the FIN is received a wakeup
> is done on the poll wait list and the following f_op->poll will fetch the
> RDHUP flag. Then the next epoll_wait() will fetch the event and will have
> all the info it needs to do things correctly.

Burp.
You're right.

The loop failure comes when user sends URG and more data _without_ FIN.

Then RDHUP is not set, and your loop will read up to before the URG
and no further.

(Normal behaviour would be to skip the URG segment and continue
reading data after it, or to include the URG segmenet if OOBINLINE is
set.)

Ahem,
-- Jamie
