Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVCBPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVCBPxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVCBPxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:53:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:236 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262332AbVCBPvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:51:22 -0500
Date: Wed, 2 Mar 2005 07:50:55 -0800
From: Paul Jackson <pj@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       elsa-devel@lists.sourceforge.net, jlan@engr.sgi.com, gh@us.ibm.com,
       efocht@hpce.nec.com, netdev@oss.sgi.com, kaigai@ak.jp.nec.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
Message-Id: <20050302075055.53207b1b.pj@sgi.com>
In-Reply-To: <1109753292.8422.117.camel@frecb000711.frec.bull.fr>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
	<1109753292.8422.117.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to worrying about performance and scaling, with accounting
enabled or disabled, one should also try to minimize code clutter in key
kernel files, such as fork.c

For example, one might, instead of adding 40 lines os fork_connector()
code to kernel/fork.c, instead add something like just the #include
<linux/connector.h> and the "fork_connector(current->pid, p->pid)" call
to kernel/fork.c, where include/linux/connector.h had something like:

	#ifdef CONFIG_FORK_CONNECTOR
	static inline void fork_connector(pid_t parent, pid_t child)
	{
		if (cn_fork_enable)
			__fork_connector(parent, child);
	}
	#else
	static inline void fork_connector(pid_t parent, pid_t child) {}
	#endif

Then bury the interesting code in the implementation of __fork_connector(),
in drivers/connector/cn_fork.c or some such place.

This adds a real function call in the case that cn_fork_enable is set.
That code path requires more than that anyway (and it makes kernel stack
backtraces more transparent).

But it removes 40 lines of fork_connector detail from fork.c.  And it
avoids marking a 40 line routine as inline ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
