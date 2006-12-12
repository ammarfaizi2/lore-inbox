Return-Path: <linux-kernel-owner+w=401wt.eu-S1750833AbWLLBbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWLLBbE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWLLBbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:31:04 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41889
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750833AbWLLBbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:31:01 -0500
Date: Mon, 11 Dec 2006 17:31:00 -0800 (PST)
Message-Id: <20061211.173100.74720551.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
From: David Miller <davem@davemloft.net>
In-Reply-To: <457DE27E.5000100@cosmosbay.com>
References: <200612112027.kBBKR4nG006298@shell0.pdx.osdl.net>
	<457DCC60.3050006@cosmosbay.com>
	<457DE27E.5000100@cosmosbay.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Mon, 11 Dec 2006 23:58:06 +0100

> Some subsystems dont need more than 32bits timestamps.
> 
> See for example net/ipv4/inetpeer.c and include/net/tcp.h :
> #define tcp_time_stamp            ((__u32)(jiffies))
> 
> 
> Because most timeouts should work with 'normal jiffies' that are 32bits on 
> 32bits platforms, it makes sense to be able to use only 32bits to store them 
> and not 64 bits, to save ram.
> 
> This patch introduces jiffies_32, and related comparison functions 
> time_after32(), time_before32(), time_after_eq32() and time_before_eq32().
> 
> I plan to use this infrastructure in network code for example (struct 
> dst_entry comes to mind).

The TCP case is because the protocol limits the size of
the timestamp we can store in the TCP Timestamp option.

Otherwise we would use the full 64-bit jiffies timestamp,
in order to have a larger window of values which would not
overflow.

Since there is no protocol limitation involved in cases
such as dst_entry, I think we should keep it at 64-bits
on 64-bit platforms to make the wrap-around window as
large as possible.

I really don't see any reason to make these changes.  Yes,
you'd save some space, but one of the chief advantages of
64-bit is that we get larger jiffies value windows.  If
that has zero value, as your intended changes imply, then
we shouldn't need the default 64-bit jiffies either, by
implication.
