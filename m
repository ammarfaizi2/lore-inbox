Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWGaK5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWGaK5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWGaK5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:57:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57742
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751520AbWGaK5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:57:19 -0400
Date: Mon, 31 Jul 2006 03:57:16 -0700 (PDT)
Message-Id: <20060731.035716.39159213.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: herbert@gondor.apana.org.au, drepper@redhat.com, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060731105037.GA2073@2ka.mipt.ru>
References: <20060731103322.GA1898@2ka.mipt.ru>
	<E1G7V7r-0006jL-00@gondolin.me.apana.org.au>
	<20060731105037.GA2073@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Mon, 31 Jul 2006 14:50:37 +0400

> In syscall time kevents copy 40bytes for each event + 12 bytes of header 
> (number of events, timeout and command number). That's likely two cache
> lines if only one event is reported.

Do you know how many cachelines are dirtied by system call
entry and exit on typical system?

On sparc64 it is a minimum of 3 64-byte cachelines just to save and
restore the system call time cpu register state.  If application is
deep in a call chain, register windows might spill and each such
register window will dirty 2 more cachelines as they are dumped to the
stack.

I am not even talking about the other basic necessities of doing
a system call such as touching various task_struct and thread_info
state to check for pending signals etc.

System call overhead is non-trivial especially when you are using
it to move only a few small objects into and out of the kernel.

So I would say for up to 4 or 5 events, system call overhead alone
touches as many cache lines as the events themselves.
