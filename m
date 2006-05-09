Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWEIMmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWEIMmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWEIMmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:42:42 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:62689 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932481AbWEIMml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:42:41 -0400
Date: Tue, 9 May 2006 14:40:55 +0200
X-OfflineIMAP-1232629972-52656d6f7465-494e424f58: 1147178465-00668320445893-v4.0.11
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.17-rc3-mm1
Message-ID: <20060509124055.GA14437@ens-lyon.fr>
References: <20060501014737.54ee0dd5.akpm@osdl.org> <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com> <20060503064816.ef7ec2b7.akpm@osdl.org> <1146665732.27820.75.camel@localhost.localdomain> <20060503144318.GA5505@ens-lyon.fr> <20060505150509.GA16562@ens-lyon.fr> <1146911438.7467.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146911438.7467.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 10:30:38AM +0000, Thomas Gleixner wrote:
> Benoit,
> 
> On Fri, 2006-05-05 at 17:05 +0200, Benoit Boissinot wrote:
> > @@ -437,6 +438,12 @@ hrtimer_start(struct hrtimer *timer, kti
> >  
> >  	if (mode == HRTIMER_REL) {
> - 		tim = ktime_add(tim, new_base->get_time());
> +		ktime_t curr = new_base->get_time();
> +		
> +		tim = ktime_add(tim, curr);
> +
> 
> Can you change the debug that way? So we have the values which are
> added. Please print out new_base->id too.
> 
> > and when urxvtd hanged I had the following in dmesg:
> > [  356.696000] urxvtd: empty nanosleep 356726124322 17948911854451
> > 
> > So I suppose something is wrong in ktime_add()
> 
> Well, ktime_add is adding two 64 bit values.
> 
> The delta between the two values is 0xFFFFFFB3451. That looks like the
> timekeeping on your box is screwed by 0x100000000000. 
> 
> John, any idea ?
> 
> 	tglx
> 
With the following patch:

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -426,6 +426,7 @@ hrtimer_start(struct hrtimer *timer, kti
 	struct hrtimer_base *base, *new_base;
 	unsigned long flags;
 	int ret;
+	ktime_t save = tim;
 
 	base = lock_hrtimer_base(timer, &flags);
 
@@ -436,7 +437,18 @@ hrtimer_start(struct hrtimer *timer, kti
 	new_base = switch_hrtimer_base(timer, base);
 
 	if (mode == HRTIMER_REL) {
-		tim = ktime_add(tim, new_base->get_time());
+		ktime_t curr = new_base->get_time();
+		tim = ktime_add(tim, curr);
+		if(save.tv64 == 0) {
+			char comm[TASK_COMM_LEN];
+			ktime_t diff = ktime_sub(new_base->get_time(), tim);
+			ktime_t diff2 = ktime_sub(curr, tim);
+			if (diff.tv64 < 0) {
+				get_task_comm(comm, current);
+				printk("%s: index %d empty nanosleep %lld 0x%llx 0x%llx\n", comm, new_base->index, diff.tv64, tim.tv64, curr.tv64);
+				printk("%s: %lld\n", comm, diff2.tv64);
+			}
+		}
 		/*
 		 * CONFIG_TIME_LOW_RES is a temporary way for architectures
 		 * to signal that they simply return xtime in

I get this debug info:
[ 7078.568000] urxvtd: index 1 empty nanosleep -3994384 0x670370f0183 0x670370f0183
[ 7078.568000] urxvtd: 0
[ 7969.696000] urxvtd: index 1 empty nanosleep -3994384 0x73fb5bf0b55 0x73fb5bf0b55
[ 7969.696000] urxvtd: 0
[ 8323.276000] urxvtd: index 1 empty nanosleep -3994383 0x7920a12d47a 0x7920a12d47a
[ 8323.276000] urxvtd: 0
[ 8937.072000] urxvtd: index 1 empty nanosleep -3995221 0x820f573e204 0x820f573e204
[ 8937.072000] urxvtd: 0
[ 8966.216000] urxvtd: index 1 empty nanosleep -3995222 0x827beaddd13 0x827beaddd13
[ 8966.216000] urxvtd: 0
[ 9170.380000] urxvtd: index 1 empty nanosleep -3995221 0x857488ff0fa 0x857488ff0fa
[ 9170.380000] urxvtd: 0
[ 9179.752000] urxvtd: index 1 empty nanosleep -3995221 0x85977363cca 0x85977363cca
[ 9179.752000] urxvtd: 0
[ 9272.320000] urxvtd: index 1 empty nanosleep -3994384 0x86f050a277f 0x86f050a277f
[ 9272.320000] urxvtd: 0
[ 9452.596000] urxvtd: index 1 empty nanosleep -3995221 0x898feff7f5e 0x898feff7f5e
[ 9452.596000] urxvtd: 0
[10783.932000] urxvtd: index 1 empty nanosleep -3994383 0x9cefdc45406 0x9cefdc45406
[10783.932000] urxvtd: 0
[11277.380000] urxvtd: index 1 empty nanosleep -17592185627881 0x1a41e328e9ab 0x1a41e328e9ab
[11277.380000] urxvtd: 0

regards,

Benoit

(Now I'll try the patch from John Stultz)
