Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270555AbTGNHG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270556AbTGNHG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:06:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21653 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270555AbTGNHG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:06:29 -0400
Date: Mon, 14 Jul 2003 08:20:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: Entrope <entrope@gamesnet.net>, Davide Libenzi <davidel@xmailserver.org>,
       Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030714072058.GD24031@mail.jlokier.co.uk>
References: <877k6m6l2k.fsf@sanosuke.troilus.org> <MDEHLPKNGKAHNMBLJOLKGEHGEFAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEHGEFAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, you are point out that given a certain base assumption, namely
that the number of active desriptors is proportional to the number of
inactive descriptors, that epoll does not scale any differently to poll.

Correct.

Davide and I have pointed out that the key difference between
select/poll and epoll, mathematically, is that epoll time is
bounded by the number of active descriptors, and select/poll time is not.

Also correct.

(The latter is a logically stronger statement than the former, because
it has fewer assumptions, however that doesn't make it's increased
range of applicability relevant.)

Now if you look at web server benchmarks and other artificial
benchmarks, rumour has it that epoll-based server CPU usage increases
linearly with load, and pages served increases linearly with the
number of requests, until the point where the server is maxed, after
which both these observables remain roughly constant with increasing
load.

Similar rumours have it that select/poll-based servers CPU usage
increases in the same way, but not only do the observables increase
faster (irrelevent for this discussion), when the server is maxed its
number of pages served decreases (badly) with increasing load.

In this sense, it's useful to refer to epoll as more scalable: not the
linear part at the beginning, but later, when resources are exhausted.

Load here is defined as number of concurrent client connections.  In
fact, the number of active descriptors _is_ less than proportional to
the number of idle descriptors in this state, because the slower
responses act as a form of flow control on the rate of new connections
or new data coming in to the server.

If instead you define a test in terms of increasing the rate of
incoming connections, as if the clients are oblivious to each other,
then your point might be spot on.  But that is a different kind of
test, and it doesn't take away from the validity of the first kind.

-- Jamie
