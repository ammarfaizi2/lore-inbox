Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTDDKGH (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 05:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTDDKGH (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 05:06:07 -0500
Received: from f109.pav2.hotmail.com ([64.4.37.109]:27148 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263506AbTDDKFi (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 05:05:38 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: disable TCP/IP checksum
Date: Fri, 04 Apr 2003 10:17:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F109Dd3OJXsNQptgFrY00002ff5@hotmail.com>
X-OriginalArrivalTime: 04 Apr 2003 10:17:01.0880 (UTC) FILETIME=[55589380:01C2FA93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  I am trying to disable the calculation of TCP/IP checksum so that it is 
calculated by the hardware. I did two things which I have discribed below. 
But I am not successful. Can any one please help me in this? I am using 
Intel pro 1000 GBE. I am stuck. All help are welcome.

Thanking You
Shesha

============
what I did
============

#1#
----
In the e1000_main.c
netdev->features = netdev->features | NETIF_F_HW_CSUM;

But when I check the value of skb->ip_summed in tcp.c its still 
CHECKSUM_NONE and not CHECKSUM_HW.
So I believe the checksum is still calculated by the software.

#2#
----
In linux/net/ipv4/tcp.c, tcp_sendmsg() makes calls to tcp_copy_to_page() and 
skb_add_data(); These two functions in turn makes calls to 
csum_and_copy_from_user(). I have modified the code of these two functions 
as follows. But it is NOT WORKING. If I do an FTP, the system just waits for 
response from the FTP server.

****************
MODIFIED CODE
****************

static inline int
tcp_copy_to_page(struct sock *sk, char *from, struct sk_buff *skb,
		 struct page *page, int off, int copy)
{
	int err = 0;
	unsigned int csum;


#ifdef MY_HACK
csum = copy_from_user(from, page_address(page)+off, copy);
err = csum = 0 ;
skb->ip_summed = CHECKSUM_HW;

#else
csum = csum_and_copy_from_user(from, page_address(page)+off, copy, 0, &err);

#endif


  if (!err) {

    if (skb->ip_summed == CHECKSUM_NONE)
	skb->csum = csum_block_add(skb->csum, csum, skb->len);

		skb->len += copy;
		skb->data_len += copy;
		skb->truesize += copy;
		sk->wmem_queued += copy;
		sk->forward_alloc -= copy;
	}
	return err;
}


static inline int
skb_add_data(struct sk_buff *skb, char *from, int copy)
{
	int err = 0;
	unsigned int csum;


	int off = skb->len;


#ifdef MY_HACK
csum = copy_from_user(from, skb_put(skb, copy), copy);
err = csum = 0;
skb->ip_summed = CHECKSUM_HW;

#else
csum = csum_and_copy_from_user(from, skb_put(skb, copy), copy, 0, &err);

#endif

   if (!err) {
     if (skb->ip_summed == CHECKSUM_NONE)
	skb->csum = csum_block_add(skb->csum, csum, off);
	return 0;
     }
	__skb_trim(skb, off);
	return -EFAULT;
   }




_________________________________________________________________
Say it now. Say it online. http://www.msn.co.in/ecards/ Send e-cards to your 
love

