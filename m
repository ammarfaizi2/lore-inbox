Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWDFRTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWDFRTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWDFRTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:19:01 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:51207 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932203AbWDFRTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:19:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=cc2LQcOGQTigBnMziY4X5zj+JkTcZdJyjWIDnLWYldFKKwO8N23s97Cf9BvnRsfwv7ul6b0SPiVhSL2SmnoL7Vtc60aFgDvXRKKJy/z8T/bC42tH4Fk3u3psZLr1iPrtpzxQj+qAHCRyB7aTqWsQk5peFC3xuLuoK+nZGEiOMHo=
Message-ID: <44354D7B.9070207@gmail.com>
Date: Thu, 06 Apr 2006 19:18:51 +0200
From: jordi Vaquero <jordi.vaquero@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:140 with inet_stream
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm trying to make a Linux Kernel module. My module has a network
comunication with sockets, I use the functions like this skeleton,

            sd = sock_create(AF_INET,SOCK_STREAM,IPPROTO_TCP,&sock);
                if(sd<0){
                printk(KERN_ERR "Error\n");
            }else{
                sout.sin_family = AF_INET;
                err = inet_aton("172.16.151.1",&sout.sin_addr); //this
        function works well, I implemented it.
                sout.sin_port = htons(20000);
                sd = sock->ops->connect(sock,(struct sockaddr*)&sout,
        sizeof(sout),O_RDWR);
                if(sd<0){
                    printk(KERN_ERR "Error \n");
                    sock_release(sock);
                }else{
                     USE SENDMSG and RECVMSG
                        ...
                        ...
                        ...
                   sock_release(sock);
                }

My problem is that sometimes, at some point near the connect function, a
warning is launched and dmesg shows this:

                                                            Badness in
        local_bh_enable at kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+22/324]
        inet_stream_connect+0x16/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel: 
        [__ip_route_output_key+188/196] __ip_route_output_key+0xbc/0xc4
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_connect+273/2229]
        tcp_v4_connect+0x111/0x8b5
        Apr  5 20:24:57 localhost kernel:  [dump_stack+18/22]
        dump_stack+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+123/324]
        inet_stream_connect+0x7b/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel: 
        [__ip_route_output_key+188/196] __ip_route_output_key+0xbc/0xc4
        Apr  5 20:24:57 localhost kernel:  [ip_route_output_flow+17/74]
        ip_route_output_flow+0x11/0x4a
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_connect+387/2229]
        tcp_v4_connect+0x183/0x8b5
        Apr  5 20:24:57 localhost kernel:  [dump_stack+18/22]
        dump_stack+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+123/324]
        inet_stream_connect+0x7b/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_connect+1613/2229]
        tcp_v4_connect+0x64d/0x8b5
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+123/324]
        inet_stream_connect+0x7b/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel: 
        [__ip_route_output_key+188/196] __ip_route_output_key+0xbc/0xc4
        Apr  5 20:24:57 localhost kernel:  [ip_route_output_flow+17/74]
        ip_route_output_flow+0x11/0x4a
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_connect+1793/2229]
        tcp_v4_connect+0x701/0x8b5
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+123/324]
        inet_stream_connect+0x7b/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel:  [ip_output+399/533]
        ip_output+0x18f/0x215
        Apr  5 20:24:57 localhost kernel:  [ip_queue_xmit+909/1011]
        ip_queue_xmit+0x38d/0x3f3
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_send_check+123/193]
        tcp_v4_send_check+0x7b/0xc1
        Apr  5 20:24:57 localhost kernel:  [tcp_transmit_skb+1437/1642]
        tcp_transmit_skb+0x59d/0x66a
        Apr  5 20:24:57 localhost kernel:  [tcp_connect+693/794]
        tcp_connect+0x2b5/0x31a
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_connect+1983/2229]
        tcp_v4_connect+0x7bf/0x8b5
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+123/324]
        inet_stream_connect+0x7b/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel:  [dev_queue_xmit+410/416]
        dev_queue_xmit+0x19a/0x1a0
        Apr  5 20:24:57 localhost kernel:  [ip_output+447/533]
        ip_output+0x1bf/0x215
        Apr  5 20:24:57 localhost kernel:  [ip_queue_xmit+909/1011]
        ip_queue_xmit+0x38d/0x3f3
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_send_check+123/193]
        tcp_v4_send_check+0x7b/0xc1
        Apr  5 20:24:57 localhost kernel:  [tcp_transmit_skb+1437/1642]
        tcp_transmit_skb+0x59d/0x66a
        Apr  5 20:24:57 localhost kernel:  [tcp_connect+693/794]
        tcp_connect+0x2b5/0x31a
        Apr  5 20:24:57 localhost kernel:  [tcp_v4_connect+1983/2229]
        tcp_v4_connect+0x7bf/0x8b5
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+123/324]
        inet_stream_connect+0x7b/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75
        Apr  5 20:24:57 localhost kernel: Badness in local_bh_enable at
        kernel/softirq.c:140
        Apr  5 20:24:57 localhost kernel:  [local_bh_enable+37/92]
        local_bh_enable+0x25/0x5c
        Apr  5 20:24:57 localhost kernel: 
        [inet_wait_for_connect+76/163] inet_wait_for_connect+0x4c/0xa3
        Apr  5 20:24:57 localhost kernel: 
        [autoremove_wake_function+0/58] autoremove_wake_function+0x0/0x3a
        Apr  5 20:24:57 localhost kernel:  [inet_stream_connect+191/324]
        inet_stream_connect+0xbf/0x144
        Apr  5 20:24:57 localhost kernel:  [pg0+140346179/1070617600]
        remote_send_swap+0xad/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [printk+18/22] printk+0x12/0x16
        Apr  5 20:24:57 localhost kernel:  [pg0+140346824/1070617600]
        remote_send_swap+0x332/0x33d [rswap]
        Apr  5 20:24:57 localhost kernel:  [scrup+81/174] scrup+0x51/0xae
        Apr  5 20:24:57 localhost kernel:  [vgacon_cursor+307/314]
        vgacon_cursor+0x133/0x13a
        Apr  5 20:24:57 localhost kernel:  [set_cursor+78/91]
        set_cursor+0x4e/0x5b
        Apr  5 20:24:57 localhost kernel:  [vt_console_print+523/540]
        vt_console_print+0x20b/0x21c
        Apr  5 20:24:57 localhost kernel: 
        [__call_console_drivers+55/69] __call_console_drivers+0x37/0x45
        Apr  5 20:24:57 localhost kernel: 
        [call_console_drivers+226/234] call_console_drivers+0xe2/0xea
        Apr  5 20:24:57 localhost kernel:  [vprintk+467/494]
        vprintk+0x1d3/0x1ee
        Apr  5 20:24:57 localhost kernel:  [__make_request+1020/1068]
        __make_request+0x3fc/0x42c
        Apr  5 20:24:57 localhost kernel:  [pg0+140346943/1070617600]
        rswap_send+0x6c/0x88 [rswap]
        Apr  5 20:24:57 localhost kernel:  [pg0+140347045/1070617600]
        request_dd+0x4a/0x71 [rswap]
        Apr  5 20:24:57 localhost kernel:  [blk_remove_plug+70/80]
        blk_remove_plug+0x46/0x50
        Apr  5 20:24:57 localhost kernel:  [sync_page+0/61]
        sync_page+0x0/0x3d
        Apr  5 20:24:57 localhost kernel:  [generic_unplug_device+10/13]
        generic_unplug_device+0xa/0xd
        Apr  5 20:24:57 localhost kernel:  [block_sync_page+53/58]
        block_sync_page+0x35/0x3a
        Apr  5 20:24:57 localhost kernel:  [sync_page+52/61]
        sync_page+0x34/0x3d
        Apr  5 20:24:57 localhost kernel:  [__wait_on_bit_lock+43/81]
        __wait_on_bit_lock+0x2b/0x51
        Apr  5 20:24:57 localhost kernel:  [__lock_page+84/90]
        __lock_page+0x54/0x5a
        Apr  5 20:24:57 localhost kernel:  [wake_bit_function+0/52]
        wake_bit_function+0x0/0x34
        Apr  5 20:24:57 localhost kernel:  [read_cache_page+198/271]
        read_cache_page+0xc6/0x10f
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [read_dev_sector+44/131]
        read_dev_sector+0x2c/0x83
        Apr  5 20:24:57 localhost kernel:  [blkdev_readpage+0/21]
        blkdev_readpage+0x0/0x15
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+30/263]
        parse_solaris_x86+0x1e/0x107
        Apr  5 20:24:57 localhost kernel:  [parse_solaris_x86+0/263]
        parse_solaris_x86+0x0/0x107
        Apr  5 20:24:57 localhost kernel:  [msdos_partition+514/596]
        msdos_partition+0x202/0x254
        Apr  5 20:24:57 localhost kernel:  [check_partition+136/204]
        check_partition+0x88/0xcc
        Apr  5 20:24:57 localhost kernel:  [rescan_partitions+97/166]
        rescan_partitions+0x61/0xa6
        Apr  5 20:24:57 localhost kernel:  [blkdev_reread_part+73/97]
        blkdev_reread_part+0x49/0x61
        Apr  5 20:24:57 localhost kernel:  [blkdev_ioctl+250/297]
        blkdev_ioctl+0xfa/0x129
        Apr  5 20:24:57 localhost kernel:  [block_ioctl+26/30]
        block_ioctl+0x1a/0x1e
        Apr  5 20:24:57 localhost kernel:  [do_ioctl+33/86]
        do_ioctl+0x21/0x56
        Apr  5 20:24:57 localhost kernel:  [vfs_ioctl+348/363]
        vfs_ioctl+0x15c/0x16b
        Apr  5 20:24:57 localhost kernel:  [sys_ioctl+43/70]
        sys_ioctl+0x2b/0x46
        Apr  5 20:24:57 localhost kernel:  [sysenter_past_esp+84/117]
        sysenter_past_esp+0x54/0x75

I don't find any pattern that causes this log,
My kernel is 2.6.15. Someone knows what is the error, or something that
could help me to find it??
thanks in advance

jordi  



