Return-Path: <linux-kernel-owner+w=401wt.eu-S932900AbWLST2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWLST2U (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932911AbWLST2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:28:20 -0500
Received: from web32915.mail.mud.yahoo.com ([209.191.69.115]:43232 "HELO
	web32915.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932900AbWLST2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:28:19 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 14:28:19 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=K12+MflD8Q8kyaum/X53NyINLCgi3GmNckrM5OabwnS8tMSWimz4mbmGQvE8/1r6qyCsbKDWQbSqFPquVGX6widk5ab1Yw5vW03YoAwpxxfd5KuJIOBP1C8PoGUNJLVrV1UYTJUcOEJam06rTrL+ZetXrLlr8ojfhKGRy+LMLco=;
X-YMail-OSG: eHRx5_MVM1mjkO2Nkv0zsW0_0q9Bag8n1Hrz3kHnAKSaC4XHI2NvXHvSZ8YfuCTjxXiFYjJuhiQFRutLurRpLPBjbNCLGiUHOqof9pWKSjKshH0lqDV7PJQKLv9S7u12AkBI2AuLqISlXrc-
Date: Tue, 19 Dec 2006 11:21:38 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Possible race condition in usb-serial.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <247966.89742.qm@web32915.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I read usb-serial.c code (in 2.6.19) and I cannot
figure out how it is
supposed to prevent race condition and premature
deletion of usb_serial
structure. I see that the code attempts to protect
usb_serial by ref
counting, but it does not appear to be correct. I am
not 100% sure in my
findings, so I will appreciate if somebody will double
check.

Suppose:
A:->usb_serial_disconnect
A:  -> usb_serial_put (serial);
A:   -> kref_put
A:    if ((atomic_read(&kref->refcount) == 1)
             Suppose refcount is 1
A:       -> release -> destroy_serial

B: -> serial_open
B:  -> usb_serial_get_by_index
B:     serial = serial_table[index]
B:     -> kref_get(&serial->kref);

A:        -> return_serial(serial);
A:        serial_table[serial->minor + i] = NULL;
A:          -> kfree (serial);

B:   continue to use serial, which was already freed.

So, I am missing something or the USB serial driver is
broken?

As I understand it, the correct use of ref counted
pointers it to increment
ref count of an object for each outstanding pointer to
this object. But
usb-serial.c keeps one or more pointers to usb_serial
in serial_table, and
does not increments the counter for any of them!

Thank you
John




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
