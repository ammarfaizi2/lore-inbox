Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTKVAFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 19:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTKVAFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 19:05:22 -0500
Received: from nico.bway.net ([216.220.96.3]:45272 "EHLO nico.bway.net")
	by vger.kernel.org with ESMTP id S261735AbTKVAFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 19:05:16 -0500
Message-ID: <3FBEA83B.1060001@bangstate.com>
Date: Fri, 21 Nov 2003 19:05:15 -0500
From: Michael Welles <mike@bangstate.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030807
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Using get_cwd inside a module.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies in advance for a lengthy and probably stupid question.

I'm one of the authors of changedfiles (http://changedfiles.org), a 
GPL'd application that monitors file operations and allows user 
configurable actions to take place in userspace when any defined rules 
are matched.  Currently we work w/ 2.2.x and 2.4.x kernel series, but 
this question mostly concerns 2.4.x.

When doing the initial development of the kernel module component of the 
system, I needed getcwd() in kernel space.    Being lazy, and frankly 
terrified to be working in kernel space, I ended up cutting and pasting 
getcwd() from dcache.c and using the locally defined version in the module.

This worked great for a couple of years, but recently when my debian 
testing box starting using gcc 3.3 (I think this is the cause -- it's 
just about the only thing that changed), I started getting NULL pointer 
drefs inside the copied code.

I figured it was high time I stoppied using cut n' paste code.  Instead 
I thought I'd use sys_call_table[__NR_getcwd] instead -- since I could 
run pwd in a shell without any kernel panics, I figured it must be 
working OK.

My powers of grep were sorely lacking, though, and I couldn't find 
anywhere in the source where the function was assigned.  In a bit of 
desperation, I guessed that somewhere, somehow, the getcwd() in dcache 
was being assigned, so I used that function prototype:

    int (*getcwd)(char *buf, unsigned long size);
    getcwd = (int (*)(char * , unsigned long 
))(sys_call_table[__NR_getcwd]);

and use it as I used to:

         len = getcwd(fullnewname, MAX_PATH);


Everything built just fine, but whenever I load the module and the above 
statement runs,  the function returns -14.   This is true on my debian 
testing box, and also on my YDL 3.0 machine, where the old version (with 
the cut n' paste code) still runs just fine.

I'm not sure what to try next.  What am I doing wrong? 


Thanks,

Michael Welles


