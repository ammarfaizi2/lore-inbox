Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVCGXnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVCGXnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVCGXmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:42:44 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:22949 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261916AbVCGXhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:37:18 -0500
Message-ID: <422CE5AB.2030304@candelatech.com>
Date: Mon, 07 Mar 2005 15:37:15 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422C66B8.2060605@rapidforum.com>
In-Reply-To: <422C66B8.2060605@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started trying to reproduce this, and hit a bug in either
my code or perhaps the tcp stack.

I have a control TCP socket on machine A connected to machine B.

Currently, server A is stuck spinning trying very hard to send commands to
server B.  The interesting this is that netstat shows the SendQ to have
data on both machines (they are trying to send to each other on the same
socket connection), but the receive queues are empty on both machines as well:

machine A:
FC3 x86-64, kernel:  2.6.10-1.766_FC3smp, Dual opetron, 2GB RAM, SMP kernel

netstat:
tcp        0  93440 192.168.1.5:57228           192.168.1.165:4002          ESTABLISHED

Strace of this server:
socketcall(0x9, 0xffffb780)             = -1 EAGAIN (Resource temporarily unavailable)
nanosleep({42949672960000000, 597879105668495392}, NULL) = 0
gettimeofday({2058282582467209, 597879105668495392}, NULL) = 0
gettimeofday({2058737849000585, 597879101513232728}, NULL) = 0
write(3, "1110237833479:  iohandler.cc 383"..., 103) = 103
socketcall(0x9, 0xffffb780)             = -1 EAGAIN (Resource temporarily unavailable)
.....



machine B:

2.6.11 + my patches, dual xeon, SMP kernel, 1GB RAM

netstat:
tcp        0 202940 192.168.1.165:4002      192.168.1.5:57228       ESTABLISHED

# Machine B is not trying to send so much stuff to A, so it is not busy-spinning,
# at least it won't untill it finally fills up it's 8MB user-space send buffer.

Any ideas??

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

