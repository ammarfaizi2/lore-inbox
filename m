Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTKZXX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTKZXX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:23:26 -0500
Received: from pat.uio.no ([129.240.130.16]:695 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264371AbTKZXXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:23:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16325.13797.417933.122067@charged.uio.no>
Date: Wed, 26 Nov 2003 18:23:17 -0500
To: Andi Kleen <ak@suse.de>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
In-Reply-To: <20031127000145.61187530.ak@suse.de>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<shsllq3yy2u.fsf@charged.uio.no>
	<20031127000145.61187530.ak@suse.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andi Kleen <ak@suse.de> writes:

     > Current sunrpc does two recvmsgs for each record to first get
     > the record length and then the payload.

     > This means you take all the locks and other overhead twice per
     > packet.

     > Having a special function that peeks directly at the TCP
     > receive queue would be much faster (and falls back to normal
     > recvmsg when there is no data waiting)

Oh, right... That would be the server code you are thinking of, then.

The client already does something like this. I've added a function
tcp_read_sock() that is called directly from tcp_data_ready() and
hence fills the page cache directly from within the softirq.

There are a still few inefficiencies with this approach, though. Most
notable is the fact that you need to call kmap_atomic() several times
per page since the socket lower layers will usually be feeding you 1
skb at a time. I thought you might be referring to those (and that you
might have a good solution to propose ;-))

Cheers,
  Trond
