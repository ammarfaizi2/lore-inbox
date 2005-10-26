Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVJZTes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVJZTes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVJZTes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:34:48 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:39865 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S964882AbVJZTer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:34:47 -0400
From: Steve Snyder <R00020C@freescale.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "Badness in local_bh_enable" - a reasonable fix?
Date: Wed, 26 Oct 2005 15:34:38 -0400
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261534.38291.R00020C@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I observed the following on a Fedora Core 3 system, running kernel 
2.6.12-1.1380_FC3.  I am posting this here because a quick Googling 
indicates that the problem is not specific to this environment.  ] 

Today I found my system log filled with the error shown below.  
Reading a 366MB file across a NFS mount results in over 6300 
occurrences of the error being written to the system log of the NFS 
server.  

I have 2 network interfaces in the NFS server machine, a standard 
kernel Ethernet device driver and my own Ultra-Wide Band (UWB) device 
driver.  (In the error shown below the references to "fsuwbpci" are my 
driver.) This problem is not seen when using the Ethernet interface, 
but is perfectly consistent when reading a NFS-mounted file across the 
UWB interface.  Therefore there is a problem with my code.  

I quickly established that the error came from within this routine:

  void netdev_tx_ack(struct net_device *dev, struct sk_buff *skb)
  {
     struct  netdev_priv *priv = (struct netdev_priv *) dev->priv;
  
     priv->stats.tx_packets++;
     priv->stats.tx_bytes += skb->len;
  
     netdev_resume(dev);
     dev_kfree_skb(skb);
  }

Googling told me that a) other people had seen the same problem, 
around the 2.6.11 timeframe; and b) use of dev_kfree_skb_irq() had 
fixed it.  I replaced the "dev_kfree_skb(skb)" above with 
"dev_kfree_skb_irq(skb)" and now all seems well.  I can transfer a 
file across the NFS mount via the UWB interface with no errors seen in 
the system log.  

I am uncomfortable with this modification, though, because I don't know 
what it actually does and what ramifications it will have for earlier 
kernel versions.  This driver code , with appropriate #ifdef's, is 
used on a wide range of kernel versions, including 2.4.x kernels.  

Please educate me.  Is replacing dev_kfree_skb() with 
dev_kfree_skb_irq() a reasonable solution to this problem?  Did I 
break backward-compatibility with this modification to my driver?  

Thank you.

-------------------------------------------

kernel: Badness in local_bh_enable at kernel/softirq.c:140 (Tainted: P     )
kernel:  [<c0127e50>] local_bh_enable+0x66/0x78
kernel:  [<f8c57c3f>] svc_write_space+0x21/0x85 [sunrpc]
kernel:  [<c02f3819>] sock_wfree+0x34/0x36
kernel:  [<c02f5067>] __kfree_skb+0x52/0x142
kernel:  [<f8a9442f>] card_send_packet+0x23/0xb6 [fsuwbpci]
kernel:  [<f8a94258>] card_send_request+0x14c/0x300 [fsuwbpci]
kernel:  [<f8a94013>] card_send+0x42/0x13b [fsuwbpci]
kernel:  [<f8a95ec1>] netdev_tx+0x34/0x5d [fsuwbpci]
kernel:  [<f8a40280>] ipt_do_table+0x254/0x321 [ip_tables]
kernel:  [<c030c346>] qdisc_restart+0x84/0x640
kernel:  [<c030cf29>] pfifo_fast_enqueue+0x0/0x89
kernel:  [<c02fb2c2>] dev_queue_xmit+0xba/0x589
kernel:  [<f89c6091>] ipt_local_out_hook+0x66/0x6d [iptable_filter]
kernel:  [<c03019f6>] neigh_connected_output+0x8a/0xd1
kernel:  [<c031ce31>] ip_finish_output+0x13d/0x211
kernel:  [<c031ccdb>] dst_output+0x0/0x19
kernel:  [<c031efd8>] ip_push_pending_frames+0x30c/0x4b0
kernel:  [<c031ccdb>] dst_output+0x0/0x19
kernel:  [<c033a91e>] udp_push_pending_frames+0x139/0x258
kernel:  [<c033af74>] udp_sendmsg+0x4fb/0x6be
kernel:  [<c02f3bae>] sock_alloc_send_skb+0x16/0x1b
kernel:  [<c031e5eb>] ip_append_data+0x55d/0x80b
kernel:  [<c033ad69>] udp_sendmsg+0x2f0/0x6be
kernel:  [<c0341fb1>] inet_sendmsg+0x3e/0x4a
kernel:  [<c02f09ce>] sock_sendmsg+0xf3/0x10e
kernel:  [<c0341fb1>] inet_sendmsg+0x3e/0x4a
kernel:  [<c013e9b9>] autoremove_wake_function+0x0/0x37
kernel:  [<c02f09ce>] sock_sendmsg+0xf3/0x10e
kernel:  [<c02f0a0f>] kernel_sendmsg+0x26/0x2c
kernel:  [<c02f404a>] sock_no_sendpage+0x56/0x69
kernel:  [<c033b217>] udp_sendpage+0xe0/0x11e
kernel:  [<c034202e>] inet_sendpage+0x71/0x8f
kernel:  [<f8c578e2>] svc_sendto+0x99/0x25a [sunrpc]
kernel:  [<c0192d5f>] dput+0xca/0x5dc
kernel:  [<f8c57f2f>] svc_udp_sendto+0xe/0x22 [sunrpc]
kernel:  [<f8c598d5>] svc_send+0xc4/0x107 [sunrpc]
kernel:  [<f8cc1011>] fh_put+0x136/0x180 [nfsd]
kernel:  [<f8c5bb22>] svcauth_unix_release+0x38/0x4e [sunrpc]
kernel:  [<f8ccd06a>] nfs3svc_encode_attrstat+0x0/0x238 [nfsd]
kernel:  [<f8c56c04>] svc_process+0x3a3/0x61f [sunrpc]
kernel:  [<c0131fe5>] sigprocmask+0xc0/0x29b
kernel:  [<f8cbe478>] nfsd+0x1c4/0x459 [nfsd]
kernel:  [<f8cbe2b4>] nfsd+0x0/0x459 [nfsd]
kernel:  [<c01012c1>] kernel_thread_helper+0x5/0xb

-------------------------------------------

