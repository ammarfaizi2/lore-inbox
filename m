Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUIPJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUIPJec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUIPJeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:34:25 -0400
Received: from ender.smtp.cz ([81.95.97.119]:42880 "EHLO out.smtp.cz")
	by vger.kernel.org with ESMTP id S267918AbUIPJdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:33:53 -0400
Subject: Minor IPSec bug + solution
From: Martin Bouzek <martin.bouzek@radas-atc.cz>
Reply-To: martin.bouzek@radas-atc.cz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Radas, s.r.o.
Message-Id: <1095327372.4466.87.camel@mabouzek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 Sep 2004 11:36:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was setting up an VPN via IPSec in kernel 2.6.x on IPv4 and found the
following bug. It is not possible to set up an IPComp/ESP tunnel with
IPComp set as mandatory. The following setup works fine for me:

spdadd 192.168.1.0/24 192.168.2.0/24 any -P out ipsec
           ipcomp/tunnel/192.168.1.100-192.168.2.212/use
           esp/tunnel/192.168.1.100-82.99.145.1/require;

(IPs are little bit confusing, because computers are behing NAT and the
pair SP is not shown, because it is not important)

But the following one is not working:

spdadd 192.168.1.0/24 192.168.2.0/24 any -P out ipsec
           ipcomp/tunnel/192.168.1.100-192.168.2.212/require
           esp/tunnel/192.168.1.100-82.99.145.1/require;



Of course it is possible to use the first setup, but I found that
problem was in "require" for IPComp only after quite a while of
debugging. :-) 

The later setup is not working, because all IP-IP packets are droped by 
__xfrm_policy_check function, because of error in xfrm_state_ok
function. For tunnels it returns 

tmpl->optional && !xfrm_state_addr_cmp(tmpl, x, family);

but it should return 

tmpl->optional || !xfrm_state_addr_cmp(tmpl, x, family);

The packet should pass policy check if either the policy is optional OR
the source address match. The code says that check pass if policy is
optional AND the address match, which is obviously wrong. IMHO it is the
reason, why I have to set this "use" for IPComp tunnel.

So the problem is in file "net/xfrm/xfrm_policy.c" in function
"xfrm_state_ok" - on line 868 in 2.6.8.1 kernel. It seems to me to
trivial change to create a patch.


I am not sure where I shall send this mail. As I said, it is a minnor
bug, and it is possible to set up things working even with it.
Nevertheless it would be nice to have it fixed. Can somebody help me,
where I shall send it?

Thanks.
- Martin Bouzek
- martin.bouzek@radas-atc.cz


