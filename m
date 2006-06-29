Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWF2TgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWF2TgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWF2TgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:36:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:54567 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932327AbWF2TgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:36:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=gruE9YQOno5cfmI+HHJpwfXskV7YBsOOCIfA3dTF4gpzUG58M3nlVETcP8d0yOnnSkg8pJvoLLe2CfhqSVMb7wXs4EzZiyTLH7kKeN3T1QqGJkAHabJGpAdKaBZmeHiBY+ddT3yhYVcnIlZJMpp7mR8nkVPCSTAWYJNLLkfPW4c=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Andrew Morton <akpm@osdl.org>
Subject: Possible circular locking dependency detected in Reiser4
Date: Thu, 29 Jun 2006 15:36:04 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <20060629013643.4b47e8bd.akpm@osdl.org>
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291536.05981.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following warning when I ran klive:

Andrew Wade
  
 =======================================================
 [ INFO: possible circular locking dependency detected ]
 -------------------------------------------------------
 twistd/3816 is trying to acquire lock:
  (&txnh->hlock){--..}, at: [txn_end+1011/1139] txn_end+0x3f3/0x473
 
 but task is already holding lock:
  (&atom->alock){--..}, at: [txnh_get_atom+28/120] txnh_get_atom+0x1c/0x78
 
 which lock already depends on the new lock.
 
 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (&atom->alock){--..}:
        [lock_acquire+94/129] lock_acquire+0x5e/0x81
        [_spin_lock+35/50] _spin_lock+0x23/0x32
        [try_capture+733/2499] try_capture+0x2dd/0x9c3
        [longterm_lock_znode+755/1026] longterm_lock_znode+0x2f3/0x402
        [seal_validate+82/288] seal_validate+0x52/0x120
        [write_sd_by_inode_common+659/1328] write_sd_by_inode_common+0x293/0x530
        [reiser4_update_sd+37/44] reiser4_update_sd+0x25/0x2c
        [reiser4_dirty_inode+23/112] reiser4_dirty_inode+0x17/0x70
        [__mark_inode_dirty+41/353] __mark_inode_dirty+0x29/0x161
        [inode_setattr+345/355] inode_setattr+0x159/0x163
        [setattr_common+86/131] setattr_common+0x56/0x83
        [setattr_unix_file+493/507] setattr_unix_file+0x1ed/0x1fb
        [notify_change+260/533] notify_change+0x104/0x215
        [sys_fchmodat+151/190] sys_fchmodat+0x97/0xbe
        [sys_chmod+18/20] sys_chmod+0x12/0x14
        [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
 
 -> #0 (&txnh->hlock){--..}:
        [lock_acquire+94/129] lock_acquire+0x5e/0x81
        [_spin_lock+35/50] _spin_lock+0x23/0x32
        [txn_end+1011/1139] txn_end+0x3f3/0x473
        [reiser4_exit_context+172/287] reiser4_exit_context+0xac/0x11f
        [setattr_common+123/131] setattr_common+0x7b/0x83
        [setattr_unix_file+493/507] setattr_unix_file+0x1ed/0x1fb
        [notify_change+260/533] notify_change+0x104/0x215
        [sys_fchmodat+151/190] sys_fchmodat+0x97/0xbe
        [sys_chmod+18/20] sys_chmod+0x12/0x14
        [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
 
 other info that might help us debug this:
 
 2 locks held by twistd/3816:
  #0:  (&inode->i_mutex){--..}, at: [mutex_lock+8/10] mutex_lock+0x8/0xa
  #1:  (&atom->alock){--..}, at: [txnh_get_atom+28/120] txnh_get_atom+0x1c/0x78
 
 stack backtrace:
  [show_trace_log_lvl+84/253] show_trace_log_lvl+0x54/0xfd
  [show_trace+13/16] show_trace+0xd/0x10
  [dump_stack+23/25] dump_stack+0x17/0x19
  [print_circular_bug_tail+89/100] print_circular_bug_tail+0x59/0x64
  [__lock_acquire+2084/2524] __lock_acquire+0x824/0x9dc
  [lock_acquire+94/129] lock_acquire+0x5e/0x81
  [_spin_lock+35/50] _spin_lock+0x23/0x32
  [txn_end+1011/1139] txn_end+0x3f3/0x473
  [reiser4_exit_context+172/287] reiser4_exit_context+0xac/0x11f
  [setattr_common+123/131] setattr_common+0x7b/0x83
  [setattr_unix_file+493/507] setattr_unix_file+0x1ed/0x1fb
  [notify_change+260/533] notify_change+0x104/0x215
  [sys_fchmodat+151/190] sys_fchmodat+0x97/0xbe
  [sys_chmod+18/20] sys_chmod+0x12/0x14
  [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
