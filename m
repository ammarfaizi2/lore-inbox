Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVFQBhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVFQBhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVFQBhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:37:51 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:36003 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261884AbVFQBhj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:37:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4IcV2KS2S9AgFWNmq2F7za7FCjyfvE/XRCdb2sJXNgZ/0sUiYibDJNxfXqwUVCTaPnc+h3pOrZqdbnctKO3L5TdzbVjM7vGyMebaiNxHDvQKSNxisKpmZpnM48nZ8FCkfSoOLCnEK/mpRhgKQv8EltYS07gfCnIeW9ol9S00GY=
Message-ID: <ca992f1105061618376e64788c@mail.gmail.com>
Date: Fri, 17 Jun 2005 10:37:37 +0900
From: junjie cai <junjiec@gmail.com>
Reply-To: junjie cai <junjiec@gmail.com>
To: paulmck@us.ibm.com
Subject: Re: is synchronize_net in inet_register_protosw necessary?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, shemminger@osdl.org
In-Reply-To: <20050616220726.GA1862@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ca992f11050614071857cd069b@mail.gmail.com>
	 <20050616171502.GA1321@us.ibm.com> <20050616220726.GA1862@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,Paul,

Thank you very much for your reply.
So may I think that it would be ok to remove the synchronize_net 
from  inet_register_protosw on a UP platform?
I am doing embeded development so I don't have SMP to do the test.
I think it is ok for me to do just local modify to fit our needs.
Thanks again.
                                 junjie

On 6/17/05, Paul E. McKenney <paulmck@us.ibm.com> wrote:
> On Thu, Jun 16, 2005 at 10:15:02AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 14, 2005 at 11:18:08PM +0900, junjie cai wrote:
> > > hi all.
> > > i am a newbie to linux kernel.
> > > in a arm926 board i found that it took about 30ms to finish
> > > the (net/ipv4/af_inet.c:898) inet_register_protosw
> > > because of the synchronize_net call during profiling.
> > > synchronize_net finally calls synchronize_rcu, so i think
> > > this is to make the change visiable after a list_add_rcu.
> > > but according to the Document/listRCU.txt it seems that
> > > a list insertation does not necessarily do call_rcu etc.
> > > may i have any mistakes, please kindly tell me.
> >
> > From a strict RCU viewpoint, you are quite correct.  But sometimes
> > the overall locking protocol (which almost always includes other things
> > besides just RCU) places additional constraints on the code.  My guess is
> > that the networking folks needed to ensure that the new protocol is seen
> > by all packets that are received after inet_register_protosw() returns.
> >
> > But I need to defer to networking guys on this one.
> 
> Hello, Junjie,
> 
> Ran into one of the networking guys off-list.  Apparently, the
> synchronize_net() is there out of paranoia.  It might be necessary,
> but he could not think of a reason for its being there.  If you want
> to shave 30ms off of your boot time by removing it, here is his
> suggested test procedure:
> 
> o       Write a small dummy protocol as a module.
> 
> o       On an SMP machine, have one process repeated modprobe/rmmod
>         while another process repeatedly does socket() calls for
>         the dummy protocol.
> 
>                                                         Thanx, Paul
>
