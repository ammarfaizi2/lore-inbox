Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWACXIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWACXIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWACXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:08:05 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:24470 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964859AbWACXHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:07:20 -0500
Message-ID: <43BB03A7.3090604@cosmosbay.com>
Date: Wed, 04 Jan 2006 00:07:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets
 on the stack
References: <200601032158.14057.ak@suse.de> <43BAF72C.2030608@cosmosbay.com>
In-Reply-To: <43BAF72C.2030608@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------090603000108000005080004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090603000108000005080004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Eric Dumazet a écrit :
> Andi Kleen a écrit :
>> This is a RFC for now. I would be interested in testing
>> feedback. Patch is for 2.6.15.
>>
>> Optimize select and poll by a using stack space for small fd sets
>>
>> This brings back an old optimization from Linux 2.0. Using
>> the stack is faster than kmalloc. On a Intel P4 system
>> it speeds up a select of a single pty fd by about 13%
>> (~4000 cycles -> ~3500)
> 
> Was this result on UP or SMP kernel ? Preempt or not ?
> 
> I think we might play in do_pollfd() and use fget_light()/fput_light() 
> instead of fget()/fput() that are somewhat expensive because of atomic 
> inc/dec on SMP.
> 

Just for completeness I include this patch against 2.6.15



--------------090603000108000005080004
Content-Type: text/plain;
 name="select_fget_light.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="select_fget_light.patch"

--- linux-2.6.15/fs/select.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ed/fs/select.c	2006-01-04 00:04:10.000000000 +0100
@@ -221,17 +221,18 @@
 			}
 
 			for (j = 0; j < __NFDBITS; ++j, ++i, bit <<= 1) {
+				int fput_needed;
 				if (i >= n)
 					break;
 				if (!(bit & all_bits))
 					continue;
-				file = fget(i);
+				file = fget_light(i, &fput_needed);
 				if (file) {
 					f_op = file->f_op;
 					mask = DEFAULT_POLLMASK;
 					if (f_op && f_op->poll)
 						mask = (*f_op->poll)(file, retval ? NULL : wait);
-					fput(file);
+					fput_light(file, fput_needed);
 					if ((mask & POLLIN_SET) && (in & bit)) {
 						res_in |= bit;
 						retval++;
@@ -417,14 +418,15 @@
 		fdp = fdpage+i;
 		fd = fdp->fd;
 		if (fd >= 0) {
-			struct file * file = fget(fd);
+			int fput_needed;
+			struct file * file = fget_light(fd, &fput_needed);
 			mask = POLLNVAL;
 			if (file != NULL) {
 				mask = DEFAULT_POLLMASK;
 				if (file->f_op && file->f_op->poll)
 					mask = file->f_op->poll(file, *pwait);
 				mask &= fdp->events | POLLERR | POLLHUP;
-				fput(file);
+				fput_light(file, fput_needed);
 			}
 			if (mask) {
 				*pwait = NULL;

--------------090603000108000005080004--
