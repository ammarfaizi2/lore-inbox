Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUBIW3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUBIW3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:29:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265303AbUBIW25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:28:57 -0500
Date: Mon, 9 Feb 2004 14:28:42 -0800
From: "David S. Miller" <davem@redhat.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, scott.feldman@intel.com
Subject: Re: 2.6.2 crash after network link failure
Message-Id: <20040209142842.508ee3b7.davem@redhat.com>
In-Reply-To: <20040209130134.GA14136@vana.vc.cvut.cz>
References: <20040209130134.GA14136@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004 14:01:34 +0100
Petr Vandrovec <vandrove@vc.cvut.cz> wrote:

> It looks to me like that we've got skb on completion_queue which was connected
> to a bit unhappy socket - one which had sk->sk_sleep uninitialized. Only problem 
> is that only af_unix sets skb->destructor to sock_wfree, so I somehow miss how 
> this could be triggered by e100 link change.

It is not only af_unix, any time we invoke skb_set_owner_w() we get sock_wfree()
as the destructor, furthermore sock_def_write_space is the default such handler
given to all sockets unless they override that.

Maybe e100 is mangling it's TX queue or in fact freeing things twice.

I think what might be happening is that somehow the TX queue is corrupted if
e100_config() runs (due to link UP state change) while there are active normal
SKB packets on the TX queue.  Or perhaps some TX queue handling locking issue.

Scott, any ideas?
