Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUIPXV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUIPXV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUIPXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:21:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:17843 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268439AbUIPXQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:16:39 -0400
Date: Thu, 16 Sep 2004 16:16:38 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>,
       linux ia64 kernel <linux-ia64@vger.kernel.org>
Subject: Unaligned kernel access in crypto/sha1.c
Message-ID: <20040916231638.GA32514@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got

Sep 16 15:45:32 gnu-2 kernel: kernel unaligned access to
0xa0000002001c008e, ip=0xa0000001002135e0
Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
0xa0000002002d005e, ip=0xa0000001002135e0
Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
0xa0000002002d006e, ip=0xa0000001002135e0
Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
0xa0000002002d007e, ip=0xa0000001002135e0
Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
0xa0000002002d008e, ip=0xa0000001002135e0

on ia64 from sha1_transform in crypto/sha1.c:

/* Hash a single 512-bit block. This is the core of the algorithm. */
static void sha1_transform(u32 *state, const u8 *in)
{
        u32 a, b, c, d, e;
        u32 block32[16];
                                                                                
        /* convert/copy data to workspace */
        for (a = 0; a < sizeof(block32)/sizeof(u32); a++)
          block32[a] = be32_to_cpu (((const u32 *)in)[a]);
				     ^^^^^^^^^^^^^^^^
				 This may not be aligned for u32 on ia64.


H.J.

