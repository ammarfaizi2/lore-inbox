Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWEBVWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWEBVWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWEBVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:22:10 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:23943 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964975AbWEBVWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:22:09 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.17-rc3 : slab error in kmem_cache_destroy(): cache `dcookie_cache': Can't free all objects
Date: Tue, 2 May 2006 23:22:16 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022322.16968.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems reproductible, on dual Opteron (x86_64), NUMA enabled.

When issuing : 

opcontrol --deinit

slab error in kmem_cache_destroy(): cache `dcookie_cache': Can't free all 
objects

Call Trace: <ffffffff802715ef>{kmem_cache_destroy+175}
       <ffffffff802b4c48>{dcookie_unregister+280} 
<ffffffff803a4ff7>{event_buffer_release+23}
       <ffffffff802767a8>{__fput+88} <ffffffff8027382d>{filp_close+93}
       <ffffffff8022ee2e>{put_files_struct+110} 
<ffffffff8023025a>{do_exit+650}
       <ffffffff802ec581>{__up_write+33} <ffffffff80230998>{do_group_exit+200}
       <ffffffff80209cbe>{system_call+126}

# grep dcookie_cache /proc/slabinfo
dcookie_cache          0      0     32  112    1 : tunables  120   60    8 : 
slabdata      0      0      0


After that, oprofile cannot work anymore, since the dcookie_cache cannot be 
re-created...

kmem_cache_create: duplicate cache dcookie_cache

Call Trace: <ffffffff802726ff>{kmem_cache_create+1455}
       <ffffffff80285f55>{do_path_lookup+629} 
<ffffffff803a4e20>{event_buffer_open+0}
       <ffffffff802b4dc0>{dcookie_register+96} 
<ffffffff803a4e5a>{event_buffer_open+58}
       <ffffffff80273aad>{__dentry_open+237} 
<ffffffff80273cca>{do_filp_open+42}
       <ffffffff80273935>{get_unused_fd+101} 
<ffffffff80273d36>{do_sys_open+86}
       <ffffffff80209cbe>{system_call+126}


Eric Dumazet
