Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTKJHuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 02:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTKJHuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 02:50:21 -0500
Received: from sphere.barak.net.il ([212.150.48.98]:960 "EHLO
	sphere.barak.net.il") by vger.kernel.org with ESMTP id S263007AbTKJHuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 02:50:14 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: "'Eugene Teo'" <eugeneteo@despammed.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 'flushing' printk to klogd
Date: Mon, 10 Nov 2003 09:50:06 +0200
Organization: Montilio
Message-ID: <010b01c3a75f$4514f940$0a01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20031109160945.GA491@despammed.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Eugene

I've already changed the buf len (in my development version).  However, what
I really need is a way to flush the buffer before going into either heavy
log sections or, more importantly, fragile code sections.  So, if I'm in a
procedure that is safe to sleep, I can do the following:

int proc_ok_to_sleep()
{
	printk("these are the args we got" ....);
	flush_printk_to_syslog();
	/* Here starts the critical section, possibly will cause kernel
panic */
	....
}

Does a function such as the flush_printk_to_syslog() exists?

Thanks,
Amir.

-----Original Message-----
From: Eugene Teo [mailto:eugene.teo@eugeneteo.net] 
Sent: Sunday, November 09, 2003 6:10 PM
To: Amir Hermelin
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'flushing' printk to klogd


You can configure your syslog to output the messages to
a dedicated file. Also, you can increase the length
of your buffer:

352  #define LOG_BUF_LEN    (131072)
353  #elif defined(CONFIG_SMP)
354  #define LOG_BUF_LEN    (32768)
355 +#elif defined(CONFIG_VMSTAT_PFAULTS)
356 +#define LOG_BUF_LEN (1048576)
357  #else  
358  #define LOG_BUF_LEN    (16384) /* This must be a power of two */
359  #endif

Note that even if you flush printk output before the circular buffer wraps,
you will still likely to lose some output since it doesn't take care of
multiple writes at the same time.

Eugene

<quote sender="Amir Hermelin">
> Hi,
> Is there any way to make sure klogd flushes printk output to 
> /var/log/messages before the circular buffer wraps?  I intend to use 
> this only during the development phase, but I find that during 
> 'activity storms' where lots of printk's are involved I lose some of 
> the output.
> 
> Thanks,
> Amir.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



