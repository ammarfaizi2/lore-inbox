Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWC2Xh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWC2Xh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWC2Xh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:37:28 -0500
Received: from smop.co.uk ([81.5.177.201]:64914 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1751277AbWC2Xh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:37:27 -0500
Date: Thu, 30 Mar 2006 00:37:12 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-ID: <20060329233712.GA21810@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060326211514.GA19287@wyvern.smop.co.uk> <20060327172356.7d4923d2.akpm@osdl.org> <20060328070220.GA29429@smop.co.uk> <20060327231630.76e97b83.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327231630.76e97b83.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: adrian <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.71,
	required 5, autolearn=not spam, AWL -0.11, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 23:16:30 -0800 (-0800), Andrew Morton wrote:
> It's unlikely that the sock_inode_cache leak is related to the dcache leak,
> but we won't know until we know...

Looks like this might be the same issus as "dcache leak in 2.6.16-git8
(II)"...

I think I've found the patch which causes the leak - it was the
"use fget_light() in net/socket.c" patch.   I can't see anything
obviously wrong, although the patch changes the code so that in
sys_sendto and sys_recvfrom it now does a sockfd_put(sock) if the
sock_from_file call fails which didn't use to happen.   That seems to
agree more with other bits of code, but I've no idea what is the right
thing todo.

One item I spotted whilst perusing the code is that in net/core/sock.c
in compat_sock_common_getsockopt, it checks if
sk->sk_prot->compat_setsockopt is NULL before calling
sk->sk_prot->compat_getsockopt (set vs get).

I'll try and confirm tomorrow with a nice fresh build.   The command
I'm using to test is "dvbstream -f 650166.670 -v 570 -a 571 -o >
/dev/null" 

Thanks,

Adrian
