Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTKJNOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTKJNOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:14:11 -0500
Received: from cm6.gamma186.maxonline.com.sg ([202.156.186.6]:11145 "EHLO
	plethora.anomalistic.org") by vger.kernel.org with ESMTP
	id S263491AbTKJNOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:14:04 -0500
Date: Mon, 10 Nov 2003 21:14:55 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'flushing' printk to klogd
Message-ID: <20031110131455.GA5649@despammed.com>
Reply-To: Eugene Teo <eugeneteo@despammed.com>
References: <20031109160945.GA491@despammed.com> <010b01c3a75f$4514f940$0a01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010b01c3a75f$4514f940$0a01a8c0@CARTMAN>
X-Operating-System: Linux 2.4.22
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amir,

No, I don't think flush_printk_to_syslog exists but relevant
code in do_syslog can form our flush_printk_to_syslog().

In do_syslog, we can find the code to read the ring buffer:

232         while (!error && (log_start != log_end) && i < len) {
233             c = LOG_BUF(log_start);
234             log_start++;
235             spin_unlock_irq(&logbuf_lock);
236             error = __put_user(c,buf);
237             buf++;
238             i++;
239             spin_lock_irq(&logbuf_lock);
240         }

One way we can do is to add case 10 to do_syslog's switch, so that
we can call do_syslog(10, buf, count) when we want to flush the
printk to a log. 

We have to find a way to perform what is required in case 3, and in
our case, after we read the messages from the ring buffer, we want to 
flush it, so we do a logged_chars = 0; in the end.

But take note that __put_user() could sleep. Our messages could be
overwritten by other printks. 

If you are free, can you code it, and mail me the patch? I would have
coded it if not for my exams. Thanks.

Eugene

<quote sender="Amir Hermelin">
> Thanks Eugene
> 
> I've already changed the buf len (in my development version).  However, what
> I really need is a way to flush the buffer before going into either heavy
> log sections or, more importantly, fragile code sections.  So, if I'm in a
> procedure that is safe to sleep, I can do the following:
> 
> int proc_ok_to_sleep()
> {
> 	printk("these are the args we got" ....);
> 	flush_printk_to_syslog();
> 	/* Here starts the critical section, possibly will cause kernel
> panic */
> 	....
> }
> 
> Does a function such as the flush_printk_to_syslog() exists?
> 
> Thanks,
> Amir.
> 
> -----Original Message-----
> From: Eugene Teo [mailto:eugene.teo@eugeneteo.net] 
> Sent: Sunday, November 09, 2003 6:10 PM
> To: Amir Hermelin
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 'flushing' printk to klogd
> 
> 
> You can configure your syslog to output the messages to
> a dedicated file. Also, you can increase the length
> of your buffer:
> 
> 352  #define LOG_BUF_LEN    (131072)
> 353  #elif defined(CONFIG_SMP)
> 354  #define LOG_BUF_LEN    (32768)
> 355 +#elif defined(CONFIG_VMSTAT_PFAULTS)
> 356 +#define LOG_BUF_LEN (1048576)
> 357  #else  
> 358  #define LOG_BUF_LEN    (16384) /* This must be a power of two */
> 359  #endif
> 
> Note that even if you flush printk output before the circular buffer wraps,
> you will still likely to lose some output since it doesn't take care of
> multiple writes at the same time.
> 
> Eugene
> 
> <quote sender="Amir Hermelin">
> > Hi,
> > Is there any way to make sure klogd flushes printk output to 
> > /var/log/messages before the circular buffer wraps?  I intend to use 
> > this only during the development phase, but I find that during 
> > 'activity storms' where lots of printk's are involved I lose some of 
> > the output.
> > 
> > Thanks,
> > Amir.
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

