Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281225AbRLDVPu>; Tue, 4 Dec 2001 16:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283436AbRLDVPl>; Tue, 4 Dec 2001 16:15:41 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:40855 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283379AbRLDVPg>; Tue, 4 Dec 2001 16:15:36 -0500
Message-ID: <3C0D3CF7.6030805@redhat.com>
Date: Tue, 04 Dec 2001 16:15:35 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net>
Content-Type: multipart/mixed;
 boundary="------------030705020101080509060801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705020101080509060801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> There is a new version of the driver (0.07) on my web site.  It has 
>> this issue and one other issue fixed (hopefully).  The other issue is 
>> when using artsd with the 0.06 driver, I had a report that artsd would 
>> end up waiting on select forever and never getting woken up.  The 0.07 
>> driver changes wait queue and lvi handling in a few strategic places, 
>> so it should work.  However, it's untested.  Reports welcome. 
> 
> 
> With 0.07, the kernel goes into an endless sleep as soon as artsd calls 
> select(). I don't think the looping changes to i810_poll are correct... 
> or even necessary?


Probably not.  Although I did change it back but then change it in 
another way.  Use the attached patch to back out those changes and let 
me know if it works (for some reason, I doubt it).

> though the userfragsize change is probably appropriate.
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------030705020101080509060801
Content-Type: text/plain;
 name="foo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo"

--- i810_audio.c.07	Tue Dec  4 16:13:39 2001
+++ i810_audio.c.07b	Tue Dec  4 16:13:00 2001
@@ -1530,30 +1530,24 @@
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
 	unsigned int mask = 0;
-        DECLARE_WAITQUEUE(waita, current);
+	int count;
 
 	if(!dmabuf->ready)
 		return 0;
-        add_wait_queue(&dmabuf->wait, &waita);
-again:
+	poll_wait(file, &dmabuf->wait, wait);
 	spin_lock_irqsave(&state->card->lock, flags);
 	i810_update_ptr(state);
+	count = dmabuf->count;
+	spin_unlock_irqrestore(&state->card->lock, flags);
 	if (file->f_mode & FMODE_READ && dmabuf->enable & ADC_RUNNING) {
-		if (dmabuf->count >= (signed)dmabuf->userfragsize)
+		if (count >= (signed)dmabuf->userfragsize)
 			mask |= POLLIN | POLLRDNORM;
 	}
 	if (file->f_mode & FMODE_WRITE && dmabuf->enable & DAC_RUNNING) {
 		if ((signed)dmabuf->dmasize >=
-		    dmabuf->count + (signed)dmabuf->userfragsize)
+		    count + (signed)dmabuf->userfragsize)
 			mask |= POLLOUT | POLLWRNORM;
 	}
-	spin_unlock_irqrestore(&state->card->lock, flags);
-	if (mask == 0) {
-		poll_wait(file, &dmabuf->wait, wait);
-		goto again;
-	}
-        remove_wait_queue(&dmabuf->wait, &waita);
-
 	return mask;
 }
 

--------------030705020101080509060801--

