Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVEOMG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVEOMG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVEOMG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:06:29 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:42213 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S262818AbVEOMGT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:06:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Date: Sun, 15 May 2005 13:50:04 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>
References: <200505132117.37461.arnd@arndb.de> <1116138546.5095.6.camel@gaston> <200505151208.54229.arnd@arndb.de>
In-Reply-To: <200505151208.54229.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505151350.05692.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 15 Mai 2005 12:08, Arnd Bergmann wrote:
> On Sünndag 15 Mai 2005 08:29, Benjamin Herrenschmidt wrote:
> > Why not just write(pc) to start and read back status from the same
> > file ?

I just remembered the strongest reason against using write() to set
the instruction pointer: It breaks signal delivery during execution
of SPU code. With an ioctl or system call based interface, the kernel
simply updates the instruction pointer in process memory before
calling a signal handler. When/if the signal handler returns, it
does the same call again with the updated argument and the SPU
continues to fetch code at the point where it stopped.

If I do a read() based interface, there are no input parameters
at all, so restarted system calls work as well.

How about this one:

read() starts execution and returns the status value in a four
byte buffer.
Calling lseek() on the "run" file updates the instruction pointer,
so the library call can work like this plus error handling:

extern char *mapped_local_store;
uint32_t status;
int runfd = open("run", O_RDONLY);
lseek(runfd, INITIAL_INSTRUCTION, SEEK_SET);
do {
	read(runfd, &status, 4);
	if (status == SPU_DO_LIBRARY_CALL) {
		size_t arg = lseek(runfd, 4, SEEK_CUR) - 4;
		do_library_call(mapped_local_store + arg);
	}
} while (status != SPU_EXIT);

	Arnd <><
