Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSKYWWI>; Mon, 25 Nov 2002 17:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSKYWWH>; Mon, 25 Nov 2002 17:22:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:51920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265727AbSKYWWG>;
	Mon, 25 Nov 2002 17:22:06 -0500
Date: Mon, 25 Nov 2002 16:23:03 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <Matt_Domsch@Dell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: convert edd to use kobjects and sysfs.
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D680211A7E4@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.33.0211251618460.898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Nov 2002 Matt_Domsch@Dell.com wrote:

> > ChangeSet 1.855.4.11, 2002/10/31 12:37:07-08:00, mochel@osdl.org
> > 	convert edd to use kobjects and sysfs.
> 
> Pat, thanks for converting the EDD code to sysfs.  Is struct attribute going
> to grow some form of existence test, something like I had done before?

Crap. I saw your email from three weeks ago, and I think I even started 
replying to it. But, it must have got lost.. I'm really sorry about that. 

> > -static int
> > -edd_populate_dir(struct edd_device *edev)
> > -{
> > -	struct edd_attribute *attr;
> > -	int i;
> > -	int error = 0;
> > -
> > -	for (i = 0; (attr=def_attrs[i]); i++) {
> > -		if (!attr->test || (attr->test && !attr->test(edev))) {
> > -			if ((error = edd_create_file(edev, attr))) {
> > -				break;
> > -			}
> > -		}
> > -	}
> 
> This allows attributes to be on default_attrs[] but depending on presence of
> existence test (no test means true) and test result, not all attributes for
> all similar objects get files created.  This cleanly handles cases where not
> all attributes are implemented or valid for all objects of a given type, and
> keeps the object's directory free of extraneous invalid files.
> 
> There are two other alternatives I see:
> 1) Put all attributes on default_attrs, have them be created by
> kobject_register(), then immediately delete those which fail existence -
> calls to sysfs_remove_file().
> 2) Put only those attributes we know always exist on default_attrs, and
> separately register those others who pass their existence - which would
> duplicate the populate_dir() code from lib/kobject.c essentially - calls to
> sysfs_create_file().
> 
> Both of these violate the kobject abstraction.  I'd prefer to see an
> attribute existence test used in populate_dir().

I overlooked this part of your code, and will fix it. IMO, the proper
thing to do is Option #2 - only put those attributes we know exist in the
default_attrs[] array - and add the conditional attributes later. Though 
it does duplicate code, I'd rather favor the common case where default 
attributes really are default attributes, and don't need an existence 
test. 

	-pat


