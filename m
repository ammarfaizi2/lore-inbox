Return-Path: <linux-kernel-owner+w=401wt.eu-S932089AbXAFTs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbXAFTs2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbXAFTs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:48:28 -0500
Received: from mail2.prologon.ch ([212.25.21.124]:26285 "EHLO
	mail2.prologon.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbXAFTs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:48:27 -0500
X-Greylist: delayed 1175 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 14:48:27 EST
Date: Sat, 6 Jan 2007 20:28:37 +0100
From: Manuel Feier <mfeier@netsteps.ch>
To: linux-kernel@vger.kernel.org
Subject: IP Networking: ip_queue_xmit, sockets and TCP output question
 (Linux 2.6.17)
Message-ID: <20070106202837.0e1a0053@equilibrum>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux kernel hackers, 

I'm trying to extend the kernel in a way that I am able to collect
user-based IP networking information (e.g. which system user generated
how much IP traffic). Unfortunately this doesn't seem to be a topic that
is well documented, so I try my luck here.

For capturing the outgoing TCP traffic, I found the function
"ip_queue_xmit" (net/ipv4/ip_output.c) would be adequate. I added the
following code to the function right after the line
skb->priority = sk->sk_priority; 

if (sk && sk->sk_socket) {
ip4acct_user_sent(SOCK_INODE(sk->sk_socket)->i_uid,
ntohs(iph->tot_len),6); 
}
else {
ip4acct_user_sent(IPACCT_NOUSER,
ntohs(iph->tot_len),6);
}

This seems to work well if I send a small amount of TCP
data (512 bytes) with nc from an unprivileged user of that host. If I
open a website (lots of data / images) however, a few packets
don't appear to be be related to a socket and
hence are accounted to NOUSER (~2 %). If I continuously keep opening
multiple webpages at a time, some outgoing TCP traffic even gets
accounted to user root (uid 0) instead of the unprivileged user that
owns the webbrowser.

For debugging, I logged the source and destination address of those
packets that go into the else{} branch above, and it appears these
are packets that clearly belong to the webbrowser connection.

I now wonder what I am getting wrong about the function ip_queue_xmit:

- How can it be that a TCP/IP packet which belongs to a http
transmission has no socket that could be found with the first function
above?
- How can it be that (seemingly under increased network load) another
socket owner is returned than the one responsible for the load?

I'd appreciate your help very much, also ideas about debugging or
conceptual hints.

Thanks,

Manuel

