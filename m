Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUIBIcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUIBIcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUIBIcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:32:02 -0400
Received: from imo-m24.mx.aol.com ([64.12.137.5]:20873 "EHLO
	imo-m24.mx.aol.com") by vger.kernel.org with ESMTP id S267859AbUIBIb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:31:57 -0400
From: JobHunts02@aol.com
Message-ID: <1a9.284c240d.2e683477@aol.com>
Date: Thu, 2 Sep 2004 04:31:51 EDT
Subject: Sending siginfo from kernel to user space
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 5.0 for Mac sub 11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending a signal from kernel space to user space with Linux 2.4.20-8.  



In user space, I have installed a signal handler:


    saio.sa_handler = signal_handler_IO;

    sigemptyset(&saio.sa_mask);

    saio.sa_flags = SA_SIGINFO;

    saio.sa_restorer = NULL;

    sigaction(SA_SIGINFO, &saio, NULL);



In kernel space:


    info.si_errno = 1212;

    info.si_code  = SI_KERNEL;

    send_sig_info(SA_SIGINFO, &info, find_task_by_pid(pid));



This results in the signal handler, 


    void signal_handler_IO (int status, struct siginfo *info, void *p) 


being called in user space, which gives the following values in info:


    info->si_signo = 4  /* corresponds to SA_SIGINFO */

    info->si_errno = 0  /* expect 1212               */

    info->si_code  = 0  /* expect SI_KERNEL (128)    */ 

 


Note that the values I put in si_errno and si_code do not get passed to the 
user.  si_signo has the correct value, but the user can know this from the 
original sigaction call.



If instead, I call send_sig_info(SA_SIGINFO, (struct siginfo*)0, 
find_task_by_pid(pid)), as expected I get:


    info->si_signo = 4  

    info->si_errno = 0

    info->si_code  = 0  /* corresponds to SI_USER, as expected */



If I call send_sig_info(SA_SIGINFO, (struct siginfo*)1, 
find_task_by_pid(pid)), as expected I get:


    info->si_signo = 4  

    info->si_errno = 0

    info->si_code  = 128    /* corresponds to SI_KERNEL, as expected */



Apparently, there is a problem copying the info structure.  I need to pass 
info to the kernel.  Any ideas?



Thank you.


