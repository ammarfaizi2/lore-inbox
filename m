Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTHBOTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 10:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTHBOTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 10:19:55 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:30133 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263187AbTHBOTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 10:19:53 -0400
Date: Sat, 02 Aug 2003 07:19:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jsanchez@cs.ucf.edu
Subject: [Bug 1030] New: racoon causes oops when implementing IPSec key 
Message-ID: <89550000.1059833972@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1030

           Summary: racoon causes oops when implementing IPSec key
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: jsanchez@cs.ucf.edu


Distribution: SuSE and LFS
Hardware Environment: e100 cards
Software Environment: ipsec-tools 0.2.2 
Problem Description: 

I setkey with a policy to use esp and ah on each box. I start racoon on each box. I punch up a web 
page on one from the other. Insta-oops x 2. 
 
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02bbd06
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02bbd06>]     Not tainted
EFLAGS: 00010206
EIP is at memcpy+0x1e/0x39
eax: 00000018   ebx: f6fe8a00   ecx: 00000006   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c0562520   esp: f6fb5ccc
ds: 007b    es: 007b  ss:0068
Process racoon (pid: 418, threadinfo=f6fb4000 task=f6fbb300)
Stack:


Call Trace:
 xfrm_state_update
 pfkey_add
 parse_exthdrs
 pfkey_process
 pfkey_sendmsg
 sock_sendmsg
 verify_iovec
 sys_sendmsg
 sockfd_lookup
 sys_sendto
 sys_getsockname
 __pollwait
 update_process
 sys_send
 sys_socketcall
 syscall_call

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 89 d0 8b 74 24 02 8b
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler = not syncing


For some of the other numbers that didn't get copied, check 67.9.9.32/oops.jpg. Email me if its 
dead, which it will be after 20 august.

Steps to reproduce:

> From each box:

# !setkey -f
flush;
spdflush;
spdadd $this_box $other_box any -P out  ipsec esp/transport//use ah/transport//use;
spdadd $other_box $this_box any -P in ipsec esp/transport//use ah/transport//use;

Set up racoon (the default config would probably work, here is the gist of mine)

remote anonymous
{
        exchange_mode main;

        my_identifier address;
        peers_identifier address;

        lifetime time 1 min;    # sec,min,hour

        proposal {
                encryption_algorithm 3des;
                hash_algorithm sha1;
                authentication_method pre_shared_key ;
                dh_group 2;
        }
}

sainfo anonymous
{
        lifetime time 20 min;
        encryption_algorithm 3des ;
        authentication_algorithm hmac_sha1;
        compression_algorithm deflate ;
}

Start racoon on each box. 

Open a new connection to cause a key exchange.

Hit the reset button on each box.


