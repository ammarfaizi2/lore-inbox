Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTDSCAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 22:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTDSCAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 22:00:25 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:2057 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263336AbTDSCAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 22:00:23 -0400
Date: Sat, 19 Apr 2003 11:12:38 +0900 (JST)
Message-Id: <20030419.111238.07385967.yoshfuji@wide.ad.jp>
To: davem@redhat.com
Cc: latten@austin.ibm.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: IPsecv6 integrity failures not dropped
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030418.141014.17269641.davem@redhat.com>
References: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
	<20030418.141014.17269641.davem@redhat.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030418.141014.17269641.davem@redhat.com> (at Fri, 18 Apr 2003 14:10:14 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:

> I think it would be better if ipv6's upper-layer interface worked
> like ipv4's.  ie. a < 0 return value means:
> 
> 	next_proto =- ret;
> 	goto resubmit;

NO!  Please, don't do this again (for now, at least).
This idea is what we had introduced the bug,
that was fixed by "[IPV6]: Fixed multiple mistake extension header handling."

We need to get the offset of the next header, in addition to the value
itself.

inet6_protocol function will return:

  > 0: more header(s) follows; next header is pointed by skb->nh.raw[nhoff]
  = 0: stop parsing on success; increment the statistics (nhoff is undefined)
  < 0: stop parsing on failure (nhoff is undefined)

If upper-layer returns positive value, we continue parsing.
Then, if the skb->nh.raw[nhoff] is unknown, we send back the parameter problem 
message with the offset to the unrecognized next header field.


> The less that is different between ipv4/ipv6 the better.

Agreed, but please note that IPv4 side would be required to be changed
in general.


Well... 

1) May we have a new member to point the offset of the next header in 
   ipv6_pinfo{}?
   Then, we can remove *nhoffp from argument of inet6_protocol function.
   (We will be cleaner handing of HbH option, too.)
2) change IPv4 upperlayer function to take struct sk_buff **.


If you are not in hurry, I'll take care of this.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
