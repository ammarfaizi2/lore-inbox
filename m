Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUEQAn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUEQAn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEQAn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:43:27 -0400
Received: from mail41-s.fg.online.no ([148.122.161.41]:18638 "EHLO
	mail41-s.fg.online.no") by vger.kernel.org with ESMTP
	id S263640AbUEQAnM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:43:12 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <keaafloy@online.no>
To: linux-kernel@vger.kernel.org
Subject: Strange NFS behavior (?)
Date: Mon, 17 May 2004 02:43:18 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405170243.18245.keaafloy@online.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please grab the closest baseball bat and use it on my head if i'm somewhat 
immature with my posting. I've basically tried to get an answer on the 
netfilter-devel list on this subject, since this part of the linux kernel 
seems to pick up the error (though, it might not be located anywhere near 
that part).

I'm unsure if I should use the guidelines at kernel,org and post a complete 
description of my system or not. I choose not to, but I will do if anybody 
asks me to do so.

(please read the message and replys below)

Also, as stated in the last reply by me (below), this is probably just user 
knowhow, and should probably be disregarded as a kernel error (?), but my 
question is:

Why does not the NFS code (server or client) try to either limit or increase 
the buffer size when performance is at least 10x slower than that of the 
medium it's mounted on, and no other load is present? And why is the 
performance really so bad with higher r/wsize?

Regards,
Kenneth
(This is my first post to linux-kernel, and I take away any responsibility 
that this message is sane in any way ;)

--- Original Post To NetFilter Devel ---
I've come across some strange behavior with a nfs server running on 2.6.6-rc3 
today. My clients is also running this version. Basically when I set the NFS 
client r/wsize = 8192, or remove the connection tracking netfilter modules 
the problem goes away. If I set the r/wsize to 16834 and the conntrack module 
is loaded I end up in the code segment below. When this happens the NFS 
client will almost lose connection with the server, and print a lot of;
NFS server not responding, still trying. NFS server OK.

I've also tried 2.6.5, and the error is present there too, but not the segment 
below, so I got no warning. I have not yet tried any lower version of the 
kernel yet, but will do so if it's requested. I could also have provided you 
with extensive information about my setup's, but I belive it's a minor 
problem with the reassembly of fragmented packets. 

ip_conntrack_core.c:798
    /* Never happen */
    if ((*pskb)->nh.iph->frag_off & htons(IP_OFFSET)) {
        if (net_ratelimit()) {
        printk(KERN_ERR "ip_conntrack_in: Frag of proto %u (hook=%u)\n",
               (*pskb)->nh.iph->protocol, hooknum);
        }
        return NF_DROP;
    }

Does anybody have a solution for the problem exept making (manually) sure that 
any client does not request a r/wsize above 8192?

---- Reply #1: ----
I'm seeing this to on a 2.4.22 kernel. I didn't change anything on the 
r/wsize, so I have the default of 4096, I think. Both have conntrack loa=
ded.

Martijn Lievaart

---- Reply #2: ----
Could you test this patch? If it triggers we know that we still have
fragmented packets after defrag, which we shouldn't.

--- linux-2.6.6-rc3/net/ipv4/netfilter/ip_conntrack_standalone.c.orig=09200=
4-05-07 12:22:36.000000000 +0200
+++ linux-2.6.6-rc3/net/ipv4/netfilter/ip_conntrack_standalone.c=092004-05-=
07 12:24:37.000000000 +0200
@@ -211,6 +211,10 @@
 =09=09if (!*pskb)
 =09=09=09return NF_STOLEN;
 =09}
+
+=09if ((*pskb)->nh.iph->frag_off & htons(IP_MF|IP_OFFSET))
+=09=09printk(KERN_ERR "ip_conntrack_defrag: packet still fragmented after =
defrag!\n");
+
 =09return NF_ACCEPT;
 }

/Martin

---- My response (no replys as of this moment): ----
This patch does not trigger any suspicious behaviour. I also have done some 
additional testing (must have been half asleep last time), and I've found 
that I only end up in the "ip_conntrack_in: Frag of proto %u" code if I mount 
a nfs share locally, and that this local share will stall completly if the 
conntrack module is loaded. If I mount the share from a remote client, it 
will work just fine. Is this a bug or just me doing to little reading?

About the slowness of NFS from remote clients, this is just because the 
default r/wsize is to high for the wireless card I was using. Sorry for not 
checking more thoroughly and not reading the HOWTOs!
---- End ----
