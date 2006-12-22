Return-Path: <linux-kernel-owner+w=401wt.eu-S1752672AbWLVUv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbWLVUv6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbWLVUv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:51:58 -0500
Received: from web32913.mail.mud.yahoo.com ([209.191.69.113]:27059 "HELO
	web32913.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752672AbWLVUv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:51:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=V/J62QEfhpLZDGOU9LeoPgiugNB8adExCs1gQOONEvFXYYGaYPfNKvWoukjI8SdYSjEcOSkUk0RtIf1GpQQA3EPTO4Kpa0wkzulkyvz8hGbAdh3ONZSo43BFJFlsCUl1+BIBA+jyhCqdfnb6vvrwVbS8n7HxTgUQxCXGXwy20DE=;
X-YMail-OSG: F7CjS9gVM1ncnslRwZJN.yND0_1oybRz2ThFwRL0if.lcfqWzKBPn4EMon5RXyeD4L4W0lSRQuKKlUJoD.wFhDu1f8fU9_OPs9vJVTflZQNvdzm8nxwpSNeqhXnAHBpW.ZJwVezfGMAZt4GGQcIKR_RxHEH06pDMceEDl5fiVpStLEA.rykD4Oimq1vd
Date: Fri, 22 Dec 2006 12:51:56 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200612222059.50652.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <567505.6711.qm@web32913.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, this is a fundamental problem. You don't
> refcount
> a pointer, you refcount a data structure.
> But this is insufficient. We need to make 
> sure the pointer points to valid memory.

I understand. But a typical definition of ref-count 
requires the count in the data structure to be
equal to the number of outstanding pointers to this
data structure.
Every time we create a new pointer, the ref count
should be incremented. When pointer is erased, count
is decremented. 
This is what I meant as "ref counting a pointer".
If we follow this rule, then each pointer will
always point to a valid memory.

So, if we apply ref counting rules consistently,
then each pointer in serial_table should be
ref counted. This will completely break the current
code, which erases serial_table from destroy_serial,
which is called only when the ref count goes to 0,
which will never happen if serial_table is ref
counted.
However, this can be fixed if usb_serial_disconnect
will erase pointers in serial_table before
calling usb_serial_put.

Now, I am not yet 100% convinced that ref counting
will, indeed, work. Atomics are known to have
problems on SMP CPUs, which can reorder operations.
But I would not discard atomics yet.
Global mutex is go ugly.

John


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
