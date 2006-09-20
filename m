Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWITU7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWITU7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWITU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:59:14 -0400
Received: from [63.64.152.142] ([63.64.152.142]:57357 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751058AbWITU7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:59:13 -0400
From: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Subject: [RFC 0/6] TCP socket splice
Date: Wed, 20 Sep 2006 14:07:11 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: christopher.leech@intel.com
Message-Id: <20060920210711.17480.92354.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My name is Ashwini Kulkarni and I have been working at Intel Corporation for
the past 4 months as an engineering intern. I have been working on the 'TCP
socket splice' project with Chris Leech. This is a work-in-progress version
of the project with scope for further modifications.

TCP socket splicing:
It allows a TCP socket to be spliced to a file via a pipe buffer. First, to
splice data from a socket to a pipe buffer, upto 16 source pages(s) are pulled
into the pipe buffer. Then to splice data from the pipe buffer to a file,
those pages are migrated into the address space of the target file. It takes
place entirely within the kernel and thus results in zero memory copies. It is
the receive side complement to sendfile() but unlike sendfile() it is
possible to splice from a socket as well and not just to a socket.

Current Method:
                         + >  Application Buffer +
                         |                       |
        _________________|_______________________|_____________
                         |                       |
              Receive or |                       | Write
              I/OAT DMA  |                       |
                         |                       |
                         |                       V
                       Network              File System
                       Buffer                  Buffer
                         ^                       |
                         |                       |
        _________________|_______________________|_____________
                     DMA |                       | DMA
                         |                       |
       Hardware          |                       |
                         |                       V
                        NIC                     SATA
                                                                    
In the current method, the packet is DMA’d from the NIC into the network buffer.
There is a read on socket to the user space and the packet data is copied from
the network buffer to the application buffer. A write operation then moves the
data from the application buffer to the file system buffer which is then DMA'd
to the disk again. Thus, in the current method there will be one full copy of
all the data to the user space.

Using TCP socket splice:

                    Application Control
                         |
        _________________|__________________________________
                         |
                         |   TCP socket splice
                         | +---------------------+
                         | |     Direct path     |
                         V |                     V
                       Network              File System
                       Buffer                  Buffer
                         ^                       |
                         |                       |
        _________________|_______________________|__________
                     DMA |                       | DMA
                         |                       |
       Hardware          |                       |
                         |                       V
                        NIC                     SATA
                                                                    
In this method, the objective is to use TCP socket splicing to create a direct
path in the kernel from the network buffer to the file system buffer via a pipe
buffer. The pages will migrate from the network buffer (which is associated
with the socket) into the pipe buffer for an optimized path. From the pipe
buffer, the pages will then be migrated to the output file address space page
cache. This will enable to create a LAN to file-system API which will avoid the
memcpy operations in user space and thus create a fast path from the network
buffer to the storage buffer.

Open Issues (currently being addressed):
There is a performance drop when transferring bigger files (usually larger than
65536 bytes in size). Performance drop increases with the size of the file.
Work is in progress to identify the source of this issue.

We encourage the community to review our TCP socket splice project. Feedback
would be greatly appreciated.

--
Ashwini Kulkarni
