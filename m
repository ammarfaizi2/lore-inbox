Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291994AbSBOAEm>; Thu, 14 Feb 2002 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291997AbSBOAEd>; Thu, 14 Feb 2002 19:04:33 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:38925 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S291994AbSBOAEV>; Thu, 14 Feb 2002 19:04:21 -0500
Date: Fri, 15 Feb 2002 01:01:49 +0100 (CET)
From: Ulrich Mohr <ue2m@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
cc: davem@caip.rutgers.edu
Subject: PROBLEM: Netfilter inconsistency?
Message-ID: <Pine.HPX.4.44.0202150031110.27588-200000@rzstud1.rz.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="132901567-851401618-1013731309=:27588"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--132901567-851401618-1013731309=:27588
Content-Type: TEXT/PLAIN; charset=US-ASCII

IP Packet data received by netfilter outgoing hook is inconsistent?

Hi,

I think there is an inconsistency in the netfilter implementation. When an
IP Packet is given to a registered hook function, it depends on the packet
data wheter the id field in the ip-header changes after a reinject or not.

When the LOCAL_OUT hook is called via ip_build_and_send_packet or
ip_build_xmit, then ip_select_ident is called prior to the call to
the LOCAL_OUT hook and will not change after the call to the hook.

When the LOCAL_OUT hook is called via ip_queue_xmit, then the
ip_select_ident is called after the call to the netfilter hook, and
the value of the id field in the ip-header changes after a reinject.

You can see this when you register a callback in the LOCAL_OUT and the
LOCAL_IN hook and dump the content of the id field in the ip-header.
When you send a ping to youself, the id field is the same in LOCAL_OUT and
LOCAL_IN. When you send an http request to localhost, the id field changes
between LOCAL_OUT and LOCAL_IN.

In my opinion, all fields in the ip header which are not modified during
transmit should already be set when the netfilter hooks are called. This
is for example necessary if you want to implement a netfilter based
implementation of IP Authentication Header, cause the id field is marked
as immutable in the AH rfc [rc2402]. Changing this field after the call to
the hooks would make it impossible to calculate a authentication sum over
the header and therefore prevent an implementation of AH in netfilter.

I tried to make the call to ip_select_ident before the hooks are called,
and I did not see any side effects (the if field was set directly after
the hook was called anyway on all execution paths, and it did not depend
on any information which was not present prior to the hook was called).
http, scp, ftp & icmp are working fine with this modification.

I insert the patch I did to ip_output.c on Kernel v. 2.4.10.

313,314d312
< 	ip_select_ident(iph, &rt->u.dst, sk);
<
334c332
< 	ip_select_ident(iph, &rt->u.dst, sk);
---
>
391a390
> 	ip_select_ident(iph, &rt->u.dst, sk);


Please set me on the CC when you discuss this issue and/or need more
information.

Thank you,
	Uli

Ulrich Mohr  ***  eMail ue2m@rz.uni-karlsruhe.de
University of Karlsruhe

--132901567-851401618-1013731309=:27588
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ip_queue_xmit.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.HPX.4.44.0202150101490.27588@rzstud1.rz.uni-karlsruhe.de>
Content-Description: 
Content-Disposition: attachment; filename="ip_queue_xmit.diff"

MzEzLDMxNGQzMTINCjwgCWlwX3NlbGVjdF9pZGVudChpcGgsICZydC0+dS5k
c3QsIHNrKTsNCjwgDQozMzRjMzMyDQo8IAlpcF9zZWxlY3RfaWRlbnQoaXBo
LCAmcnQtPnUuZHN0LCBzayk7DQotLS0NCj4gDQozOTFhMzkwDQo+IAlpcF9z
ZWxlY3RfaWRlbnQoaXBoLCAmcnQtPnUuZHN0LCBzayk7DQo=
--132901567-851401618-1013731309=:27588--
