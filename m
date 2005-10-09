Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVJIQ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVJIQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVJIQ2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:28:37 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:26888 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750914AbVJIQ2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:28:36 -0400
Message-ID: <4349614F.1010408@frankengul.org>
Date: Sun, 09 Oct 2005 20:28:31 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: debian-sparc@lists.debian.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Sparc64 U60: no iptables
References: <4347A731.7010509@frankengul.org> <4348EFF4.3040305@frankengul.org>
In-Reply-To: <4348EFF4.3040305@frankengul.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Bernard a écrit :

> Sébastien Bernard wrote:
>
>> Hi there.
>>
>> Being the owner of a two-way U60, I've been happy with it until 
>> 2.6.11.6.
>>
>> The machine is a 2x300Mhz Uii with 1536Mb of memory and 2 scsi 
>> internal disk.
>>
>> Since 2.6.12, I'm unfortunately unable to use it as gateway box, 
>> since the installation of iptables
>> cause a OOPS in the ipt_mangle.
>>
>> I'm unable to send you the trace now because once it happened, it is 
>> not written on the files, only on the console.
>>
>> This oops happens from the 2.6.12.x to the 2.6.13.x - not tried the 
>> 2.6.14-rc.
>> It is related to the iptables subsystem.
>> It also happen with the official debian kernel (2.6.12-1-smp).
>>
>> I'll try this week-end to setup early 2.6.12-rcx to check when the 
>> problem occured.
>>
>> I will post the oops as soon as I write it down.
>> How can I get the copy of the trace without handwriting ?
>> What is the information relevant in the oops ?  (register + stack 
>> trace ?)
>>
>>    Seb
>>
>>
> Ok, I reproduced the problem on the 2.6.12-rc1.
> Here's the backtrace :
>
> Unable to handle kernel NULL pointer dereference.
>
> nmbd: Ooops[#1]
>
> ip_do_table + 0x21c/0x380
> ip_do_table + 0x44/0x380
> ip_local_hook + 0x84/0x120
> nf_iterate + 0x64/0xc0
> nf_hook_slow + 0x4c/0x120
> ip_push_pending_frames + 0x2d8/0x4c0
> udp_push_pending_frames + 0x118/0x260
> udp_sendmsg + 0x398/0x6c0
> inet_sendmsg + 0x30/0x60
> sock_sendmsg + 0xc8/0x100
>
I found the culprit for my oops.
In the iptables, NR_CPUS is set to 4 to get the 2 cpus recognized properly.
The culprit patch substitute the NR_CPUS by the num_possible_cpus() macro.
With this patch applied, inserting the iptables modules gets you instant 
oops...
With it reverted, everything works as normal.
I suspect that NR_CPUS == 4 and num_possible_cpus() == 2.

Can one explain me why this patch works on other archs, and oops on the 
sparc64 smp ?
Can one explain why I'm the only one to have this problem ?

    Seb

Here is the patch I reverted :
--- a/net/ipv4/netfilter/ip_tables.c    2005-03-17 17:35:05 -08:00
+++ b/net/ipv4/netfilter/ip_tables.c    2005-03-17 17:35:05 -08:00
@@ -923,7 +923,7 @@
        }

        /* And one copy for every other CPU */
-       for (i = 1; i < NR_CPUS; i++) {
+       for (i = 1; i < num_possible_cpus(); i++) {
                memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
                       newinfo->entries,
                       SMP_ALIGN(newinfo->size));
@@ -945,7 +945,7 @@
                struct ipt_entry *table_base;
                unsigned int i;

-               for (i = 0; i < NR_CPUS; i++) {
+               for (i = 0; i < num_possible_cpus(); i++) {
                        table_base =
                                (void *)newinfo->entries
                                + TABLE_OFFSET(newinfo, i);
@@ -992,7 +992,7 @@
        unsigned int cpu;
        unsigned int i;

-       for (cpu = 0; cpu < NR_CPUS; cpu++) {
+       for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
                i = 0;
                IPT_ENTRY_ITERATE(t->entries + TABLE_OFFSET(t, cpu),
                                  t->size,
@@ -1130,7 +1130,7 @@
                return -ENOMEM;

        newinfo = vmalloc(sizeof(struct ipt_table_info)
-                         + SMP_ALIGN(tmp.size) * NR_CPUS);
+                         + SMP_ALIGN(tmp.size) * num_possible_cpus());
        if (!newinfo)
                return -ENOMEM;

@@ -1460,7 +1460,7 @@
                = { 0, 0, 0, { 0 }, { 0 }, { } };

        newinfo = vmalloc(sizeof(struct ipt_table_info)
-                         + SMP_ALIGN(repl->size) * NR_CPUS);
+                         + SMP_ALIGN(repl->size) * num_possible_cpus());
        if (!newinfo)
                return -ENOMEM;

-------------------

