Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTLPAUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTLPAUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:20:42 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:42719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264305AbTLPAUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:20:24 -0500
From: Hans Reiser <reiser@bitshadow.namesys.com>
To: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>, <linux-kernel@vger.kernel.org>,
       mason@suse.com
Subject: Re: Kernel Bug in Journal.c
Date: Tue, 16 Dec 2003 03:20:22 +0300
User-Agent: KMail/1.5.4
References: <AJENJFOLCLAHHIIGCCHNEEAJMIAA.admin@wolfpaw.net>
In-Reply-To: <AJENJFOLCLAHHIIGCCHNEEAJMIAA.admin@wolfpaw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312160320.22508.reiser@bitshadow.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks kindly for this report, Chris can you take a look at this?

Hans

On Monday 15 December 2003 23:30, Wolfpaw - Dale Corse wrote:
> Greetings,
>
>  We are getting this error using 2.4.23 on reiserfs, with the
> reiser quota patches, and grsecurity patches. I have no idea
> what it is :(
>
> kernel BUG at journal.c:869!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c02401c7>]    Not tainted
> EFLAGS: 00010246
> eax: 00000000   ebx: 0161e62c   ecx: df41c540   edx: de195480
> esi: de195480   edi: 0161e62c   ebp: dfe27000   esp: c15bddfc
> ds: 0018   es: 0018   ss: 0018
> Process kupdated (pid: 6, stackpage=c15bd000)
> Stack: c0353330 c01d60a2 c010cb80 de195280 de195280 00000012 dfe27000
> c023fc62
>        dfe27000 00000000 00000000 00000004 dfe27000 0161e62c 00000002
> c0244723
>        dfe27000 de195480 00000001 de195298 de195480 00000004 00000002
> 00000000
> Call Trace:    [<c01d60a2>] [<c023fc62>] [<c0244723>] [<c02450f6>]
> [<c02d40b3>]
>   [<c02438db>] [<c019dd36>] [<c024444a>] [<c0230caf>] [<c01da2db>]
> [<c01d974c>]
>   [<c01d9a9e>] [<c019dd36>] [<c019f626>] [<c01d9990>] [<c019d9ae>]
> [<c01d9990>]
>
> Code: 0f 0b 65 03 99 29 35 c0 eb e4 8b 85 f8 00 00 00 3b 58 20 0f
>
> It also causes kupdated to go defunct, and we lose the ability to use
> sync,
> or unmount a filesystem. (Reboot must be done with the reset switch
>
> :()
>
> If anyone has any ideas, please drop me a line. I am not subscribed,
> so
> please CC responses to admin@wolfpaw.net
>
> Thanks in advance for your time,
> Dale.
>
> The offending block of code is:
>
> static int flush_commit_list(struct super_block *s, struct
> reiserfs_journal_list *jl, int flushall) {
>   int i, count ;
>   int bn ;
>   int retry_count = 0 ;
>   int orig_commit_left = 0 ;
>   struct buffer_head *tbh = NULL ;
>   unsigned long trans_id = jl->j_trans_id;
>
>   reiserfs_check_lock_depth("flush_commit_list") ;
>
>   if (atomic_read(&jl->j_older_commits_done)) {
>     if (!list_empty(&jl->j_ordered_bh_list))
>         BUG();
>     if (!list_empty(&jl->j_tail_bh_list))
>         BUG();
>     return 0 ;
>   }
>
>   /* before we can put our commit blocks on disk, we have to make sure
> everyone older than
>   ** us is on disk too
>   */
>   if (jl->j_len <= 0) {
> -->  BUG();
>     return 0 ;
>   }
>   if (trans_id == SB_JOURNAL(s)->j_trans_id)
>       BUG();
>
>   get_journal_list(jl);
>
>   /* write any buffers that must hit disk before the commit is done */
>   write_ordered_buffers(&jl->j_ordered_bh_list, &jl->j_wait_bh_list);
>
>   if (flushall) {
>     if (flush_older_commits(s, jl) == 1) {
>         /* list disappeared during flush_older_commits.  return */
>         goto put_jl;
>     }
>   }
>
> --------------------------------
> Dale Corse
> System Administrator
> Wolfpaw Services Inc.
> http://www.wolfpaw.net
> (780) 474-4095
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

