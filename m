Return-Path: <linux-kernel-owner+w=401wt.eu-S1752037AbWLVTID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWLVTID (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWLVTID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:08:03 -0500
Received: from web32909.mail.mud.yahoo.com ([209.191.69.109]:40632 "HELO
	web32909.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752037AbWLVTIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:08:01 -0500
Message-ID: <20061222190800.3167.qmail@web32909.mail.mud.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LQHKtXgfTA9Izn54W/+HCEkIDe4uKmkbx8VojD3sld9Z7GvdGDJ9HOGmd6xFI64Jr1VS+A4wPTUGvKlKeED/OYvaXzcIJT32+Sfeo51VKOoltf8VoeATxTg1jAnFjO8M0O4PVJydAMBCn95TRVbaWZcjl7btWcjMmunLdRkhmu4=;
X-YMail-OSG: kxRfUvcVM1msKMuJ5JdvmU8Xgc5H6VxUjJD6dZaBWoyuJSzzBwADrCaLxY1HHXNgu1Bd4EJLSgcBOP.5.7P.J.KBhztRLy.4QKimFtCjntiH_omtx0MK0xaseUV1yVrB5aQUG9owP7s_05w-
Date: Fri, 22 Dec 2006 11:08:00 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
To: Oliver Neukum <oliver@neukum.org>, Greg KH <gregkh@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200612221914.41111.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This problem will need some deeper surgery probably
> involving
> removal of the refcounting.

Refcounting may be OK if used consistently. 
It is not OK when some pointers are ref-counted, 
but other (in serial_table) are not (like it is
in the current version).

As for the deeper surgery, what do you think about my
earlier suggestion to start by rewriting
usb_serial_probe
to fully initialize usb_serial before it is added to 
serial_table? 

So, instead of the current:
1. create_serial
...
2. mutex_lock(&table_lock);
3. get_free_serial (which inserts serial to
serial_table)
...
4. initializes serial
5. mutex_unlock(&table_lock);

we will get:

1. create_serial
2. initializes serial

3. add_serial_toserial_table  (with internal mutex
lock if needed)

Similar approach should be used in other places to
minimize the code executed under the mutex.

John

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
