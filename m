Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVA0QYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVA0QYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVA0QYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:24:34 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:11503 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262570AbVA0QYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:24:19 -0500
Message-ID: <41F931CD.5030401@tiscali.de>
Date: Thu, 27 Jan 2005 18:24:13 +0000
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Steve Lord <lord@xfs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org> <20050127154017.GA12493@taniwha.stupidest.org> <41F9290E.1050209@tiscali.de> <20050127155338.GB12493@taniwha.stupidest.org>
In-Reply-To: <20050127155338.GB12493@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Thu, Jan 27, 2005 at 05:46:54PM +0000, Matthias-Christian Ott wrote:
>
>  
>
>>How did you fix it?
>>    
>>
>
>I suggested:
>
>===== fs/xfs/linux-2.6/xfs_stats.h 1.9 vs edited =====
>Index: cw-current/fs/xfs/linux-2.6/xfs_stats.h
>===================================================================
>--- cw-current.orig/fs/xfs/linux-2.6/xfs_stats.h	2005-01-17 16:03:59.656946818 -0800
>+++ cw-current/fs/xfs/linux-2.6/xfs_stats.h	2005-01-17 16:06:50.692361597 -0800
>@@ -142,9 +142,9 @@
> 
> /* We don't disable preempt, not too worried about poking the
>  * wrong cpu's stat for now */
>-#define XFS_STATS_INC(count)		(__get_cpu_var(xfsstats).count++)
>-#define XFS_STATS_DEC(count)		(__get_cpu_var(xfsstats).count--)
>-#define XFS_STATS_ADD(count, inc)	(__get_cpu_var(xfsstats).count += (inc))
>+#define XFS_STATS_INC(count)		(per_cpu(xfsstats, __smp_processor_id()).count++)
>+#define XFS_STATS_DEC(count)		(per_cpu(xfsstats, __smp_processor_id()).count--)
>+#define XFS_STATS_ADD(count, inc)	(per_cpu(xfsstats, __smp_processor_id()).count += (inc))
> 
> extern void xfs_init_procfs(void);
> extern void xfs_cleanup_procfs(void);
>
>but what was checked in was a bit cleaner.
>
>  
>
Well calling such a internal function (__function) is not a cleaning 
coding style but works best :-) .
Combined with the current_cpu() fixes I mentioned, it looks like this:

diff -Nru linux-2.6.11-rc2/fs/xfs/linux-2.6/xfs_linux.h 
linux-2.6.11-rc2-ott/fs/xfs/linux-2.6/xfs_linux.h
--- linux-2.6.11-rc2/fs/xfs/linux-2.6/xfs_linux.h    2004-12-24 
21:35:50.000000000 +0000
+++ linux-2.6.11-rc2-ott/fs/xfs/linux-2.6/xfs_linux.h    2005-01-27 
18:13:09.000000000 +0000
@@ -144,7 +144,7 @@
 #define xfs_inherit_nosymlinks    xfs_params.inherit_nosym.val
 #define xfs_rotorstep        xfs_params.rotorstep.val
 
-#define current_cpu()        smp_processor_id()
+#define current_cpu()        __smp_processor_id()
 #define current_pid()        (current->pid)
 #define current_fsuid(cred)    (current->fsuid)
 #define current_fsgid(cred)    (current->fsgid)
diff -Nru linux-2.6.11-rc2/fs/xfs/linux-2.6/xfs_stats.h 
linux-2.6.11-rc2-ott/fs/xfs/linux-2.6/xfs_stats.h
--- linux-2.6.11-rc2/fs/xfs/linux-2.6/xfs_stats.h    2004-12-24 
21:34:29.000000000 +0000
+++ linux-2.6.11-rc2-ott/fs/xfs/linux-2.6/xfs_stats.h    2005-01-27 
18:13:44.000000000 +0000
@@ -142,9 +142,9 @@
 
 /* We don't disable preempt, not too worried about poking the
  * wrong cpu's stat for now */
-#define XFS_STATS_INC(count)        (__get_cpu_var(xfsstats).count++)
-#define XFS_STATS_DEC(count)        (__get_cpu_var(xfsstats).count--)
-#define XFS_STATS_ADD(count, inc)    (__get_cpu_var(xfsstats).count += 
(inc))
+#define XFS_STATS_INC(count)        (per_cpu(xfsstats, 
__smp_processor_id()).count++)
+#define XFS_STATS_DEC(count)        (per_cpu(xfsstats, 
__smp_processor_id()).count--)
+#define XFS_STATS_ADD(count, inc)    (per_cpu(xfsstats, 
__smp_processor_id()).count += (inc))
 
 extern void xfs_init_procfs(void);
 extern void xfs_cleanup_procfs(void);

I'll submit it to the mailinglist as a seperate patch, so Linus can 
apply it to the current Kernel.

Matthias-Christian Ott

-- 
http://unixforge.org/~matthias-christian-ott/

