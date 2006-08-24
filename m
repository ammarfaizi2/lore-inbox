Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWHXLF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHXLF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWHXLF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:05:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11454 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751110AbWHXLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:05:27 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1156365357.6720.87.camel@localhost.localdomain>
References: <1156359937.6720.66.camel@localhost.localdomain>
	 <20060823192733.GG28594@kvack.org>
	 <1156365357.6720.87.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 12:26:55 +0100
Message-Id: <1156418815.3007.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-23 am 13:35 -0700, ysgrifennodd Kylene Jo Hall:
> Example: The current process is running at the USER level and writing to
> a USER file in /home/user/.  The process then attempts to read an
> UNTRUSTED file.  The current process will become UNTRUSTED and the read
> allowed to proceed but first write access to all USER files is revoked
> including the ones it has open.

Which really doesn't mean anything in many cases because there are many
ways to get data out of a file handle once you had it opened for write
including sharing via non file handle paths.

You also have to deal with existing mmap() mappings and outstanding I/O.

So here are some ways to break it

	SysV shared memory
	mmap

or just race it:

	Open the USER file
	create a new thread
	thread #1 create a pipe to a new process ("receiver")
	thread #1 fill pipe
	thread #1 issue write of buffer that will hold secret data
			[blocks after check for rights]
	
	thread #2
		wait for thread #1 to block
		read secret data into buffer
		send signal to "receiver"


	receiver now empties the pipe, the write completes and I get the
goodies.

This is why you need a proper implementation of revoke(2) in Linux. You
can't really do it any more easily.


