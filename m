Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVCCD2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVCCD2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVCCDVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:21:33 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:54768 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261439AbVCCDRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:17:50 -0500
Message-ID: <42268201.80706@ak.jp.nec.com>
Date: Thu, 03 Mar 2005 12:18:25 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>, Netlink List <netdev@oss.sgi.com>
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr> <1109753292.8422.117.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1109753292.8422.117.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/mixed;
 boundary="------------060300030509070400060409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300030509070400060409
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello, Guillaume

I tried to measure the process-creation/destruction performance on 2.6.11-rc4-mm1 plus
some extensiton(Normal/with PAGG/with Fork-Connector).
But I received a following messages endlessly on system console with Fork-Connector extensiton.

# on IA-64 environment / When an simple fork() iteration is run in parallel.
skb does not have enough length: requested msg->len=10[28], nlh->nlmsg_len=48[32], skb->len=48[must be 30].
skb does not have enough length: requested msg->len=10[28], nlh->nlmsg_len=48[32], skb->len=48[must be 30].
skb does not have enough length: requested msg->len=10[28], nlh->nlmsg_len=48[32], skb->len=48[must be 30].
  :

Is's generated at drivers/connector/connector.c:__cn_rx_skb(), and this warn the length of msg's payload
does not fit in nlmsghdr's length.
This message means netlink packet is not sent to user space.
I was notified occurence of fork() by printk(). :-(

The attached simple *.c file can enable/disable fork-connector and listen the fork-notification.
Because It's first experimence for me to write a code to use netlink, point out a right how-to-use
if there's some mistakes at user side apprication.

Thanks.

P.S. I can't reproduce lockup on 367th-fork() with your latest patch.

Guillaume Thouvenin wrote:
>   ChangeLog:
> 
>     - Add parenthesis around sizeof(struct cn_msg) + CN_FORK_INFO_SIZE
>       in the CN_FORK_MSG_SIZE macro
>     - fork_cn_lock is declareed with DEFINE_SPINLOCK()
>     - fork_cn_lock is defined as static and local to fork_connector()
>     - Create a specific module cn_fork.c in drivers/connector to
>       register the callback.
>     - Improve the callback that turns on/off the fork connector
> 
>   I also run the lmbench and results are send in response to another
> thread "A common layer for Accounting packages". When fork connector is
> turned off the overhead is negligible. This patch works with another
> small patch that fix a problem in the connector. Without it, there is a
> message that says "skb does not have enough length". It will be fix in
> the next -mm tree I think.
> 
> 
> Thanks everyone for the comments,
> Guillaume

-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------060300030509070400060409
Content-Type: text/plain;
 name="fclisten.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fclisten.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8YXNtL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2lu
Y2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPGxpbnV4L25ldGxpbmsuaD4KCnZvaWQg
dXNhZ2UoKXsKICBwdXRzKCJ1c2FnZTogZmNsaXN0ZW4gPG9ufG9mZj4iKTsKICBwdXRzKCIg
IERlZmF1bHQgLT4gbGlzdGVuaW5nIGZvcmstY29ubmVjdG9yIik7CiAgcHV0cygiICBvbiAg
ICAgIC0+IGZvcmstY29ubmVjdG9yIEVuYWJsZSIpOwogIHB1dHMoIiAgb2ZmICAgICAtPiBm
b3JrLWNvbm5lY3RvciBEaXNhYmxlIik7CiAgZXhpdCgwKTsKfQoKI2RlZmluZSBNT0RFX0xJ
U1RFTiAgKDEpCiNkZWZpbmUgTU9ERV9FTkFCTEUgICgyKQojZGVmaW5lIE1PREVfRElTQUJM
RSAoMykKCnN0cnVjdCBjYl9pZAp7CiAgX191MzIgICAgICAgICAgICAgICAgICAgaWR4Owog
IF9fdTMyICAgICAgICAgICAgICAgICAgIHZhbDsKfTsKCnN0cnVjdCBjbl9tc2cKewogIHN0
cnVjdCBjYl9pZCAgICAgICAgICAgIGlkOwogIF9fdTMyICAgICAgICAgICAgICAgICAgIHNl
cTsKICBfX3UzMiAgICAgICAgICAgICAgICAgICBhY2s7CiAgX191MzIgICAgICAgICAgICAg
ICAgICAgbGVuOyAgICAgICAgICAgIC8qIExlbmd0aCBvZiB0aGUgZm9sbG93aW5nIGRhdGEg
Ki8KICBfX3U4ICAgICAgICAgICAgICAgICAgICBkYXRhWzBdOwp9OwoKCmludCBtYWluKGlu
dCBhcmdjLCBjaGFyICphcmd2W10pewogIGNoYXIgYnVmWzQwOTZdOwogIGludCBtb2RlLCBz
b2NrZmQsIGxlbjsKICBzdHJ1Y3Qgc29ja2FkZHJfbmwgYWQ7CiAgc3RydWN0IG5sbXNnaGRy
ICpoZHIgPSAoc3RydWN0IG5sbXNnaGRyICopYnVmOwogIHN0cnVjdCBjbl9tc2cgKm1zZyA9
IChzdHJ1Y3QgY25fbXNnICopKGJ1ZitzaXplb2Yoc3RydWN0IG5sbXNnaGRyKSk7CiAgCiAg
c3dpdGNoKGFyZ2MpewogIGNhc2UgMToKICAgIG1vZGUgPSBNT0RFX0xJU1RFTjsKICAgIGJy
ZWFrOwogIGNhc2UgMjoKICAgIGlmIChzdHJjYXNlY21wKCJvbiIsYXJndlsxXSk9PTApIHsK
ICAgICAgbW9kZSA9IE1PREVfRU5BQkxFOwogICAgfWVsc2UgaWYgKHN0cmNhc2VjbXAoIm9m
ZiIsYXJndlsxXSk9PTApewogICAgICBtb2RlID0gTU9ERV9ESVNBQkxFOwogICAgfWVsc2V7
CiAgICAgIHVzYWdlKCk7CiAgICB9CiAgICBicmVhazsKICBkZWZhdWx0OgogICAgdXNhZ2Uo
KTsKICAgIGJyZWFrOwogIH0KICAKICBpZiggKHNvY2tmZD1zb2NrZXQoUEZfTkVUTElOSywg
U09DS19SQVcsIE5FVExJTktfTkZMT0cpKSA8IDAgKXsKICAgIGZwcmludGYoc3RkZXJyLCAi
RmF1bHQgb24gc29ja2V0KCkuXG4iKTsKICAgIHJldHVybiggMSApOwogIH0KICBhZC5ubF9m
YW1pbHkgPSBBRl9ORVRMSU5LOwogIGFkLm5sX3BhZCA9IDA7CiAgYWQubmxfcGlkID0gZ2V0
cGlkKCk7CiAgYWQubmxfZ3JvdXBzID0gLTE7CiAgaWYoIGJpbmQoc29ja2ZkLCAoc3RydWN0
IHNvY2thZGRyICopJmFkLCBzaXplb2YoYWQpKSApewogICAgZnByaW50ZihzdGRlcnIsICJG
YXVsdCBvbiBiaW5kIHRvIG5ldGxpbmsuXG4iKTsKICAgIHJldHVybiggMiApOwogIH0KCiAg
aWYgKG1vZGU9PU1PREVfTElTVEVOKSB7CiAgICB3aGlsZSgtMSl7CiAgICAgIGxlbiA9IHJl
Y3Zmcm9tKHNvY2tmZCwgYnVmLCA0MDk2LCAwLCBOVUxMLCBOVUxMKTsKICAgICAgcHJpbnRm
KCIlZC1ieXRlIHJlY3YgU2VxPSVkXG4iLCBsZW4sIGhkci0+bmxtc2dfc2VxKTsKICAgIH0K
ICB9ZWxzZXsKICAgIGFkLm5sX2ZhbWlseSA9IEFGX05FVExJTks7CiAgICBhZC5ubF9wYWQg
PSAwOwogICAgYWQubmxfcGlkID0gMDsKICAgIGFkLm5sX2dyb3VwcyA9IDE7CiAgICAKICAg
IGhkci0+bmxtc2dfbGVuID0gc2l6ZW9mKHN0cnVjdCBubG1zZ2hkcikgKyBzaXplb2Yoc3Ry
dWN0IGNuX21zZykgKyBzaXplb2YoaW50KTsKICAgIGhkci0+bmxtc2dfdHlwZSA9IDA7CiAg
ICBoZHItPm5sbXNnX2ZsYWdzID0gMDsKICAgIGhkci0+bmxtc2dfc2VxID0gMDsKICAgIGhk
ci0+bmxtc2dfcGlkID0gZ2V0cGlkKCk7CiAgICBtc2ctPmlkLmlkeCA9IDB4ZmVlZDsKICAg
IG1zZy0+aWQudmFsID0gMHhiZWVmOwogICAgbXNnLT5zZXEgPSBtc2ctPmFjayA9IDA7CiAg
ICBtc2ctPmxlbiA9IHNpemVvZihpbnQpOwoKICAgIGlmIChtb2RlPT1NT0RFX0VOQUJMRSl7
CiAgICAgICgqKGludCAqKShtc2ctPmRhdGEpKSA9IDE7CiAgICB9IGVsc2UgewogICAgICAo
KihpbnQgKikobXNnLT5kYXRhKSkgPSAwOwogICAgfQogICAgc2VuZHRvKHNvY2tmZCwgYnVm
LCBzaXplb2Yoc3RydWN0IG5sbXNnaGRyKStzaXplb2Yoc3RydWN0IGNuX21zZykrc2l6ZW9m
KGludCksCgkgICAwLCAoc3RydWN0IHNvY2thZGRyICopJmFkLCBzaXplb2YoYWQpKTsKICB9
Cn0K
--------------060300030509070400060409--

