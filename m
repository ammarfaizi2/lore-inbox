Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311836AbSCNWwS>; Thu, 14 Mar 2002 17:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311845AbSCNWwI>; Thu, 14 Mar 2002 17:52:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311836AbSCNWvz>;
	Thu, 14 Mar 2002 17:51:55 -0500
Message-ID: <3C912977.2030604@mandrakesoft.com>
Date: Thu, 14 Mar 2002 17:51:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Juan Quintela <quintela@mandrakesoft.com>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, Andrew Morton <akpm@zip.com.au>,
        kernel <kernel@linux-mandrake.com>, linux-kernel@vger.kernel.org,
        dhinds@sonic.net
Subject: Re: pcmcia oops (with ksymoops output this time)
In-Reply-To: <m2henircqz.fsf@trasno.mitica>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With oops tracing in IRC, we narrowed the problem in 2.4.x down to, 
serial_cs and ide_cs drivers, and other 16-bit pcmcia drivers possibly, 
call their release functions from a timer when ejected.  The 
per-subsystem release functions then proceed to do all manner of 
in-process-context type work, including calling devfs_unregister, whose 
call path can eventually cause a schedule()

Suggested fix, call schedule_task() in each timer-based release 
function, to queue a task in process context to do the actual work. 
 This is how 32-bit cardbus gets such things done...

    Jeff





