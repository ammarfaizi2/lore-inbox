Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUIAQeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUIAQeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIAQbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:31:18 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:8676 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S267653AbUIAQ1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:27:34 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Peter Astrand <peter@cendio.se>
Date: Wed, 1 Sep 2004 18:27:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: ncpfs problems
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <255B8A94A7B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Sep 04 at 15:59, Peter Astrand wrote:
> > > * Some files are impossible to remove, for example the files in 
> > > ~/.kde/socket-dhcp-253-234: An unlink returns EBUSY:
> > > 
> > > unlink("kdeinit_maggie_2")              = -1 EBUSY (Device or resource busy)
> > > 
> > > Do you have any ideas what can cause this? Do you consider ncpfs stable
> > > enough to be used for the home directory? 
> > 
> > File is open... You cannot remove opened files from Netware filesystem.
> > I cannot think about any other reason why you should get EBUSY.
> 
> It might have something to do with open files, but in that case, the
> behaviour is not consistent. I've just did a quick test with "cat
> > foo.txt", and was able to delete the file while it was still open:
> 
> # ls -l /proc/21642/fd
> ...
> l-wx------  1 adam 1000 64 Sep  1 15:39 1 -> /home/adam/foo.txt (deleted)
> ...

ncp_unlink closes file on server if there is no read or write
operation in progress - see ncp_make_open, ncp_inode_close and
ncp_make_closed: ncp_make_open opens file on server, ncp_inode_close
marks file as being "closable" and ncp_make_closed closes file unless
someone is in ncp_make_open - ncp_inode_close region.

Cannot be kdeinit_maggie_2 opened by someone else?

BTW, ncpfs is "single threaded" because protocol itself is single
threaded - you can have only one outstanding request. Even with TCP
transport which could allow more than one outstanding request, leaving
synchronization on TCP level, if you send data to server while
it processes another request some server versions return back 9999,
server busy, instead of leaving received data in the queue until
previous request is satisfied :-(

Actually with 2.6.x fs/ncpfs/sock.c changing code to not call
ncp_abort_connection() when something goes wrong should not be that
hard. Only problem is that ncp_request_reply structure is allocated
on caller stack, and so you must kill receiver (ncpdgram_rcv_proc/
ncptcp_rcv_proc) before you release this structure.

But main question is whether it is really needed... It works this way
since day #1 (old kernels actually used SIGKILL|SIGSTOP, making
debugging of processes using ncpfs filesystem almost impossible, yet
nobody complained).
                                                Petr Vandrovec
                                                

