Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWCXOzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWCXOzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWCXOzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:55:22 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:22418 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932093AbWCXOzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:55:20 -0500
Date: Fri, 24 Mar 2006 20:24:59 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Message-ID: <20060324145459.GA7495@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142296834.5858.3.camel@elinux04.optonline.net> <1142297791.5858.31.camel@elinux04.optonline.net> <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2> <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2> <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143209061.5076.14.camel@jzny2>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 09:04:21AM -0500, jamal wrote:
> On Thu, 2006-23-03 at 21:11 +0530, Balbir Singh wrote:
> > On Thu, Mar 23, 2006 at 09:04:46AM -0500, jamal wrote:
> 
> > > Should there be at least either a pid or tgid? If yes, you need to
> > > validate here...
> > >
> > 
> > Yes, you are correct. One of my test cases caught it too.. But I did
> > not want to untidy the code with if-else's which will keep growing if
> > the attributes change in the future. I just followed the controller
> > example. I will change it and validate it. Currently if the attribute
> > is not valid, a stat of all zero's is returned back.
> >  
> 
> There are many ways to skin this cat.
> As an example: you could make pid and tgid global to the function and
> set them to 0. At the end of the if statements, you could check if at
> least one of them is set - if not you know none was passed and bail out.

The latest patch does fix it this issue. In the Changelog
6. taskstats_send_stats() now validates the command attributes and ensures
  that it either gets a PID or a TGID. If it gets both simultaneously
  the PID stats are sent.

Is this change ok with you?

> 
> > > As a general comment double check your logic for errors; if you already
> > > have stashed something in the skb, you need to remove it etc.
> > > 
> > 
> > Wouldn't genlmsg_cancel() take care of cleaning all attributes?
> > 
> 
> it would for attribute setting - but not for others. As a general
> comment this is one of those areas where cutnpasting aka TheLinuxWay(tm)
> could result in errors.

:-) I understand.
What I have done is moved all the NLA_PUT_U32 to after verifying the
return values of functions fill_*(). That way we do not stash anything into the
skb if there are pending errors.

> 
> 
> > > A single message with PID+TGID sounds reasonable. Why two messages with
> > > two stats? all you will need to do is get rid of the prepare_reply()
> > > above and NLA_PUT_U32() below (just like you do in a response to a GET.
> > > 
> > 
> > The reason for two stats is that for TGID, we return accumulated values
> > (of all threads in the group) and for PID we return the value just
> > for that pid. The return value is
> > 
> 
> Ok, I understand the dilemma now - but still not thrilled with having
> two messages.
> Perhaps you could have nesting of TLVs? This is widely used in the net
> code for example
> i.e:
> 
> TLV = TASKSTATS_TYPE_TGID/PID
>     TLV = TASKSTATS_TYPE_STATS
> 
> Look at using nla_nest_start/end/cancel

Hmm... Would it be ok to send one message with the following format

1. TLV=TASKSTATS_TYPE_PID
2. TLV=TASKSTATS_TYPE_STATS
3. TLV=TASKSTATS_TYPE_TGID
4. TLV=TASKSTATS_TYPE_STATS

It would still be one message, except that 3 and 4 would be optional.
What do you think?

> 
> cheers,
> jamal

Thanks for your comments,
Balbir
