Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUILG5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUILG5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUILG5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:57:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24588 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268496AbUILG4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:56:14 -0400
Date: Sun, 12 Sep 2004 08:56:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial of Service
Message-ID: <20040912065608.GC1444@alpha.home.local>
References: <022601c49866$9e8aa8f0$0300a8c0@s> <000001c49872$99333460$0200a8c0@wolf> <20040911204710.4aa7abed.davem@davemloft.net> <1094970424.29211.489.camel@sphere.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094970424.29211.489.camel@sphere.site>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, Sep 11, 2004 at 11:27:05PM -0700, Peter Zaitsev wrote:
 
> I do not care about TIME_WAIT  connection on client site itself, what
> concerns me is, until connection is not fully closed server side does
> not seems to be informed connection is dead and so  server resources are
> not deallocated.    
> 
> Any ideas ? 

TIME_WAIT status does not eat much resource, since they're in a separate
list. I've already had several *millions* of while stressing some equipment,
and I can assure you that it's really not a problem as long as you increase
your tcp_max_tw_buckets accordingly. There is even no performance impact
(I could still get 40000 hits/s with this number of time-waits). As David
said, the connection has been closed when it enters TIME_WAIT, so it has
been detached from apache.

I think you confuse it with CLOSE_WAIT. This is a very common case on web
servers when the client does not support HTTP keep-alive and does a
shutdown(WRITE) after sending its request. The server receives the FIN, and
passes from ESTABLISHED to CLOSE_WAIT during all the time it sends its data
to the client, then closes the connection, making it TIME_WAIT.

TIME_WAIT state is more annoying on the client side (eg when your apache
is a reverse proxy), because by default you can run out of source ports.
But you can increase the local source port range (ip_local_port_range),
decrease the FIN timeout which also happens to control TIME_WAIT timeout,
and even force tcp_tw_reuse to 1 to let the system reallocate an old
connection which was sitting in TIME_WAIT.

Hoping this helps,
Willy

