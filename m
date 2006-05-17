Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWEQSPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWEQSPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWEQSPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:15:20 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:42355 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750833AbWEQSPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:15:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nydf/roNiAi8+4JLNQKNW8agaF7xhweP+BKy2ZJQkbr9z3Uub1yLNXhMQLI1Zg3QlxWRwCYHdU0qMB53Ap0Y6VmWWcIlXoJyROqefTlWVVKdbH5KfdgV/x5zlf/JJ05z/YvYSVdHDcQCmhvdiDqdRsr+m8oSmSWSamIypoTiNd4=
Message-ID: <446B6834.2020909@gmail.com>
Date: Wed, 17 May 2006 12:15:16 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com> <446950E3.4060601@zytor.com> <20060516101838.GK6931@stusta.de> <446A2243.6050109@zytor.com> <446ACCCF.1030406@gmail.com> <446B4BDD.9090208@zytor.com> <446B5AB0.8050703@gmail.com> <446B5BC7.7080105@zytor.com>
In-Reply-To: <446B5BC7.7080105@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jim Cromie wrote:
>> H. Peter Anvin wrote:
>>> Jim Cromie wrote:
>>>>>
>>>> Ok, it built clean, but broke on boot.
>>>>
>>>
>>> What does the full command line look like?
>>>
>>>     -hpa
>>>
>> I presume you mean the kernel boot-line, since last post included the 
>> 'Running ipconfig'
>>
>> Ive been banging at the kernel with permutations of the following 
>> pxelinux stanza.
>>
>> LABEL   I 2.6.17-rc4-mm1-sk
>>  MENU LABEL    ^i.  2.6.17-rc4-mm1-sk
>>  KERNEL        vmlinuz-2.6.17-rc4-mm1-sk
>>  APPEND        console=ttyS0,115200n81 root=/dev/nfs 
>> nfsroot=/nfshost/truck 
>> ip=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
>> panic=5
>>
>> I think the problem lies with picking up a decent 'rootpath', since that
>> part of the output is always empty, for all variations tried so far..
>>
>
> Okay, this is probably a result of specifying the NFS server in the 
> ip= option and the nfsroot not having a server.  I will try to debug 
> this and straighten it out.
>
ok - that may need attention, but its also my misunderstanding of the 
rootpath field;
which describes only what it got from dhcp, I was looking for the 
cmd-line arg
to show up there also.  the 'complete' threw me.

Anyway, I passed it in via dhcp.conf, so I now get this, (and 
command-line override)

IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 0.0.0.0          dns0     : 192.168.42.1     dns1   : 0.0.0.0
 rootserver: 192.168.42.1 rootpath: /nfshost/truck
eth0: state = 4
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
nfsroot=/nfshost/truck overrides boot server bootpath /nfshost/truck
NFS-Root: mo[   22.660000] Kernel panic - not syncing: Attempted to kill 
init!
unting ip= on /r[   22.668000]  oot with options<0>Rebooting in 5 
seconds.. 'none'
kinit: need a server
Checking for init: /sbin/init
Checking for init: /bin/init


Ive added this, but havent yet seen its output :-/


[jimc@harpo kinit]$ diff -u  nfsmount/main.c~ nfsmount/main.c
--- nfsmount/main.c~    2006-05-15 10:03:56.000000000 -0600
+++ nfsmount/main.c     2006-05-17 11:39:59.000000000 -0600
@@ -247,6 +247,10 @@
                return 1;
 #endif

+       fprintf(stderr, "nfs_mount:"
+               "rem_name %s, hostname %s, server %x, rem_path %s, path 
%s\n",
+               rem_name, hostname, server, rem_path, path);
+
        if (nfs_mount(rem_name, hostname, server, rem_path, path,
                      &mount_data) != 0)
                return 1;





>     -hpa
>

thanks
