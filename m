Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUKPQW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUKPQW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKPQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:22:55 -0500
Received: from web52302.mail.yahoo.com ([206.190.39.97]:53379 "HELO
	web52302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262022AbUKPQWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:22:31 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=JX6JHsDIjD1WQqHEn/1obdkz+K0pygoWG6jSpuutCt5xss37SFYMxWqmHJ2uKVjW1Axu999LZ2GtkQ8Asm5oaQ3+L/EaBmZ5+KHGgKA01750NEn8fLj2jsL+A63ERa27k44A39QExwxiHg1+MmxsaCho0EdSYJ2jtqZIXRFa5Uk=  ;
Message-ID: <20041116162230.74768.qmail@web52302.mail.yahoo.com>
Date: Tue, 16 Nov 2004 08:22:30 -0800 (PST)
From: Anton Lavrentiev <anton_lavrentiev@yahoo.com>
Subject: Strange I/O errors for hard-disk driver with bad sectors
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a situation when a hard disk, which is on the warranty,
has got too many bad sectors, and has to be replaced with exact
same model of exact same geometry and characteristics.  Most data
is still readable (there are just few bad sectors), so I used
dd to transfer the contents to a new disk.

dd if=/dev/hdb1 of=/dev/hda1 conv=sync,noerror

What is strange is that dd reports multiple read failures
around certain sectors, like this (thus writing zeroes on the
output device in several consequtive sectors):

27559069+1 in
27559070+0 out

27559069+2 in
27559071+0 out

27559069+3 in
27559072+0 out

27559069+4 in
27559073+0 out

27559069+5 in
27559074+0 out

but in the kernel log, there are few messages about the same
sector number, 27559072, with LBA sector reported as 63 more
(which is usual offset for the 1st partition), but again
the reports are all for the same sector.

So here comes the question, does the kernel mean that only one
sector 27559072 is actually bad.  If so, why read() in dd for
sectors around the bad one had returned -1.  Looks like the kernel
reads sectors in bundles, and if a bad one falls within the bundle,
the entire read operation (even if it was about a good sector)
marked as failed?  Isn't it a bug if the kernel behaves this way,
causing dd to replace sectors which are not bad, with
zeroes on the output?

Or, there are indeed few bad sectors in a row that kernel
reports by using sector number of the first one, which it
couldn't read?

I also used dd to skip to the sectors that it reported as
unreadable, and read them one by one -- no success, but the
kernel keeps reporting the same "magic" sector number for
all these attempts:

dd if=/dev/hdb1 of=/dev/null skip=27559068 count=1 # OK
dd if=/dev/hdb1 of=/dev/null skip=27559069 count=1 # I/O Error
dd if=/dev/hdb1 of=/dev/null skip=27559070 count=1 # I/O Error
dd if=/dev/hdb1 of=/dev/null skip=27559071 count=1 # I/O Error
...etc...
dd if=/dev/hdb1 of=/dev/null skip=27559074 count=1 # OK

I use 2.4 series kernel and dd from fileutils 4.1.

Any help/clarification would be highly appreciated.

Please CC at my yahoo.com address, if possible.

Thanks!

Anton Lavrentiev


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
