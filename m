Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSKVWNk>; Fri, 22 Nov 2002 17:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbSKVWNj>; Fri, 22 Nov 2002 17:13:39 -0500
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:47372 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S265285AbSKVWNi>; Fri, 22 Nov 2002 17:13:38 -0500
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <20BF5713E14D5B48AA289F72BD372D680211A7E4@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Re: convert edd to use kobjects and sysfs.
Date: Fri, 22 Nov 2002 16:20:42 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11C072313849850-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ChangeSet 1.855.4.11, 2002/10/31 12:37:07-08:00, mochel@osdl.org
> 	convert edd to use kobjects and sysfs.

Pat, thanks for converting the EDD code to sysfs.  Is struct attribute going
to grow some form of existence test, something like I had done before?

> -static int
> -edd_populate_dir(struct edd_device *edev)
> -{
> -	struct edd_attribute *attr;
> -	int i;
> -	int error = 0;
> -
> -	for (i = 0; (attr=def_attrs[i]); i++) {
> -		if (!attr->test || (attr->test && !attr->test(edev))) {
> -			if ((error = edd_create_file(edev, attr))) {
> -				break;
> -			}
> -		}
> -	}

This allows attributes to be on default_attrs[] but depending on presence of
existence test (no test means true) and test result, not all attributes for
all similar objects get files created.  This cleanly handles cases where not
all attributes are implemented or valid for all objects of a given type, and
keeps the object's directory free of extraneous invalid files.

There are two other alternatives I see:
1) Put all attributes on default_attrs, have them be created by
kobject_register(), then immediately delete those which fail existence -
calls to sysfs_remove_file().
2) Put only those attributes we know always exist on default_attrs, and
separately register those others who pass their existence - which would
duplicate the populate_dir() code from lib/kobject.c essentially - calls to
sysfs_create_file().

Both of these violate the kobject abstraction.  I'd prefer to see an
attribute existence test used in populate_dir().

Thoughts?

Thanks,
Matt


--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


