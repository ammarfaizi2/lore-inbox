Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbTFNFDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbTFNFDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:03:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60829 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265615AbTFNFDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:03:33 -0400
Message-ID: <3EEAAFA6.9080609@us.ibm.com>
Date: Fri, 13 Jun 2003 22:16:22 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: anton@samba.org, haveblue@us.ibm.com, hdierks@us.ibm.com,
       scott.feldman@intel.com, dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       milliner@us.ibm.com, ricardoz@us.ibm.com, twichell@us.ibm.com,
       netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
References: <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com>	<1055521263.3531.2055.camel@nighthawk>	<20030613223841.GB32097@krispykreme> <20030613.154634.74748085.davem@redhat.com>
In-Reply-To: <20030613.154634.74748085.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Anton Blanchard <anton@samba.org>
>    Date: Sat, 14 Jun 2003 08:38:41 +1000
>    
>    This is only worth it if most packets will have the same sized header.
>    Networking guys: is this a valid assumption?
> 
> Not really... one retransmit and the TCP header size grows
> due to the SACK options.

Yep, but it really doesn't have too many options (sic pun ;))..
i.e. The max the options can add are 40 bytes, speaking
strictly TCP, not IP. This really should fit into one extra
cacheline for most architectures, at most, right?

[The TCP options have to end and the data start on a 32
bit boundary. For established connections, we're
principally talking SACK options and v. likely timestamp.
(Ignoring those egregious benchmark guys who turn everything
useful off ;)). SYNs wont have data in any case.

So its going to grow by (SACK = 8*n + 2)+ (TS = 10) bytes,
with n = number of sack options, with a max of n = 3
if timestamps are enabled. Adding that to the standard
length of 20 bytes, the total len of a TCP header is thus
very likely one of:
	20  + [ 0 | 20 |32 | 36] bytes
	= 20 | 40 | 52 | 56 bytes.

If cachelines were 64 bytes, we wouldnt be wasting a
whole lot of space if we aligned data start or some
other scheme as was suggested. Even given the larger
cachelines, it might be worth it, or is this totally
not an option (cough,sic ;))?

> I find it truly bletcherous what you're trying to do here.

yep

thanks,
Nivedita



