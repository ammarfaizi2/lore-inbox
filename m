Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbULIAjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbULIAjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbULIAjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:39:17 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:46330 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S261413AbULIAiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:38:20 -0500
Message-ID: <41B79DC3.2000607@inostor.com>
Date: Wed, 08 Dec 2004 16:35:15 -0800
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Kernel Panic removing psnap or p8022 module in 2.4.28  (appletalk
 dependencies)
References: <41B75BBF.8070004@inostor.com> <41B76130.8030607@inostor.com> <20041208162436.GA3356@dmt.cyclades>
In-Reply-To: <20041208162436.GA3356@dmt.cyclades>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thank you for your quick response! We've applied this patch to three of our
systems, and it seems to be working. We're going to run multiple reboot tests
tonight, and will report on the results tomorrow.

I will also attempt to see if psnap rmmoding can cause a similar instance.

Marcelo Tosatti wrote:
| On Wed, Dec 08, 2004 at 12:16:48PM -0800, Tom Dickson wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Next time I promise to finish the report before hitting send.
|>
|>I'm using a Gentoo Linux system with the vanilla 2.4.28 sources installed.
|>The
|>attached config file is what I'm using.
|>
|>appletalk.o now has a dependency it didn't have in 2.4.26, which are the
|>modules
|>psnap.o and p8022.o, which I can't find how to disable.
|
|
| appletalk.o requires psnap.o and p8022.o, before 2.4.27 they were always builtin
| the kernel if appletalk was selected.
|
| So the change to have them as modules just uncovers the bug.
|
|
|>If I start netatalk, it modprobes appletalk.o, which loads psnap.o and
|>p8022.o. If
|>I then stop appletalk, it removes appletalk.o (which works) and then
|>psnap.o and
|>p8022.o (which kernel panics).
|>
|>I can also get the kernel panic by modprobing p8022.o and then rmmodding it.
|>
|>The kernel panic is as follows:
|>
|>Oops: 0000
|>CPU:    0
|>EIP:    0010:[<c0238490>]    Not tainted
|>EFLAGS: 00010286
|>eax: 00000004   ebx: cc84a3c0   ecx: 41b75c48   edx: c1363b28
|>esi: cb6d65e0   edi: 00000400   ebp: 00013b56   esp: c030bf18
|>ds: 0018   es: 0018   ss: 0018
|>Process swapper (pid: 0. stackpage=c030b000)
|>Stack: c030bfa0 0000e401 cc841cfd cbcbb400 00000000 00000040 c0238623
|>cb6d65e0
|>~       c0324d6c c0324ca8 00013b56 00000046 c0238734 c0324ca8 c030bf54
|>0000012c
|>~       00000001 c0324b70 fffffffb c011c775 c0324b70 c03249a0 00000005
|>c134ec60
|>Call Trace:    [<cc841cfd>] [<c0238623>] [<c0238734>] [<c011c775>]
|>[<c010a5fa>]
|>~  [<c0106f30>] [<c010c978>] [<c0106f30>] [<c0106f53>] [<c0106fe2>]
|>[<c0105000>]
|>
|>Code: 66 39 3b 74 60 8b 5b 10 85 db 75 f4 85 d2 74 36 8b 7a 0c 85
|>~ <0>Kernel panic: Aiee, killing interrupt hander!
|>In interrupt handler - not syncing
|>
|>This is a problem because we can't shutdown the machine without this
|>occurring. It
|>seems that if we disable ipchains in the kernel, it goes away. It also
|>occurs with
|>the 2.4.27 kernel.
|
|
| The problem is that p8022 does not unregister the packet type it has registered
| on startup, so once a p8022 packet is received netif_receive_skb() tries to access
| an address from the module which is now unloaded, boom.
|
| Can you please try the following untested patch
|
|
| --- a/net/802/p8022.c.orig	2004-12-08 14:19:38.000000000 -0200
| +++ b/net/802/p8022.c	2004-12-08 14:21:40.000000000 -0200
| @@ -97,7 +97,14 @@
|  	return 0;
|  }
|
| +static void __exit p8022_exit(void)
| +{
| +	dev_remove_pack(&p8022_packet_type);
| +	return;
| +}
| +
|  module_init(p8022_init);
| +module_exit(p8022_exit);
|
|  struct datalink_proto *register_8022_client(unsigned char type, int
(*rcvfunc)(struct sk_buff *, struct net_device *, struct packet_type *))
|  {
|
| .
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBt53D2dxAfYNwANIRAn5XAJ9b2R0/rfWpDG/GGAv4bhGyAWMCowCfSPie
0yE1PKPGToG6VgFMx7veMS4=
=1WKd
-----END PGP SIGNATURE-----
