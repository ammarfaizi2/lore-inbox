Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291880AbSBARt5>; Fri, 1 Feb 2002 12:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291882AbSBARtr>; Fri, 1 Feb 2002 12:49:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11475 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291880AbSBARth>;
	Fri, 1 Feb 2002 12:49:37 -0500
Message-ID: <3C5AD522.1070808@us.ibm.com>
Date: Fri, 01 Feb 2002 09:49:22 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
In-Reply-To: <20020201163818.A32551@caldera.de> <3C5ACE88.1050002@us.ibm.com> <20020201182354.A7740@caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Feb 01, 2002 at 09:21:12AM -0800, Dave Hansen wrote:
>>Things like nfsd are always holding the BKL, only 
>>releasing it on schedule(), and exit.  Is there any compelling reason to 
>>hold the BKL during times other than during the daemonize() process?
>
> In general there is no reason.  If the data the thread accesses is not
> protected by anything but BKL it must hold it - else it seems superflous
> to me.
What do you think about the BKL hold during daemonize()?  Can we expand 
the use of the task lock to keep the BKL from being held?

/* these all use task_lock(): */
         exit_mm(current);
         exit_fs(current);
         exit_files(current);

/* Is there more locking needed for this? */
         current->session = 1;
         current->pgrp = 1;
         current->tty = NULL;
         fs = init_task.fs;
         current->fs = fs;

/* This is already safe: */
         atomic_inc(&fs->count);
         current->files = init_task.files;
         atomic_inc(&current->files->count);


-- 
Dave Hansen
haveblue@us.ibm.com

