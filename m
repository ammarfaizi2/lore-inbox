Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWBYPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWBYPVv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWBYPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:21:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25011 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161001AbWBYPVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:21:50 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc cleanup.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<20060225042757.1442ee2c.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 25 Feb 2006 08:20:32 -0700
In-Reply-To: <20060225042757.1442ee2c.akpm@osdl.org> (Andrew Morton's
 message of "Sat, 25 Feb 2006 04:27:57 -0800")
Message-ID: <m13bi731of.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> When working on pid namespaces I keep tripping over /proc.
>>  It's hard coded inode numbers and the amount of cruft
>>  accumulated over the years makes it hard to deal with.
>> 
>>  So to put /proc out of my misery here is a series of patches that
>>  removes the worst of the warts.
>
> An additional 2.7k of vmlinux.  A shame.

Looks like that at least is compiler dependent, with gcc-3.3.5 I get:

   text    data     bss     dec     hex filename
2601428  502342  226092 3329862  32cf46 ../linux-2.6-ns-mirror-build1/vmlinux
2602548  502494  226092 3331134  32d43e ../linux-2.6-ns-mirror-build2/vmlinux

So it looks like 1K of test and about 100 bytes of data.

Investigating this quickly.  Because of the refactoring it
is hard to pin this down to any major culprit.  But that is
also good news in that it doesn't look like an inline function
is responsible for this growth :)

It looks like the culprit for small amounts of growth is
the work to see if a task still exists, and other similar
checks that were needed but missing.

For the big chunks it looks like the work to populate the
dcache during readdir, which keeps the inode numbers in
sync and should help readdir+stat performance.

The other big culprit is proc_flush_task which is both
more comprehensive and simpler that proc_pid_flush+proc_pid_unhash=107+28.
But unfortunately that has made it a lot bigger.

So short of getting better dcache helpers for the case
where readdir populates the dcache it doesn't look the code
size will come down much.

The one practical thing that will help a little is that it
looks like with just a little more work we can replace
all of read_lock(&tasklist_lock) with rcu_read_lock().

add/remove: 33/23 grow/shrink: 28/16 up/down: 4968/-3619 (1349)
function                                     old     new   delta
proc_flush_task                                -     605    +605
proc_check_dentry_visible                      -     325    +325
proc_fill_cache                                -     256    +256
proc_fd_instantiate                            -     243    +243
tref_get_by_task                               -     200    +200
first_tid                                      -     179    +179
tgid_base_stuff                              336     504    +168
tid_base_stuff                               320     480    +160
first_tgid                                     -     159    +159
proc_pident_instantiate                        -     158    +158
proc_task_instantiate                          -     128    +128
proc_pid_instantiate                           -     128    +128
attr_dir_stuff                                 -     120    +120
proc_attr_dir_operations                       -     108    +108
tref_get_by_pid                                -     107    +107
proc_task_getattr                              -     105    +105
next_tid                                       -     100    +100
next_tgid                                      -      89     +89
tref_put                                       -      87     +87
proc_attr_dir_inode_operations                 -      84     +84
do_maps_open                                   -      80     +80
proc_fd_fill_cache                             -      63     +63
proc_task_fill_cache                           -      60     +60
proc_pid_fill_cache                            -      60     +60
__detach_pid                                 136     195     +59
proc_info_read                               111     164     +53
oom_adjust_read                              162     215     +53
proc_get_sb                                   26      78     +52
seccomp_write                                168     218     +50
seccomp_read                                 164     214     +50
oom_adjust_write                             164     214     +50
proc_pid_attr_read                           124     172     +48
proc_base_stuff                                -      48     +48
proc_pid_attr_write                          148     194     +46
proc_fd_link                                 122     168     +46
proc_exe_link                                152     198     +46
mounts_open                                  157     200     +43
proc_root_link                                99     141     +42
proc_cwd_link                                 99     141     +42
tid_fd_revalidate                            207     247     +40
proc_pident_fill_cache                         -      40     +40
get_tref_task                                  -      33     +33
dup_task_struct                              137     170     +33
m_stop                                        59      88     +29
m_start                                      235     264     +29
tref_reset                                     -      28     +28
proc_attr_dir_readdir                          -      28     +28
proc_pident_readdir                          270     296     +26
proc_attr_dir_lookup                           -      22     +22
tref_set                                       -      21     +21
tref_fini                                      -      21     +21
tref_init                                      -      18     +18
proc_pid_follow_link                          98     116     +18
init_tref                                      -      16     +16
init_task                                   1328    1344     +16
pid_revalidate                               178     192     +14
attach_pid                                   149     162     +13
tref_get                                       -       8      +8
mem_read                                     430     438      +8
proc_alloc_inode                              98     102      +4
proc_task_readdir                            320     323      +3
pid_delete_dentry                             24      21      -3
m_next                                        70      61      -9
proc_readfd                                  327     307     -20
copy_process                                3190    3170     -20
smaps_open                                    43      22     -21
maps_open                                     43      22     -21
proc_tid_attr_lookup                          22       -     -22
proc_tgid_attr_lookup                         22       -     -22
proc_delete_inode                            129     105     -24
pid_base_dentry_operations                    24       -     -24
proc_tid_attr_readdir                         28       -     -28
proc_tgid_attr_readdir                        28       -     -28
proc_pid_flush                                28       -     -28
release_task                                 257     228     -29
proc_permission                               38       -     -38
proc_pid_make_inode                          205     166     -39
unhash_process                                73      33     -40
de_thread                                   1310    1266     -44
proc_check_root                               55       -     -55
proc_task_lookup                             244     188     -56
pid_base_iput                                 62       -     -62
proc_pid_readdir                             303     229     -74
tid_attr_stuff                                80       -     -80
tgid_attr_stuff                               80       -     -80
proc_task_permission                          82       -     -82
proc_tid_attr_inode_operations                84       -     -84
proc_tgid_attr_inode_operations               84       -     -84
proc_mem_inode_operations                     84       -     -84
get_tid_list                                  97       -     -97
proc_pid_unhash                              107       -    -107
proc_tid_attr_operations                     108       -    -108
proc_tgid_attr_operations                    108       -    -108
proc_lookupfd                                240      99    -141
get_tgid_list                                146       -    -146
proc_task_root_link                          218       -    -218
proc_check_chroot                            245       -    -245
switch_exec_pids                             290       -    -290
proc_pid_lookup                              503     145    -358
proc_pident_lookup                           742     142    -600

Eric
