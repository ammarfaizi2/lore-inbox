Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTE0OBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTE0OBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:01:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:56917 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263628AbTE0OBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:01:47 -0400
Message-ID: <3ED372DB.1030907@gmx.net>
Date: Tue, 27 May 2003 16:14:51 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian,

this looks supiciously like the problem you are experiencing since
2.4.19-pre. Maybe we can fix this for good.

Marcelo Tosatti wrote:
> 
> On Mon, 26 May 2003, manish wrote:
> 
> 
>>Hello !
>>
>>I am running the 2.4.20 kernel on a system with 3.5 GB RAM and dual CPU.
>>I am running bonnie accross four drives in parallel:
>>
>>bonnie -s 1000 -d /<dir-name>
>>
>>bdflush settings on this system:
>>
>>[root@dyn-10-123-130-235 vm]# cat bdflush
>>2       50      32      100     50      300     1       0       0
>>
>>All the bonnie process and any other process (like df, ps -ef etc.) are
>>hung in __lock_page. Breaking into kdb, I observe the following for one

Following is SysRq-T output for stuck processes during such a pause from
Christian Klose. Only processes in D state are listed for brevity.
Especially the last two call traces are interesting.

 kjournald     D C15C7240     4   122      1           123   120 (L-TLB)
 Call Trace:    [__get_request_wait+197/208] [__make_request+392/1472]
[generic_make_request+226/304] [submit_bh+80/112] [ll_rw_block+263/432]
[journal_commit_transaction+4017/4416] [kjournald+277/464]
[commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/464]
 kmail         D D73E9360  2656  1960      1                1978 (NOTLB)
 Call Trace:    [sleep_on+56/96] [log_wait_commit+56/80]
[journal_stop+345/480] [journal_force_commit+60/64]
[ext3_force_commit+35/48] [ext3_sync_file+132/176]
[ext3_writepage+0/672] [sys_fsync+151/208] [system_call+51/56]
 mc            D C016B338     0  2177   2152  2179               (NOTLB)
 Call Trace:    [journal_stop+328/480] [__lock_page+149/192]
[lock_page+26/32] [do_generic_file_read+653/1104]
[file_read_actor+0/160] [generic_file_read+178/368]
[file_read_actor+0/160] [sys_read+163/320] [system_call+51/56]
 kmail         D 00200282  2656  1960      1                1978 (NOTLB)
 Call Trace:    [sleep_on+56/96] [log_wait_commit+56/80]
[journal_stop+345/480] [journal_force_commit+60/64]
[ext3_force_commit+35/48] [ext3_sync_file+132/176]
[ext3_writepage+0/672] [sys_fsync+151/208] [system_call+51/56]
 mc            D C016B338     0  2177   2152  2179               (NOTLB)
 Call Trace:    [journal_stop+328/480] [__lock_page+149/192]
[lock_page+26/32] [do_generic_file_read+653/1104]
[file_read_actor+0/160] [generic_file_read+178/368]
[file_read_actor+0/160] [sys_read+163/320] [system_call+51/56]
 grep          D DFD7E120     0  3243   1470          3244       (NOTLB)
 Call Trace:    [__wait_on_buffer+93/144] [bread+123/144]
[ext3_get_branch+106/240] [ext3_get_block_handle+120/688]
[create_buffers+107/224] [ext3_get_block+74/144]
[block_read_full_page+541/624] [__alloc_pages+75/400]
[page_cache_read+173/208] [ext3_get_block+0/144]
[read_cluster_nonblocking+57/80] [filemap_nopage+285/560]
[do_no_page+137/480] [do_page_fault+376/1246] [handle_mm_fault+119/256]
[do_page_fault+376/1246] [rb_insert_color+210/240]
[do_page_fault+0/1246] [error_code+52/60] [clear_user+51/80]
[do_page_fault+0/1246] [error_code+52/60] [clear_user+51/80]
[padzero+40/48] [load_elf_binary+1179/2848] [load_elf_binary+0/2848]
[search_binary_handler+269/400] [copy_strings+440/560]
[do_execve+365/544] [sys_execve+66/128] [system_call+51/56]
 grep          D C02508D4     0  3244   1470          3245  3243 (NOTLB)
 Call Trace:    [__lock_page+149/192] [lock_page+26/32]
[filemap_nopage+305/560] [do_no_page+137/480] [do_page_fault+376/1246]
[handle_mm_fault+119/256] [do_page_fault+376/1246]
[rb_insert_color+210/240] [do_page_fault+0/1246] [error_code+52/60]
[clear_user+51/80] [do_page_fault+0/1246] [error_code+52/60]
[clear_user+51/80] [padzero+40/48] [load_elf_binary+1179/2848]
[__lock_page+175/192] [file_read_actor+0/160] [load_elf_binary+0/2848]
[search_binary_handler+269/400] [copy_strings+440/560]
[do_execve+365/544] [sys_execve+66/128] [system_call+51/56]
 grep          D C02508D4     0  3245   1470                3244 (NOTLB)
 Call Trace:    [__lock_page+149/192] [lock_page+26/32]
[filemap_nopage+305/560] [do_no_page+137/480] [do_page_fault+376/1246]
[handle_mm_fault+119/256] [do_page_fault+376/1246]
[rb_insert_color+210/240] [do_page_fault+0/1246] [error_code+52/60]
[clear_user+51/80] [do_page_fault+0/1246] [error_code+52/60]
[clear_user+51/80] [padzero+40/48] [load_elf_binary+1179/2848]
[__lock_page+175/192] [file_read_actor+0/160] [load_elf_binary+0/2848]
[search_binary_handler+269/400] [copy_strings+440/560]
[do_execve+365/544] [sys_execve+66/128] [system_call+51/56]


Regards,
Carl-Daniel

