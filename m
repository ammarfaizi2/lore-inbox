Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRGNTen>; Sat, 14 Jul 2001 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264846AbRGNTed>; Sat, 14 Jul 2001 15:34:33 -0400
Received: from [64.165.192.135] ([64.165.192.135]:27659 "EHLO
	server1.skystream.com") by vger.kernel.org with ESMTP
	id <S264841AbRGNTeU>; Sat, 14 Jul 2001 15:34:20 -0400
Message-ID: <B25E2E5A003CD311B61E00902778AF2A02BBD74B@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'paulus@linuxcare.com.au'" <paulus@linuxcare.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppp_generic.c: last_channel_index
Date: Sat, 14 Jul 2001 12:30:46 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that after I repeatedly opened and closed PPP connections, I would
get an Oops.  PPP daemon would try to allocate strange PPP interface numbers
(ppp12, for example) and other sanity checks would fail (kind != INTERFACE
|| CHANNEL)

The last_channel_index wasn't being cleaned up when the channel was closed,
leading to these problems the next time a PPP channel was opened.  This
patch fixes the problem for me.

using ppp-2.4.0, patch against: linux-2.4.6

Regards,
Brian

*** ppp_generic.c       Sun Apr 22 09:46:40 2001
--- /home/brian/linux/drivers/net/ppp_generic.c Fri Jul 13 18:38:30 2001
***************
*** 1871,1876 ****
--- 1796,1802 ----
        ppp_disconnect_channel(pch);
        wake_up_interruptible(&pch->file.rwait);
        spin_lock_bh(&all_channels_lock);
+       last_channel_index--;
        list_del(&pch->file.list);
        spin_unlock_bh(&all_channels_lock);
        if (atomic_dec_and_test(&pch->file.refcnt)) 
