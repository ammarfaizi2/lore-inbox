Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWIVPge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWIVPge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWIVPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:36:34 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:27883 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932601AbWIVPgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:36:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=RQa+fV2AzTFrAD1eT/vCNc0ZdMrZijEARzW4gw4xxk1eOkOL5DI7LEi/YHCjF3D1mIKVduFs0sT/Jqo5F3MYkK6C8jJ+K66ab1Ho7KJ7OQITghMCF0jpYjhcaypIR62p1IQxChg2RZWJm+qTODq3POtSz1wLpAFt6WrWseUnCrI=;
Date: Fri, 22 Sep 2006 19:35:17 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: David Miller <davem@davemloft.net>
Cc: master@sectorb.msk.ru, ak@suse.de, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060922153517.GB24866@ms2.inr.ac.ru>
References: <200609181850.22851.ak@suse.de> <20060918211759.GB31746@tentacle.sectorb.msk.ru> <20060918220038.GB14322@ms2.inr.ac.ru> <20060919.124751.24100694.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919.124751.24100694.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I can't even find a reference to SIOCGSTAMP in the
> dhcp-2.0pl5 or dhcp3-3.0.3 sources shipped in Ubuntu.
> 
> But I will note that tpacket_rcv() expects to always get
> valid timestamps in the SKB, it does a:

It is equally unlikely it uses mmapped packet socket (tpacket_rcv).

I even installed that dhcp on x86_64. And I do not see anything,
netstamp_needed remains zero when running both server and client.
It looks like dhcp was defamed without a guilt. :-)

Seems, Andi saw some leakage in netstamp_needed (value of 7),
but I do not see this too.


In any case, the issue is obviously more serious than just behaviour
of some applications. On my notebook one gettimeofday() takes:

	0.2 us with tsc
	4.6 us with pm  (AND THIS CRAP IS DEFAULT!!)
	9.4 us with pit (kinda expected)

It is ridiculous. Obviosuly, nobody (not only tcpdump, but everything
else) does not need such clock. Taking timestamp takes time comparable
with processing the whole tcp frame. :-) I have no idea what is possible
to do without breaking everything, but it is not something to ignore.
This timer must be shot. :-)

Alexey
