Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311909AbSCOCPG>; Thu, 14 Mar 2002 21:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311910AbSCOCO5>; Thu, 14 Mar 2002 21:14:57 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:22754 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S311909AbSCOCOi> convert rfc822-to-8bit;
	Thu, 14 Mar 2002 21:14:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18y
Date: Thu, 14 Mar 2002 18:14:23 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE3A2037@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18y
Thread-Index: AcHLwcsbKMX8+k2uS3aiW9hADlwLcQAAEsBw
From: <Tony.P.Lee@nokia.com>
To: <alan@lxorguk.ukuu.org.uk>, <kessler@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Mar 2002 02:14:24.0605 (UTC) FILETIME=[206D50D0:01C1CBC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: ext Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Thursday, March 14, 2002 5:49 PM
> To: Larry Kessler

> > I am absolutely open to suggestions for making printk 
> messages better
> 
> However that doesn't work for varargs. Nevertheless something 
> of a similar
> approach might let you avoid breaking printk in most old 
> code. If you can
> avoid a grand replacement of printk you win lots of friends. 
> If you can
> do it in a way that people can do automated parsing of kernel messages
> for translation tables in klogd/initlog/dmesg you also win 
> lots of friends.
> 


How about this?

int printk_improve(const char* filename, int line_no, 
	const char* function_name, int module_buf_idx, ...);

#define printk(PRINTF_ARGS...) \
	printk_improve(__FILE__, __LINE__, __FUNCTION__, \
		CUR_MODULE_BUF_IDX, ##PRINTF_ARGS);


1) If anyone is going to add this to the kernel, please make sure
printk_improve also log the TSC, current_process_id (if avail), etc.  
Very useful for performance profiling and failure analysis.

2) The next imporvement is to able to log to different buffers as 
suggested, such as ethernet driver logging goes to its own buffer, 
filesystem goes to its own buffer.  

2a) If you implement logging to multiple buffers, you need to 
make sure there is a global counter that atomically increment 
for all the events regardles which buffer it goes to.   

I used it in our project (RTOS, non-linux, yet...).  
It is very powerful to debug any SMP bugs caused by timing and 
race condition.

3) After that you need to get special BIOS so that we can log the 
buffer to a section of memory that is preserved after reset.   
With this, you can easily postmortem diagnostic any problem that 
crash the kernel/ISR/Driver.   This is much easily to do in 
embedded projects as compare to PC, since we control the BIOS.


Did all these in few of my projects already, it is wonderful 
way to debug any "completely lockup" problem with RTOS/ISR/Kernel.
The nice thing is that I don't have to ask anyone to reproduce
the problems.  The logging is always on.

----------------------------------------------------------------
Tony Lee           Nokia Networks, Inc. 
p.s.  Looking for linux kernel module engineers to work on 
system with 40 pentium CPUs. 24 of which are P4 SMP running linux.
Email me if interested.



