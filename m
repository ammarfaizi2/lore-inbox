Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284307AbRLGShj>; Fri, 7 Dec 2001 13:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284318AbRLGShX>; Fri, 7 Dec 2001 13:37:23 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:30499 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284307AbRLGSgw>; Fri, 7 Dec 2001 13:36:52 -0500
Message-ID: <3C110C43.4000801@redhat.com>
Date: Fri, 07 Dec 2001 13:36:51 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Nathan Bryant <nbryant@optonline.net>, Andris Pavenis <pavenis@lanet.lv>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <3C10E85F.7040009@lanet.lv> <3C10F9E0.7010906@optonline.net> <3C110287.8070205@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070708060402040002070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708060402040002070508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Doug Ledford wrote:

> Well, unfortunately, neither of the patches you guys sent do what I 
> was looking for ;-)  My goal with that code was to enable a specific 
> certain behaviour, and because of the deadlock I have to make a few 
> changes elsewhere for it to work properly.  The workaround patches are 
> fine for now, but later today I'll make a 0.12 that fixes it the way 
> I'm looking for.  (Hint: it's legal for a program to call SETTRIGGER 
> to disable PCM output, then call the write() routine to fill the 
> buffer, then call SETTRIGGER again to start output, otherwise known as 
> pre buffering, and I want to support that without forcing the DAC to 
> be started on update_lvi())
>
> The real answer is multipart:
>
> 1) during i810_open go back to the old behaviour of setting 
> dmabuf->trigger to PCM_ENABLE_INPUT and/or OUTPUT based on file mode.
>
> 2) make sure that i810_mmap clears dmabuf->trigger
>
> 3) make sure that in both i810_write and i810_read, we force the 
> trigger setting when we can't output/input any data because count <= 0
>
> 4) in update_lvi make the check something like:
>
> if (!dmabuf->enable && dmabuf->trigger) {
>    ....
> }
>
> That should solve the problem, I just haven't written it up yet.
>
>
>
OK, the attached patch should do what is mentioned above.

Doug Ledford


--------------070708060402040002070508
Content-Type: text/plain;
 name="patch-12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-12"

--- i810_audio.c.11	Thu Dec  6 16:53:41 2001
+++ i810_audio.c.12	Fri Dec  7 13:32:38 2001
@@ -198,7 +198,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.11"
+#define DRIVER_VERSION "0.12"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -952,7 +952,7 @@
 	 * the CIV value to the next sg segment to be played so that when
 	 * we call start_{dac,adc}, things will operate properly
 	 */
-	if (!dmabuf->enable) {
+	if (!dmabuf->enable && dmabuf->trigger) {
 		outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
 		if(rec) {
 			__start_adc(state);
@@ -1111,8 +1111,11 @@
 
 		/* 
 		 * This will make sure that our LVI is correct, that our
-		 * pointer is updated, and that the DAC is running
+		 * pointer is updated, and that the DAC is running.  We
+		 * have to force the setting of dmabuf->trigger to avoid
+		 * any possible deadlocks.
 		 */
+		dmabuf->trigger = PCM_ENABLE_OUTPUT;
 		i810_update_lvi(state,0);
 
 		if (signal_pending(current))
@@ -2280,6 +2283,7 @@
 			card->states[i] = NULL;;
 			return -EBUSY;
 		}
+		dmabuf->trigger |= PCM_ENABLE_INPUT;
 		i810_set_adc_rate(state, 8000);
 	}
 	if(file->f_mode & FMODE_WRITE) {
@@ -2291,6 +2295,7 @@
 		/* Initialize to 8kHz?  What if we don't support 8kHz? */
 		/*  Let's change this to check for S/PDIF stuff */
 	
+		dmabuf->trigger |= PCM_ENABLE_OUTPUT;
 		if ( spdif_locked ) {
 			i810_set_dac_rate(state, spdif_locked);
 			i810_set_spdif_output(state, AC97_EA_SPSA_3_4, spdif_locked);

--------------070708060402040002070508--

