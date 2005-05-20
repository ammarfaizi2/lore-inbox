Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVETHyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVETHyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVETHyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:54:43 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:48597 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261329AbVETHya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:54:30 -0400
Date: Fri, 20 May 2005 09:46:29 +0200 (CEST)
To: greg@kroah.com
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <v0eBIb5C.1116575188.8501740.khali@localhost>
In-Reply-To: <20050519213551.GA806@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Yani Ioannou" <yani.ioannou@gmail.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <lm-sensors@lm-sensors.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

> Hm, which makes me want to go look at trying to convert those attributes
> to an array right now...

I should probably develop my own thoughts and plans at this point then.

If you consider all the attributes of a given hardware monitoring driver,
you'll notice that, from a functional point of view, they can be
represented as two-dimension arrays rather than one-dimension ones. For
example, the temperature-related files of the it87 driver could be
represented this way:

+-------------+-------------+-------------+-------------+
| temp1_input | temp1_min   | temp1_max   | temp1_type  |
+-------------+-------------+-------------+-------------+
| temp2_input | temp2_min   | temp2_max   | temp2_type  |
+-------------+-------------+-------------+-------------+
| temp3_input | temp3_min   | temp3_max   | temp3_type  |
+-------------+-------------+-------------+-------------+

In the patch I just proposed, I made the choice to consider the colums of
the array above to create arrays of attributes, each column becoming a
different array. While it may sound like a sane choice, espcially when
there are many similar channels (e.g. voltages), it might not be the
best choice in the long run, for the following reason.

All measurement channels of the IT8705F and IT8712F can be individually
disabled. While this feature was almost not used so far, I think we
should have the driver not create interface files for disabled inputs.
In the case of temperature channels which can be dynamically enabled and
disabled. it would even make sense to dynamically create and delete
related sysfs files. Doing so would allow for memory savings and would
also be less error-prone for the user (presenting an interface for
disabled features is quite confusing IMHO).

For this reason, considering the lines of the array above, rather than
its columns, in order to define arrays of attributes, may be more subtle
and flexible in the long run.

Thanks
--
Jean Delvare
