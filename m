Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVCVXvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVCVXvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVCVXvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:51:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59539 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262447AbVCVXvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:51:33 -0500
Message-ID: <4240AF8B.4000102@engr.sgi.com>
Date: Tue, 22 Mar 2005 15:51:39 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Ram <linuxram@us.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Erich Focht <efocht@hpce.nec.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>	<200503170856.57893.jbarnes@engr.sgi.com>	<20050318003857.4600af78@zanzibar.2ka.mipt.ru>	<200503171405.55095.jbarnes@engr.sgi.com>	<1111409303.8329.16.camel@frecb000711.frec.bull.fr>	<1111438349.5860.27.camel@localhost>	<1111475252.8465.23.camel@frecb000711.frec.bull.fr>	<1111515979.5860.57.camel@localhost> <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Tue, 22 Mar 2005 10:26:19 -0800
> Ram <linuxram@us.ibm.com> wrote:
> 
> 
>>On Mon, 2005-03-21 at 23:07, Guillaume Thouvenin wrote:
>>
>>>On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
>>>
>>>>     If a bunch of applications are listening for fork events, 
>>>>     your patch allows any application to turn off the 
>>>>     fork event notification?  Is this the right behavior?
>>>
>>>Yes it is. The main management is done by application so, if several
>>>applications are listening for fork events you need to choose which one
>>>will turn off the fork connector. 
>>>
>>>I want to keep this turn on/off mechanism simple but if it's needed I
>>>can manage the variable "cn_fork_enable" as a counter. Thus the callback
>>>could be something like:
>>>
>>>static void cn_fork_callback(void *data)
>>>{
>>>  int start; 
>>>  struct cn_msg *msg = (struct cn_msg *)data;
>>>
>>>  if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
>>>    memcpy(&start, msg->data, sizeof(cn_fork_enable));
>>>    if (start)
>>>      cn_fork_enable++;
>>>    else
>>>      cn_fork_enable > 0 ? cn_fork_enable-- : 0;
>>>  }
>>>}
>>
>>I think a better way is:
>>
>>   Providing a different connector channel called the administrator 
>>   channel which can be used only by a super-user, and gives you
>>   the ability to switch on or off any connector channel including the
>>   fork-connector channel.
> 
> 
> Only super-user can bind netlink socket to multicast group.
> 
> 
>>   For lack of better term I am using the word 'channel' to mean
>>   something that carries events of particular type through the
>>   connector-infrastructure.
> 
> 
> I still do not see why it is needed.
> Super-user can run ip command and turn network interface off
> not waiting while apache or named exits or unbind.

You can turn off a network interface and turn it back on without
closing a network application and it will continue to work.

> 
> In theory I can create some kind of userspace registration mechanism,
> when userspace application reports it's pid to the connector, 
> and then it sends data to the specified pids, but does not 
> allow controlling from userspace.
> But I really do not think it is a good idea to permit
> non-priviledged userspace processes to know about deep
> kernel internals through connector's messages.

I see this issue less a case of bad guys vs. good guys. I see it
as various components doing system related work, but there is
no mechanism of knowing who is on who is off by today's patch. A
service listening to the fork connector can request to turn off
cn_fork_enable on exit and inadquately affect other services/daemons
listening to the same connector. It is not acceptable in my opinion.

The idea of implementing fork connector enabling/disabling was so
that the kernel does not waste time writing to the sockets if no
application listening. If implementing such a feature costs
more than it saves, maybe the fork connector should simply always
send?

Thanks,
- jay


> 
> 
>>RP
>>
>>
>>
>>>
>>>What do you think about this implementation? 
>>>
>>>Guillaume
>>>
> 
> 
> 
> 	Evgeniy Polyakov
> 
> Only failure makes us experts. -- Theo de Raadt

