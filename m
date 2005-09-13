Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbVIMNM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbVIMNM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 09:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVIMNM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 09:12:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41391 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932647AbVIMNM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 09:12:28 -0400
Message-ID: <4326CFE2.6000908@in.ibm.com>
Date: Tue, 13 Sep 2005 08:10:58 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, patrics@interia.pl,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org>
In-Reply-To: <20050912134954.7bbd15b2.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Andrew Morton wrote:
> Sripathi Kodi <sripathik@in.ibm.com> wrote:
> 
>>Hi,
>>
>>When the main thread of a multi-threaded program calls 'pthread_exit' before
>>other threads have exited, it results in the other threads becoming
>>'invisible' to commands like 'ps'.
> 
> 
> This stuff is subtle.   Let me cc some subtle people.
> 
> 
>>Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
>>
>>--- linux-2.6.13.1/kernel/exit.c	2005-09-12 02:46:26.000000000 -0500
>>+++ /home/sripathi/17794/patch_2.6.13.1/exit.c	2005-09-12 02:46:15.000000000 
>>-0500
>>@@ -463,9 +463,11 @@ static inline void __exit_fs(struct task
>>  	struct fs_struct * fs = tsk->fs;
>>
>>  	if (fs) {
>>-		task_lock(tsk);
>>-		tsk->fs = NULL;
>>-		task_unlock(tsk);
>>+		if (!thread_group_leader(tsk) || !atomic_read(&tsk->signal->live)) {
>>+			task_lock(tsk);
>>+			tsk->fs = NULL;
>>+			task_unlock(tsk);
>>+		}
>>  		__put_fs_struct(fs);
>>  	}
>>  }
> 
> 
> A comment in there would be nice.
> 

Below is the patch with a comment.

Thanks and regards,
Sripathi.

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.13.1/kernel/exit.c	2005-09-13 15:39:48.738542872 -0500
+++ /home/sripathi/17794/patch_2.6.13.1/exit.c	2005-09-13 15:39:27.367791720 
-0500
@@ -463,9 +463,13 @@ static inline void __exit_fs(struct task
  	struct fs_struct * fs = tsk->fs;

  	if (fs) {
-		task_lock(tsk);
-		tsk->fs = NULL;
-		task_unlock(tsk);
+		/* If tsk is thread group leader and if group still has alive
+		 * threads, those threads may use tsk->fs */
+		if (!thread_group_leader(tsk) || !atomic_read(&tsk->signal->live)) {
+			task_lock(tsk);
+			tsk->fs = NULL;
+			task_unlock(tsk);
+		}
  		__put_fs_struct(fs);
  	}
  }
