Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVI2JCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVI2JCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVI2JCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:02:14 -0400
Received: from apollo.nbase.co.il ([194.90.137.2]:11027 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S1751264AbVI2JCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:02:13 -0400
Message-ID: <433BAECF.9000403@mrv.com>
Date: Thu, 29 Sep 2005 12:07:27 +0300
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, yang.yi@bmrtech.com
Subject: Re: 2.6.14-rc2-rt2
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>	 <1127840377.27319.11.camel@cmn3.stanford.edu>	 <1127862619.4004.48.camel@dhcp153.mvista.com>	 <1127876673.9430.2.camel@cmn3.stanford.edu>	 <20050928094805.GA30446@elte.hu> <1127925295.24916.4.camel@cmn3.stanford.edu>
In-Reply-To: <1127925295.24916.4.camel@cmn3.stanford.edu>
Content-Type: multipart/mixed;
 boundary="------------070404000600020505030104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070404000600020505030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fernando Lopez-Lezcano wrote:
>>could you try 2.6.14-rc2-rt6, does it build?
> 
> 
> No, sorry...
> 
> fs/ntfs/aops.c: In function 'ntfs_end_buffer_async_read':
> fs/ntfs/aops.c:108: error: 'BH_Uptodate_Lock' undeclared (first use in
> this function)
> fs/ntfs/aops.c:108: error: (Each undeclared identifier is reported only
> once
> fs/ntfs/aops.c:108: error: for each function it appears in.)
> make[2]: *** [fs/ntfs/aops.o] Error 1
> 
> and (probably unrelated to rt):
> 
> drivers/isdn/hisax/config.c: In function 'HiSax_readstatus':
> drivers/isdn/hisax/config.c:636: warning: ignoring return value of
> 'copy_to_user', declared with attribute warn_unused_result
> drivers/isdn/hisax/config.c:647: warning: ignoring return value of
> 'copy_to_user', declared with attribute warn_unused_result
> drivers/isdn/hisax/callc.c: In function 'HiSax_writebuf_skb':
> drivers/isdn/hisax/callc.c:1781: warning: large integer implicitly
> truncated to unsigned type
> drivers/isdn/hisax/st5481_usb.c: In function 'st5481_in_mode':
> drivers/isdn/hisax/st5481_usb.c:648: error: 'URB_ASYNC_UNLINK'
> undeclared (first use in this function)
> drivers/isdn/hisax/st5481_usb.c:648: error: (Each undeclared identifier
> is reported only once
> drivers/isdn/hisax/st5481_usb.c:648: error: for each function it appears
> in.)
> make[3]: *** [drivers/isdn/hisax/st5481_usb.o] Error 1
> 
> -- Fernando
> 
> 
Regarding NTFS - try with the attached patch. It seems to be still 
missing from 2.6.14-rc2-rt7.

--------------070404000600020505030104
Content-Type: text/x-patch;
 name="linux-rt-ntfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-rt-ntfs.patch"

--- fs/ntfs/aops.c.old	2005-09-25 16:20:26.000000000 +0300
+++ fs/ntfs/aops.c	2005-09-25 16:22:04.000000000 +0300
@@ -104,8 +104,7 @@
 				"0x%llx.", (unsigned long long)bh->b_blocknr);
 	}
 	first = page_buffers(page);
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
+	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -120,8 +119,7 @@
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	/*
 	 * If none of the buffers had errors then we can set the page uptodate,
 	 * but we first have to perform the post read mst fixups, if the
@@ -154,8 +152,7 @@
 	unlock_page(page);
 	return;
 still_busy:
-	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 	return;
 }
 

--------------070404000600020505030104--
