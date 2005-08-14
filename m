Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVHNNTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVHNNTF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 09:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVHNNTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 09:19:04 -0400
Received: from [62.206.217.67] ([62.206.217.67]:3045 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S932476AbVHNNTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 09:19:04 -0400
Message-ID: <42FF44B8.9000007@trash.net>
Date: Sun, 14 Aug 2005 15:18:48 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Harald Welte <laforge@netfilter.org>
Subject: Re: 2.6.13-rc5-mm1: BUG: rwlock recursion on CPU#0
References: <200508141448.36562.rjw@sisk.pl>
In-Reply-To: <200508141448.36562.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> I've got the following BUG on Asus L5D (x86-64) with the 2.6.13-rc5-mm1 kernel:
> 
> BUG: rwlock recursion on CPU#0, nscd/3668, ffffffff8817d4a0
> 
> Call Trace:<ffffffff80241ca9>{add_preempt_count+105} <ffffffff80241682>{rwlock_bug+114}
>        <ffffffff8024179e>{_raw_write_lock+62} <ffffffff80350f48>{_write_lock_bh+40}
>        <ffffffff88171824>{:ip_conntrack:destroy_conntrack+196}
>        <ffffffff88170435>{:ip_conntrack:__ip_ct_event_cache_init+165}
>        <ffffffff88170549>{:ip_conntrack:ip_ct_refresh_acct+249}
>        <ffffffff88173c4f>{:ip_conntrack:udp_packet+47} <ffffffff88172143>{:ip_conntrack:ip_conntrack_in+1059}
>        <ffffffff8816fb4c>{:ip_conntrack:ip_conntrack_local+76}
>        <ffffffff802fe7ec>{nf_iterate+92} <ffffffff80311d90>{dst_output+0}
>        <ffffffff802ff3de>{nf_hook_slow+142} <ffffffff80311d90>{dst_output+0}
>        <ffffffff803123bf>{ip_push_pending_frames+895} <ffffffff802eade9>{lock_sock+201}
>        <ffffffff8032e72e>{udp_push_pending_frames+574} <ffffffff8032ffc7>{udp_sendmsg+1703}
>        <ffffffff8013874e>{current_fs_time+78} <ffffffff8015c03c>{file_read_actor+60}
>        <ffffffff80199b6c>{update_atime+76} <ffffffff8015e8fa>{do_generic_mapping_read+1194}
>        <ffffffff80335946>{inet_sendmsg+86} <ffffffff802e7dff>{sock_sendmsg+271}
>        <ffffffff80241ca9>{add_preempt_count+105} <ffffffff8016153e>{free_hot_cold_page+270}
>        <ffffffff801615bb>{free_hot_page+11} <ffffffff80241ca9>{add_preempt_count+105}
>        <ffffffff8014a670>{autoremove_wake_function+0} <ffffffff802e846c>{sockfd_lookup+28}
>        <ffffffff802e9c64>{sys_sendto+260} <ffffffff80193003>{do_sys_poll+851}
>        <ffffffff80193de0>{__pollwait+0} <ffffffff8010eb3e>{system_call+126}

I fear my event cache fixes are responsible for this, we must not cache
events while holding a lock anymore because we might need to deliver
old cached events. I'll try to come up with a fix later.

