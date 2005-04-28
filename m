Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVD3RYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVD3RYv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 13:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVD3RYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 13:24:50 -0400
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:4524 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261314AbVD3RYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 13:24:46 -0400
Date: Thu, 28 Apr 2005 18:34:51 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: linux-kernel@vger.kernel.org
Cc: Werner Almesberger <werner@almesberger.net>
Subject: Non-blocking sockets, connect(), and socket states
Message-ID: <20050428103451.GG4798@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[previously sent to the allegedly dead netdev@oss.sgi.com]

Hi,

Through playing with tcpcp[1], I've found out about a quirk in the
kernel's handling of non-blocking connection-based sockets. The
sk_socket->state value can take on one of SS_FREE, SS_UNCONNECTED,
SS_CONNECTING, SS_CONNECTED or SS_DISCONNECTING. On a standard
*blocking*, connection-oriented socket (eg, TCP), after connect()
returns, sk_socket->state will be SS_CONNECTED.

However, if the socket is placed into non-blocking mode before the
connect() call, connect() returns immediately with EINPROGRESS, and
the sk_socket->state is set to SS_CONNECTING. When the socket
finally does connect, the application is notified via poll(), but
the state remains as SS_CONNECTING (which causes issues for tcpcp,
though doesn't appear to have any other externally visible
implications).

Werner, the author of tcpcp, suggests that the application should
call connect() on the socket a second time, after the successful
connection, to force the sk_socket->state value to SS_CONNECTED.

Should it be the kernel's responsibility to set SS_CONNECTED when
the connection is established? Or should I go file bugs and submit
patches on all the applications that use non-blocking sockets and
don't call connect() a second time?

Thanks in advance,

Bernard.

[1] http://tcpcp.sf.net/

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
