Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTKLCu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTKLCu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:50:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:19936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbTKLCuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:50:19 -0500
Date: Tue, 11 Nov 2003 18:54:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Prasanna Meda <pmeda@akamai.com>
Cc: tulip-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, danner@akamai.com, bmancuso@akamai.com
Subject: Re: Poss. bug in tulip driver since 2.4.7
Message-Id: <20031111185419.0ff7a596.akpm@osdl.org>
In-Reply-To: <3FB1832C.35A52F9A@akamai.com>
References: <3FB1832C.35A52F9A@akamai.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna Meda <pmeda@akamai.com> wrote:
>
> The inner for loop shown below was not
>  supposed to be  inside  the  outside  loop.
>  They  also use  the  same index i.
>  Due to  this, when mc_count is more than
>  14,  with non ASIX chips,  panics, corruptions
>  and  denial of services to multicast addresses
>  can  result!
> 
>  http://lxr.linux.no/source/drivers/net/tulip/tulip_core.c#L1055

So can you confirm that the driver works correctly with this change?

--- 25/drivers/net/tulip/tulip_core.c~tulip-hash-fix	2003-11-11 18:51:52.000000000 -0800
+++ 25-akpm/drivers/net/tulip/tulip_core.c	2003-11-11 18:52:31.000000000 -0800
@@ -979,12 +979,13 @@ static void build_setup_frame_hash(u16 *
 	for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 	     i++, mclist = mclist->next) {
 		int index = ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x1ff;
+		int j;
 
 		set_bit_le(index, hash_table);
 
-		for (i = 0; i < 32; i++) {
-			*setup_frm++ = hash_table[i];
-			*setup_frm++ = hash_table[i];
+		for (j = 0; j < 32; j++) {
+			*setup_frm++ = hash_table[j];
+			*setup_frm++ = hash_table[j];
 		}
 		setup_frm = &tp->setup_frame[13*6];
 	}

_

