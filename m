Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUDLVVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUDLVVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:21:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:15043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263088AbUDLVVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:21:41 -0400
Date: Mon, 12 Apr 2004 14:21:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems adding sysfs support to dvb subsystem
Message-Id: <20040412142131.432c7686@dell_ss3.pdx.osdl.net>
In-Reply-To: <407AFD5B.8010502@convergence.de>
References: <407AFD5B.8010502@convergence.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004 22:34:35 +0200
Michael Hunold <hunold@convergence.de> wrote:

> Hello all,
> 
> I'm currently trying to add proper sysfs support to the dvb subsystem, 
> but I'm stuck because I don't know if I'm on the right way. 8-(
> 
>  From the docs and existing drivers I read so far I concluded that 
> adding a new class via class_register(&dvb_class) is the way to go.
> 
> With this I get:
> /sys/class/dvb/
> 
> Now there can be several dvb adapters present in the system, each of 
> this adapter can have several "subsystems" (video decoder, audio 
> decoder, frontend ("tuner"), ...)

The sysfs directory layout is a logical representation of the underlying
data structures in the kernel.  Each directory (with exception of attribute
groups) has a 1:1 relation ship with a kobject.


> New adapters register themselves via dvb_register_adapter() and if this 
> was succesfull, they register their subsystems via dvb_register_device().
> 
> What I'd like to have is something like this, so I can add attributes to 
> the frontend for example:
> /sys/class/dvb/adapter0/frontend0/

Is there a dvb_adapter structure and a separate dvb_frontend
structure?  Are you prepared to ref count and dynamically allocate both
of them?

> 
> I wasn't able to find a driver that provides this simple "hierarchical" 
> order, so I did some experiments with little luck.
> 
> Creating this hierarchical order manually (like for "devfs") didn't 
> work, I get
>  > find: /sys/class/dvb/adapter0/frontend0: No such file or directory
> errors upon access:
> 
>  > sprintf((void*)&dvbdev->class_device.class_id, "adapter%d/%s%d", 
> adap->num, dnames[type], id);
>  > class_device_register(&dvbdev->class_device);
> 
> I then tried to find a way to first use class_device_register() with 
> adapter0  (which works of course), and then with class_device_register() 
> again with frontend0, but obviously I cannot connect these two 
> instances, because adapter doesn't have a "struct device" where I can 
> point the class_device.dev entry from frontend0 to... 8-(
> 
> I'd really appreciate if somebody could give me some design hints or 
> point me to some documentation that would help me out.
> 
> Thanks!
> Michael.
> 

You could use attribute groups if all you want to do is provide some
logical breakout of attributes inside one kobject.  That is what I did
to put the wireless and netstat elements in different directories for the
network devices.

Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
