Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTKLAr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTKLAr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:47:57 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:60056 "EHLO
	fozzie.sanmateo.corp.akamai.com") by vger.kernel.org with ESMTP
	id S261239AbTKLArs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:47:48 -0500
Message-ID: <3FB1832C.35A52F9A@akamai.com>
Date: Tue, 11 Nov 2003 16:47:40 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tulip-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org, akpm@zip.com.au, danner@akamai.com,
       bmancuso@akamai.com
Subject: Poss. bug in tulip driver since 2.4.7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The inner for loop shown below was not
supposed to be  inside  the  outside  loop.
They  also use  the  same index i.
Due to  this, when mc_count is more than
14,  with non ASIX chips,  panics, corruptions
and  denial of services to multicast addresses
can  result!

http://lxr.linux.no/source/drivers/net/tulip/tulip_core.c#L1055

static void build_setup_frame_hash(u16 *setup_frm, struct net_device
*dev)
{
        struct tulip_private *tp = (struct tulip_private *)dev->priv;
        u16 hash_table[32];
        struct dev_mc_list *mclist;
        int i;
        u16 *eaddrs;

        memset(hash_table, 0, sizeof(hash_table));
        set_bit_le(255, hash_table);                    /* Broadcast
entry */
        /* This should work on big-endian machines as well. */
        for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
             i++, mclist = mclist->next) {
                int index = ether_crc_le(ETH_ALEN, mclist->dmi_addr) &
0x1ff;

                set_bit_le(index, hash_table);

                for (i = 0; i < 32; i++) {
                        *setup_frm++ = hash_table[i];
                        *setup_frm++ = hash_table[i];
                }
                setup_frm = &tp->setup_frame[13*6];
        }

        /* Fill the final entry with our physical address. */
        eaddrs = (u16 *)dev->dev_addr;
        *setup_frm++ = eaddrs[0]; *setup_frm++ = eaddrs[0];
        *setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
        *setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
}



Thanks,
Prasanna.

