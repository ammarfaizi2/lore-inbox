Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVIMQdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVIMQdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVIMQdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:33:53 -0400
Received: from mail.collax.com ([213.164.67.137]:65501 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S964863AbVIMQdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:33:50 -0400
Message-ID: <4326FF69.9060004@trash.net>
Date: Tue, 13 Sep 2005 18:33:45 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nuutti Kotivuori <naked@iki.fi>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: netfilter QUEUE target and packet socket interactions buggy or
 not
References: <87fysa9bqt.fsf@aka.i.naked.iki.fi>	<20050912.151120.104514011.davem@davemloft.net>	<87br2xap9o.fsf@aka.i.naked.iki.fi> <877jdl9r1u.fsf@aka.i.naked.iki.fi>
In-Reply-To: <877jdl9r1u.fsf@aka.i.naked.iki.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuutti Kotivuori wrote:
> 
> Appended here is a backtrace with the tg3 driver. Also, it seems that
> the bug cannot be reproduced with uniprocessor, only SMP.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000018

This means inode->i_security was NULL. AFAICT it is only set to NULL in
inode_free_security() when the inode is freed. This shouldn't happen
while the packet is queued since the skb should hold a reference to
the socket on the output path. So it could be some protocol forgetting
to increase the refcnt when taking a reference. What kind of packet
is this? And what kernel version are you running? Until recently
ip_conntrack did some fiddling with skb->sk which could lead to
a packet on the output path with skb->sk set but no reference taken.

