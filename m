Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTBEVBR>; Wed, 5 Feb 2003 16:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTBEVBR>; Wed, 5 Feb 2003 16:01:17 -0500
Received: from fmr01.intel.com ([192.55.52.18]:46322 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264908AbTBEVBQ>;
	Wed, 5 Feb 2003 16:01:16 -0500
Subject: skb_padto and small fragmented transmits
From: Chris Leech <christopher.leech@intel.com>
To: netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1044481190.9268.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 13:39:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at the new software padding routines, something caught my
eye in skb_padto.  It seemed that the fragmented portion of a packet
would actually be counted twice when checking to see if padding is
needed, as skb->len already includes the count of skb->data_len.

> unsigned int size = skb->len + skb->data_len;

I tested this by modifying e1000 to use skb_padto, disabling TCP
timestamps, and writing a small app to transmit 4 bytes using sendfile. 
The resulting packet had 54 bytes of headers, and 4 bytes of data in a
separate fragment.  Calling skb_padto(skb,60) should have linearized the
skb, and zeroed out the first 2 bytes of tailroom.  Instead the length
was incorrectly calculated as 62 bytes, and the buffer was returned as
is.

Changing skb_padto to simply use size = skb->len fixed the padding, but
then I started seeing incorrect TCP checksums going out.  I found this
comment in skb_copy_expand that seemed to explain things.

> BUG ALERT: ip_summed is not copied. Why does this work? Is it used
> only by netfilter in the cases when checksum is recalculated? --ANK

So after calling skb_copy_expand the checksum is not recalculated in
software, but the checksum offload information is discarded.

-- 
Chris Leech <christopher.leech@intel.com>

