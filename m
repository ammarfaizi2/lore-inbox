Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135242AbREAObH>; Tue, 1 May 2001 10:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbREAOa6>; Tue, 1 May 2001 10:30:58 -0400
Received: from [32.97.182.101] ([32.97.182.101]:30101 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135996AbREAOar>;
	Tue, 1 May 2001 10:30:47 -0400
Message-ID: <3AEEC880.304F4B75@vnet.ibm.com>
Date: Tue, 01 May 2001 09:30:24 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP races in proc with thread_struct
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps this is old news...but...

I can easily create a race when reading /proc/<pid>/stat
(fs/proc/{base.c,array.c}) where a rapidly reading application, such as
"top", starts reading stats for a thread which goes away during the
read.  This is easily reproduced with a program that rapidly forks and
exits while top is running.

On inspection, I don't see how the code can expect the thread_struct to
stay around since it is not holding any lock for the duration of its
use.  The code could hold the thread_struct's lock (after verifying it
still exists while holding tasklist_lock I would imagine), but for
performance I would think a better solution would be to copy the struct
since stale data is probably ok in this case.

Dereferencing a non-existent thread_struct is clearly not ok.

Would anyone familiar with this code care to comment?
-- 
-todd
