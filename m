Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVFPWmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVFPWmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVFPWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:41:46 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42126 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261844AbVFPWgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:36:43 -0400
Date: Fri, 17 Jun 2005 00:34:08 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050616223407.GA30978@electric-eye.fr.zoreil.com>
References: <14131924.1118848920765.JavaMail.www@wwinf0503>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14131924.1118848920765.JavaMail.www@wwinf0503>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> # i tried to remove NET_IP_ALIGN :

It works but the headers are not aligned any more. It could be interesting
to know what the smallest required alignment is (i.e
dev_alloc_skb(rx_buf_sz + 2^n); skb_reserve(skb, 2^n); increase n and when
the driver starts receiving again, you found it).

> But :
[...]
> Everything failed after 128 packets were received.

Can you give a try at:
http://www.fr.zoreil.com/people/francois/misc/20050616-2.6.12-rc-sis190-test.patch

Please issue a few packets, say 4 to 8, and check your log after an
ethtool -i eth0. Then wait for the Rx process to get stuck and issue
the same ethtool command. You can probably lower NUM_RX_DESC to 16 or
32 to minimize the output.

[...]
> I got a serious headache as i tried to understand how the RX ring works.
> But it is quite too difficult for me now.

The last descriptor of the Rx ring is supposed to be marked with an end
of ring indication (see RingEnd). When it is reached, the asic returns to
the start of the ring. The dirty_rx index locates the first entry in the
ring which is a candidate for refilling (assuming its Rx_skbuff entry is
equal to NULL: when a packet passes rx_copybreak, it does not generate a
hole in the ring). cur_rx locates the currently Rx DMAed buffer.
Both dirty_rx and cur_rx are meaningful % the actual number of entries in
the Rx ring, namely NUM_RX_DESC. Since NUM_RX_DESC usually is a power of
two, it is not uncommon to encounter % NUM_RX_DESC or & (NUM_RX_DESC - 1).

--
Ueimor
