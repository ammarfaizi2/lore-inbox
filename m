Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289698AbSAJVeX>; Thu, 10 Jan 2002 16:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289696AbSAJVeO>; Thu, 10 Jan 2002 16:34:14 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:360 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289692AbSAJVeD>; Thu, 10 Jan 2002 16:34:03 -0500
Message-ID: <3C3E08C9.6030701@redhat.com>
Date: Thu, 10 Jan 2002 16:34:01 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver v0.19 still freezes machine
In-Reply-To: <Pine.LNX.4.33.0201101513410.31079-100000@coffee.psychology.mcmaster.ca>
Content-Type: multipart/mixed;
 boundary="------------040107020801070403060803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107020801070403060803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mark Hahn wrote:

>>So it hangs with artsd then?  Get me the output of ps ax | grep artsd and 
>>that will tell me the artsd configuration on both machines.  Also, just 
>>using artsd is all you are doing, not anything else to trigger the lockup?
>>
> 
> to be honest, I haven't a clue - I've never looked at audio
> stuff much.  on the bad machine, it plays a few silly kde
> sound effects, and then everything stops.  (RH 7.2, 2.4.18-pre2
> and your i810.c)


Duh!!!  All of the reports thus far have been artsd.  My guess is that we 
are getting a signal during drain_dac() and returning with -ERESTARTSYS on 
close.  Well, as it turns out i810_release() isn't checking the return value 
of drain_dac() and if we take a signal in drain_dac() then i810_release() 
releases the card's data structs without actually shutting down the card: 
Lockup.  So, try this patch and see if it doesn't solve your problem.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------040107020801070403060803
Content-Type: text/plain;
 name="test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.patch"

--- i810_audio.c.19	Wed Jan  9 04:58:41 2002
+++ i810_audio.c.20	Thu Jan 10 16:32:29 2002
@@ -1739,7 +1739,8 @@ static int i810_ioctl(struct inode *inod
 #endif
 		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
 			return 0;
-		drain_dac(state);
+		if(val = drain_dac(state))
+			return val;
 		dmabuf->total_bytes = 0;
 		return 0;
 
@@ -2417,12 +2418,16 @@ static int i810_release(struct inode *in
 	struct i810_card *card = state->card;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
+	int ret;
 
 	lock_kernel();
 
 	/* stop DMA state machine and free DMA buffers/channels */
 	if(dmabuf->trigger & PCM_ENABLE_OUTPUT) {
-		drain_dac(state);
+		if(ret = drain_dac(state)) {
+			unlock_kernel();
+			return ret;
+		}
 	}
 	if(dmabuf->trigger & PCM_ENABLE_INPUT) {
 		stop_adc(state);

--------------040107020801070403060803--

