Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUFYQmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUFYQmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbUFYQmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:42:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45552 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266795AbUFYQlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:41:25 -0400
Subject: Re: [PATCH] acpiphp extension for 2.6.7
From: Vernon Mauery <vernux@us.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Pat Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Jess Botts <botts@us.ibm.com>
In-Reply-To: <20040624214555.GA1800@us.ibm.com>
References: <1087934028.2068.57.camel@bluerat>
	 <20040624214555.GA1800@us.ibm.com>
Content-Type: text/plain
Message-Id: <1088181777.4749.11.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 09:42:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 14:45, Greg KH wrote: 
> > +int acpiphp_register_attention_info(struct acpiphp_attention_info *info)
> > +{
> > +	int retval = 0;
> > +	unsigned long flags;
> > +
> > +	if (!info || !info->owner || !info->set_attn || !info->get_attn)
> > +		retval = -1;
> > +	else {
> > +		spin_lock_irqsave(&attn_info_lock, flags);
> 
> Why lock here?  What could race?

If this function is only ever called from a module's init_module
function, then our global data is protected by the kernel's
module_mutex.  But is the assumption that it is never called from other
code safe to make?  It manipulates global data, so it needs to be
protected somehow...

> And why the irqsave lock?
Not sure.  That can be changed.

> > -static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
> > +static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
> >  {
> > +	int retval = -1;
> > +	unsigned long flags;
> > +	struct acpiphp_attention_info info;
> > +
> >  	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
> >  
> > -	switch (status) {
> > -		case 0:
> > -			/* FIXME turn light off */
> > -			hotplug_slot->info->attention_status = 0;
> > -			break;
> > -
> > -		case 1:
> > -		default:
> > -			/* FIXME turn light on */
> > -			hotplug_slot->info->attention_status = 1;
> > -			break;
> > +	spin_lock_irqsave(&attn_info_lock, flags);
> > +	memcpy(&info, &attention_info, sizeof(struct acpiphp_attention_info));
> > +	spin_unlock_irqrestore(&attn_info_lock, flags);
> 
> Again, why lock?  And why copy the whole structure?  And it's on the
> stack, which isn't very nice.  Same comment applies to the get_
> function.

Getting a local copy of the data structure within the lock ensures that
this function is reentrant.  But if we can make the same guarantee that
this funtion is called only on module_exit (again protected by the
module_mutex) then we can move to a pointer and no local lock.

> > +
> > +	if (info.set_attn && try_module_get(info.owner)) {
> > +		retval = info.set_attn(hotplug_slot, status);
> > +		module_put(info.owner);
> >  	}
> >  
> > -	return 0;
> > +	if (!retval)
> > +		hotplug_slot->info->attention_status = (status) ? 1 : 0;
> 
> Why change the value based on the return value of the call?  This
> shouldn't be set at all.

Oops.  This was a snippet of legacy code that was around before I
figured out how to read the LED value from hardware.  I will drop it.

--Vernon


