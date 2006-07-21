Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWGUJMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWGUJMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 05:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWGUJMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 05:12:52 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:9112 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1161016AbWGUJMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 05:12:52 -0400
Message-ID: <44C099D2.5030300@s5r6.in-berlin.de>
Date: Fri, 21 Jul 2006 11:09:38 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060720190529.GC7643@lumumba.uhasselt.be>	 <200607210850.17878.eike-kernel@sf-tec.de> <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> <44C07CB2.1040303@pobox.com>
In-Reply-To: <44C07CB2.1040303@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pekka Enberg wrote:
>> On 7/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>>> > -     if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
>>> > +     handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
>>> > +     if (!handle)
>>> >               return NULL;
>>>
>>> sizeof(*handle)?
>> 
>> In general, yes. However, some maintainers don't like that, so I would
>> recommend to keep them as-is unless you get a clear ack from the
>> maintainer to change it.

I suggest:
 - check if "sizeof(type)"->"sizeof(*ptr)" is correct
 - if yes, change it
 - do this for all kmalloc + kzalloc in a file you touched, or
   better yet for all kmalloc + kzalloc in a driver or subsystem you
   touched
Maintainers who don't agree can always post a NAK. There are hardly any
special cases which speak against that change --- provided the change is
done for the whole subsystem.

> Strongly agreed.  Follow the style of the existing code as closely as 
> possible, and resist the temptation of making little "improvements" 
> while you are doing a task...

The 2nd half of this statement is a good and important rule. But look at
this particular case. The patch does (or could) contain
 - consolidation of kmalloc+memset/0 -> kzalloc where correct,
 - better style of the size argument where correct,
 - whitespace style adjustments of the touched regions.
All of these changes, if done correct, are true improvements WRT
programming idioms. IMO it's a single task, therefore adheres to that
rule. I'd only split this kind of patches if separately maintained
subsystems are touched.

As for the 1st half of this statement, "follow the style of existing
code as closely as possible": This is problematic in light of the more
important rule "follow CodingStyle".

I suggest to follow existing style if small changes are introduced and
the existing code mostly complies to CodingStyle. If existing code with
small deviations from CodingStyle is touched, the potential loss of
readability by partial conversion to CodingStyle may be negligible. If
existing code with bigger deviations from CodingStyle is touched, the
author of a patch should consider to provide an additional patch before
or after that with a complete conversion to CodingStyle. (I took the
time to do this on a few occasions too.)
-- 
Stefan Richter
-=====-=-==- -=== =--==
http://arcgraph.de/sr/
