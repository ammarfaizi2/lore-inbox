Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSFFLTL>; Thu, 6 Jun 2002 07:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSFFLTK>; Thu, 6 Jun 2002 07:19:10 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:29624 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S316951AbSFFLTJ>; Thu, 6 Jun 2002 07:19:09 -0400
Message-Id: <200206061119.g56BJ7m19758@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: device model documentation 3/3
Date: Thu, 6 Jun 2002 15:19:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, Arnd Bergmann <arndb@de.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0206051128150.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 20:56, Patrick Mochel wrote:

> No, that's a race that would affect all modular drivers. Ideally, we would
> want to pin the module in memory on file open, then decrement the usage
> count on close. We could do this by adding a struct module field to struct
> driver_file_entry...

Hmm, adding anything to driver_file_entry will make it take twice
as much memory (it's 8 * sizeof(void*) now, allocated with kmalloc), 
so I wouldn't want to have that if there is another way.

Adding an owner field to struct device is probably not enough if bridge
devices should be able to add files to their children. You would need
at least two struct module pointers then. Also, it requires every device
driver to initialize the owner field (at least one for its struct 
device_driver).

An alternative might be a rw_semaphore in struct device that protects
the store and show callbacks in its files. On module unload, rmmod would
just have to wait on the semaphore if it is held by any readers.
Of course that protects only against the race between module unload
and file open, but there can be others of anyone does get_device without
incrementing the use counts for the right modules.

	Arnd <><
