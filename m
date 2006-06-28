Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423306AbWF1MJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423306AbWF1MJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423307AbWF1MJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:09:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423306AbWF1MJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:09:12 -0400
Date: Wed, 28 Jun 2006 05:09:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm3 - mutex warning in usbhid, battery problem, and slab
 corruption
Message-Id: <20060628050906.b7841f30.akpm@osdl.org>
In-Reply-To: <200606281403.33190.rjw@sisk.pl>
References: <20060627015211.ce480da6.akpm@osdl.org>
	<200606281403.33190.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 14:03:33 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday 27 June 2006 10:52, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/
> 
> I have three problems with this kernel.
> 
> First, there's a mutex lock warning as in the appended trace and my USB
> mouse doesn't work.
> 
> Second, kpowersave is apparently unable to get the battery status,
> although the data in /proc/acpi/battery/BAT0/ seem to be correct
> (this also happened with 2.6.17-mm2, but it did not happen with
> 2.6.17-rc6-mm2).
> 
> Finally, I'm still seeing slab corruptions in dmesg (eg. at the end of the
> appended trace).
> 
> Greetings,
> Rafael
> 
> 
>   usbdev2.4_ep81: ep_device_release called for usbdev2.4_ep81
>  BUG: warning at kernel/mutex.c:132/__mutex_lock_common()
>  
>  Call Trace:
>   [<ffffffff8020ab6f>] show_trace+0x9f/0x240
>   [<ffffffff8020af45>] dump_stack+0x15/0x20
>   [<ffffffff8047296b>] __mutex_lock_slowpath+0xab/0x280
>   [<ffffffff80472b49>] mutex_lock+0x9/0x10
>   [<ffffffff803ed909>] input_unregister_device+0x109/0x160
>   [<ffffffff88157ab2>] :usbhid:hidinput_disconnect+0x72/0xa0
>   [<ffffffff88153d3d>] :usbhid:hid_disconnect+0x9d/0x110
>   [<ffffffff803dd85b>] usb_unbind_interface+0x5b/0xb0
>   [<ffffffff803bb03d>] __device_release_driver+0x8d/0xb0
>   [<ffffffff803bb324>] device_release_driver+0x34/0x50
>   [<ffffffff803ba6af>] bus_remove_device+0xaf/0xe0
>   [<ffffffff803b9067>] device_del+0x157/0x1a0
>   [<ffffffff803dc548>] usb_disable_device+0x108/0x1a0
>   [<ffffffff803d44e2>] usb_disconnect+0xd2/0x150
>   [<ffffffff803d7c0f>] hub_thread+0x63f/0xff0
>   [<ffffffff802435c9>] kthread+0xd9/0x110
>   [<ffffffff8020a34a>] child_rip+0x8/0x12

I assume that is the second warning here:

#define spin_lock_mutex(lock, flags)			\
	do {						\
		struct mutex *l = container_of(lock, struct mutex, wait_lock); \
							\
		DEBUG_LOCKS_WARN_ON(in_interrupt());	\
		local_irq_save(flags);			\
		__raw_spin_lock(&(lock)->raw_lock);	\
		DEBUG_LOCKS_WARN_ON(l->magic != l);	\
	} while (0)

(it's a bit awkward that both warnings are at the same line number).

This looks like the bug which Linus has been chasing.  iirc, that's
half-fixed now.

>   <3>Slab corruption: start=ffff810057d41000, len=4096
>  7e0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 6b 6b 6b 6b
>  8a0: 6b 6b 6b 6b 6b 6b 6b 6b 58 3b e8 37 00 81 ff ff

This might fix, not sure..

--- a/lib/vsprintf.c~vsnprintf-fix
+++ a/lib/vsprintf.c
@@ -259,7 +259,9 @@ int vsnprintf(char *buf, size_t size, co
 	int len;
 	unsigned long long num;
 	int i, base;
-	char *str, *end, c;
+	char *str;		/* Where we're writing to */
+	char *end;		/* The last byte we can write to */
+	char c;
 	const char *s;
 
 	int flags;		/* flags to number() */
@@ -283,12 +285,12 @@ int vsnprintf(char *buf, size_t size, co
 	}
 
 	str = buf;
-	end = buf + size;
+	end = buf + size - 1;
 
 	/* Make sure end is always >= buf */
-	if (end < buf) {
+	if (end < buf - 1) {
 		end = ((void *)-1);
-		size = end - buf;
+		size = end - buf + 1;
 	}
 
 	for (; *fmt ; ++fmt) {
@@ -494,7 +496,6 @@ int vsnprintf(char *buf, size_t size, co
 	/* the trailing null byte doesn't count towards the total */
 	return str-buf;
 }
-
 EXPORT_SYMBOL(vsnprintf);
 
 /**
_

