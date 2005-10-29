Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVJ2Uy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVJ2Uy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVJ2Uy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:54:26 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:63406 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932159AbVJ2UyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:54:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 0/6] swsusp: rework swap handling
Date: Sat, 29 Oct 2005 21:58:10 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510292158.11089.rjw@sisk.pl>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches divides swsusp into two functionally
independent subsystems:

- the snapshot-handling part responsible for creating and populating
the snapshot-related data structure which is the list of page backup
entries aka pagedir,

- the swap-handling part responsible for writing the snapshot data to
and reading it from swap.

On suspend the snapshot-handling part creates the system snapshot
and makes the data stored in the snapshot available to the swap-handling
part via an interface function allowing it to transfer the data as
a series of consecutive data pages, in a specific order.  The swap-handling
part writes the data pages to a swap partition is such a way that they
can be read in exactly the same order in which they have been saved.

On resume the snapshot-handling part is invoked by the swap-handling
part to create the pagedir.  Then, the swap-handling part is allowed to
send it, with the help of an interface function, data pages that are used
to populate the snapshot data structure.  It is assumed that the data
pages will be sent in the same order in which they have been received
by the swap-handling part on suspend.  Finally, the system state (from
before suspend) is restored by the snaphot-handling part from the
data structure handled by it.

>From the point of view of the swap-handling part, the contents of the
data pages provided by the snapshot-handling do not matter at all.
It handles each data page in the same way without analyzing its
contents and the snapshot-handling part is responsible for recognizing
the metadata and using them as appropriate.  Consequently, in principle
the swap-handling part can be replaced with a user-space process and
the interface functions used in transferring data between the two parts
of swsusp can be replaced with a relatively simple kernel-user interface
in the future.

The approach used in this series of patches has some additional benefits:
1) the size of the pagedir is reduced by 1/4 which causes some more memory to
be available on resume,
2) the amount of metadata written to swap is reduced by 3/4,
3) the artificial limitation on the pagedir size, imposed by the size of the
swsusp_info structure, is lifted,
4) the size of swsusp_info structure is reduced so it can be merged with the
swsusp_header structure in the future,
5) the swap-handling part does not use any global variables related to the
snapshot data structure,
6) the __nosavedata variables are almost eliminated (on x86-64 the last of them
is the in_suspend variable).

I have divided the changes into some more or less logical steps for clarity.
Although the code has been designed as proof-of-concept, it is functional
and has been tested on x86-64, except for the cryptographic functionality
and error paths.

For your convenience the patches are available from:
http://www.sisk.pl/kernel/patches/2.6.14-rc5-mm1/

I will very much appreciate any comments, remarks and suggestions.

Greetings,
Rafael

