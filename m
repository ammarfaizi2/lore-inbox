Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbTKLUJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTKLUJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 15:09:45 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:23024 "EHLO
	fozzie.sanmateo.corp.akamai.com") by vger.kernel.org with ESMTP
	id S264287AbTKLUJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 15:09:36 -0500
Message-ID: <3FB29377.796E7C6A@akamai.com>
Date: Wed, 12 Nov 2003 12:09:27 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tulip-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, danner@akamai.com, bmancuso@akamai.com
Subject: Re: Poss. bug in tulip driver since 2.4.7
References: <3FB1832C.35A52F9A@akamai.com> <20031111185419.0ff7a596.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Prasanna Meda <pmeda@akamai.com> wrote:
> >
> > The inner for loop shown below was not
> >  supposed to be  inside  the  outside  loop.
> >  They  also use  the  same index i.
> >  Due to  this, when mc_count is more than
> >  14,  with non ASIX chips,  panics, corruptions
> >  and  denial of services to multicast addresses
> >  can  result!
> >
> >  http://lxr.linux.no/source/drivers/net/tulip/tulip_core.c#L1055
>
> So can you confirm that the driver works correctly with this change?
>
> --- 25/drivers/net/tulip/tulip_core.c~tulip-hash-fix    2003-11-11 18:51:52.000000000 -0800
> +++ 25-akpm/drivers/net/tulip/tulip_core.c      2003-11-11 18:52:31.000000000 -0800
> @@ -979,12 +979,13 @@ static void build_setup_frame_hash(u16 *
>         for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
>              i++, mclist = mclist->next) {
>                 int index = ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x1ff;
> +               int j;
>
>                 set_bit_le(index, hash_table);
>
> -               for (i = 0; i < 32; i++) {
> -                       *setup_frm++ = hash_table[i];
> -                       *setup_frm++ = hash_table[i];
> +               for (j = 0; j < 32; j++) {
> +                       *setup_frm++ = hash_table[j];
> +                       *setup_frm++ = hash_table[j];
>                 }
>                 setup_frm = &tp->setup_frame[13*6];
>         }

No,  you need to bring the for loop outside the loop.
 - Otherwise we need to reset the setup_frame to
tp->setup_frame after every loop.
 - You do not need to set the setup_frm for every
mc address, we can set once after the complete
has_table is ready.
And also the  2.4 code missed a bit in tx_flags.

We did the following change that makes it identical
to 2.2 tulip driver, and it worked.

--- Linux/drivers/net/tulip/tulip_core.c  Fri Oct 10 20:22:29 2003
+++ linux/drivers/net/tulip/tulip_core.c        Fri Oct 10 20:28:19 2003
@@ -1054,19 +1054,19 @@

        memset(hash_table, 0, sizeof(hash_table));
        set_bit_le(255, hash_table);                    /* Broadcast entry */

        /* This should work on big-endian machines as well. */
       for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
             i++, mclist = mclist->next) {
                int index = ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x1ff;

                set_bit_le(index, hash_table);
+       }

-               for (i = 0; i < 32; i++) {
-                       *setup_frm++ = hash_table[i];
-                       *setup_frm++ = hash_table[i];
-               }
-               setup_frm = &tp->setup_frame[13*6];
+       for (i = 0; i < 32; i++) {
+               *setup_frm++ = hash_table[i];
+               *setup_frm++ = hash_table[i];
        }
+       setup_frm = &tp->setup_frame[13*6];

        /* Fill the final entry with our physical address. */
        eaddrs = (u16 *)dev->dev_addr;
@@ -1166,11 +1168,13 @@
                }
        } else {
                unsigned long flags;
+               u32 tx_flags = 0x08000000 | 192;

                /* Note that only the low-address shortword of setup_frame is valid!
                   The values are doubled for big-endian architectures. */
                if (dev->mc_count > 14) { /* Must use a multicast hash table. */
                        build_setup_frame_hash(tp->setup_frame, dev);
+                       tx_flags = 0x08400000 | 192;
                } else {
                        build_setup_frame_perfect(tp->setup_frame, dev);
                }
@@ -1180,7 +1184,6 @@
                if (tp->cur_tx - tp->dirty_tx > TX_RING_SIZE - 2) {
                        /* Same setup recently queued, we need not add it. */
                } else {
-                       u32 tx_flags = 0x08000000 | 192;
                        unsigned int entry;
                        int dummy = -1;


