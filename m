Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVCVSSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVCVSSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCVSQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:16:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40341 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261494AbVCVSO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:14:57 -0500
Message-ID: <424060DE.4050701@engr.sgi.com>
Date: Tue, 22 Mar 2005 10:15:58 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Ram <linuxram@us.ibm.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Erich Focht <efocht@hpce.nec.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>	 <200503170856.57893.jbarnes@engr.sgi.com>	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>	 <200503171405.55095.jbarnes@engr.sgi.com>	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>	 <1111438349.5860.27.camel@localhost> <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:
> On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
> 
>>     If a bunch of applications are listening for fork events, 
>>     your patch allows any application to turn off the 
>>     fork event notification?  Is this the right behavior?
> 
> 
> Yes it is. The main management is done by application so, if several
> applications are listening for fork events you need to choose which one
> will turn off the fork connector. 

It is not practical. One listener never know who else are listening
to the fork connector.

We also need to protect yet another global variable "cn_fork_enable".

Also, in order to implement "cn_fork_enable" as a counter, we need
some sort of registration to prevent an application from sending
repeated "off" notification. One can only turn off its own switch.

Thanks,
  - jay

> 
> I want to keep this turn on/off mechanism simple but if it's needed I
> can manage the variable "cn_fork_enable" as a counter. Thus the callback
> could be something like:
> 
> static void cn_fork_callback(void *data)
> {
>   int start; 
>   struct cn_msg *msg = (struct cn_msg *)data;
> 
>   if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
>     memcpy(&start, msg->data, sizeof(cn_fork_enable));
>     if (start)
>       cn_fork_enable++;
>     else
>       cn_fork_enable > 0 ? cn_fork_enable-- : 0;
>   }
> }
> 
> 
> What do you think about this implementation? 
> 
> Guillaume

