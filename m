Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVDTVvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVDTVvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVDTVvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:51:52 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:5358 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261824AbVDTVvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:51:36 -0400
Message-ID: <4266CEED.3010108@karett.se>
Date: Wed, 20 Apr 2005 23:51:41 +0200
From: Mikael Andersson <mikael@karett.se>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disk output lockup amd64 nforce4 device-mapper 2.6.12_rc2
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During heavy io-load a lockup occurs that appears to prevent any disk
output from taking place. fs is reiserfs on two device-mapper mirrored
200G maxtor disks. After the lockup occurs you can to things like 'ls',
but echo > test.txt will hang.

A typical workload producing the error is doing:
rsync of large (1GB) over 100Mbit ethernet
simultaneous compilation / gunzip

I've disabled preemption, and tried with and without acpi enabled, with
and without smp support (it was smp by default so i switched it off).
Also tried with another nic (rtl8139) since i got an nv_stop_tx:
TransmitterStatus remained busy<6> in the logs. I also tried 2.6.11.7
with the same result.

This produces the lockup after 10-40 minutes. I've got a complete log
from alt-sysreq-T if anyone wants to look at it. The following is a dump
for the bash and kmirrord process when trying echo > test.txt.
The output for kmirrord is included because it's exactly as specified
below both before and after echo > test.txt is invoked, this looked
peculiar to me.

Later runs showed what was to my eyes similar results, some callpaths
weren't exactly the same, but kmirrord was somewhere in mempool_alloc
and the bash process was in do_journal_end, whatever that means :)


bash D ffffc2000038e000 0 6529 6381 (NOTLB)
ffff81003dfc1bd8 0000000000000086
0000000000000000 ffff810001b6ba60
6db6db6db6db6db7 ffffffff801acc46
ffff810001b6ba98 ffff81003d8c27e0
00000000000027cd ffffffff805a61c0

Call Trace:
<ffffffff801acc46>{__d_lookup+358} <ffffffff801ff133>{queue_log_writer+115}
<ffffffff8012e6a0>{default_wake_function+0}
<ffffffff801ff9fc>{do_journal_end+604}
<ffffffff801e0162>{search_by_entry_key+50}
<ffffffff802004ed>{do_journal_begin_r+77}
<ffffffff802006df>{do_journal_begin_r+575}
<ffffffff8020096c>{journal_begin+204}
<ffffffff801e10d7>{reiserfs_create+183}
<ffffffff801a0dcc>{vfs_create+188}
<ffffffff801a11e6>{open_namei+454}
<ffffffff8018a727>{filp_open+39}
<ffffffff8018a82f>{get_unused_fd+223}
<ffffffff8019e39a>{getname+138}
<ffffffff8018abfc>{sys_open+76}
<ffffffff8010dfe6>{system_call+126}


kmirrord/0 D ffff81003f1bccd8 0 978 9 1731 977 (L-TLB)
ffff81003f931ab8 0000000000000046
0000000000000200 ffffffff8016a2d6
ffff810036d18e80 0000000000000001
000000733f931c30 ffff81003f8d4030
000000000000952e ffff810036cf67e0

Call Trace:
<ffffffff8016a2d6>{cache_alloc_refill+1222}
<ffffffff804a2f9f>{io_schedule+15}
<ffffffff80164e23>{mempool_alloc+707} <ffffffff80413250>{bvec_get_page+0}
<ffffffff801543c0>{autoremove_wake_function+0}
<ffffffff801543c0>{autoremove_wake_function+0}
<ffffffff8041cffc>{__rh_alloc+44}
<ffffffff8041d483>{rh_inc_pending+67}
<ffffffff8041e39b>{do_work+2955}
<ffffffff8041e3c8>{do_work+3000}
<ffffffff804a16b4>{thread_return+0}
<ffffffff8041d810>{do_work+0}
<ffffffff8014ce3b>{worker_thread+715}
<ffffffff8012e6a0>{default_wake_function+0}
<ffffffff8012e6a0>{default_wake_function+0}
<ffffffff8014cb70>{worker_thread+0}
<ffffffff801537ed>{kthread+205} <ffffffff80153830>{keventd_create_kthread+0}
<ffffffff8010eb1f>{child_rip+8} <ffffffff80153830>{keventd_create_kthread+0}
<ffffffff80153720>{kthread+0}
<ffffffff8010eb17>{child_rip+0}

/Mikael Andersson
