Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTJNXEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTJNXEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:04:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:27276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262050AbTJNXEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:04:35 -0400
Date: Tue, 14 Oct 2003 16:13:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Russell King <rmk@arm.linux.org.uk>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in init_i82365 wrt sysfs
In-Reply-To: <20031010090104.A23806@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0310141605160.803-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Due to the number of cases that we're encountering with PCMCIA, I'm
> beginning to wonder if the driver model could be fixed to be more kind
> to PCMCIA by avoiding some of these ordering dependencies.  None of this
> would be a problem if the driver model would allow PCI device drivers to
> register PCI devices while their probe or remove functions were executing.

I am open to that suggestion, but after doing some tinkering, I've found 
that it would be very painful. 

The problem is that we hold the bus's rwsem across the driver binding 
sequence. This includes walking either the list of devices or drivers 
regsitered with the bus and calling ->probe().

We could make the locking more fine-grained, and only hold it when 
actually iterating over the list, and dropping it on each iteration. 
However, I'm strongly opposed to it because it gets ugly and fragile 
very quickly. I'd much rather protect the entire iteration, since it's 
easy to understand. 

So, that means you simply cannot register devices that are on the same bus
from inside a ->probe() function, or unregister them in ->remove(). At
least not the way it is. Any suggestions?

Thanks,


	Pat

