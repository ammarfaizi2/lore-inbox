Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWCXONi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWCXONi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWCXONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:13:37 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:51651 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S932633AbWCXONd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:13:33 -0500
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink
	interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060323154106.GA13159@in.ibm.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
	 <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
	 <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2>
	 <20060323154106.GA13159@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Fri, 24 Mar 2006 09:04:21 -0500
Message-Id: <1143209061.5076.14.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-23-03 at 21:11 +0530, Balbir Singh wrote:
> On Thu, Mar 23, 2006 at 09:04:46AM -0500, jamal wrote:

> > Should there be at least either a pid or tgid? If yes, you need to
> > validate here...
> >
> 
> Yes, you are correct. One of my test cases caught it too.. But I did
> not want to untidy the code with if-else's which will keep growing if
> the attributes change in the future. I just followed the controller
> example. I will change it and validate it. Currently if the attribute
> is not valid, a stat of all zero's is returned back.
>  

There are many ways to skin this cat.
As an example: you could make pid and tgid global to the function and
set them to 0. At the end of the if statements, you could check if at
least one of them is set - if not you know none was passed and bail out.

> > As a general comment double check your logic for errors; if you already
> > have stashed something in the skb, you need to remove it etc.
> > 
> 
> Wouldn't genlmsg_cancel() take care of cleaning all attributes?
> 

it would for attribute setting - but not for others. As a general
comment this is one of those areas where cutnpasting aka TheLinuxWay(tm)
could result in errors.


> > A single message with PID+TGID sounds reasonable. Why two messages with
> > two stats? all you will need to do is get rid of the prepare_reply()
> > above and NLA_PUT_U32() below (just like you do in a response to a GET.
> > 
> 
> The reason for two stats is that for TGID, we return accumulated values
> (of all threads in the group) and for PID we return the value just
> for that pid. The return value is
> 

Ok, I understand the dilemma now - but still not thrilled with having
two messages.
Perhaps you could have nesting of TLVs? This is widely used in the net
code for example
i.e:

TLV = TASKSTATS_TYPE_TGID/PID
    TLV = TASKSTATS_TYPE_STATS

Look at using nla_nest_start/end/cancel

cheers,
jamal

