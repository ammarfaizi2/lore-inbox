Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTFCScA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTFCScA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:32:00 -0400
Received: from palrel12.hp.com ([156.153.255.237]:62374 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262165AbTFCSb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:31:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16092.60612.352739.581639@napali.hpl.hp.com>
Date: Tue, 3 Jun 2003 11:45:24 -0700
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: davidm@hpl.hp.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com
Subject: Re: fix TCP roundtrip time update code
In-Reply-To: <1054662070.701.6.camel@tux.rsn.bth.se>
References: <200306031552.h53FqknC023999@napali.hpl.hp.com>
	<1054662070.701.6.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 03 Jun 2003 19:41:11 +0200, Martin Josefsson <gandalf@wlug.westbo.se> said:

  Martin> (trimmed CC line and added netdev) On Tue, 2003-06-03 at
  Martin> 17:52, David Mosberger wrote:
  >> One of those very-hard-to-track-down, trivial-to-fix kind of
  >> problems: without this patch, TCP roundtrip time measurements
  >> will corrupt the routing cache's RTT estimates under heavy
  >> network load (the bug causes RTAX_RTT to go negative, but since
  >> its type is u32, you end up with a huge positive value...).  From
  >> there on, later TCP connections quickly will go south.

  >> The typo was introduced 8 months ago in v1.29 of the file by the
  >> patch entitled "Cleanup DST metrics and abstrct MSS/PMTU
  >> further".

  Martin> I tested this patch and it looks like it has cured my
  Martin> mysterious TCP stalls.

Yes, this sounds reasonable.  I wasn't very clear on this point, but
"by going south" I meant that TCP is starting to misbehave.  In
particular, you'll likely end up with the kernel aborting ESTABLISHED
TCP connections with extreme prejudice (and in violation of the TCP
protocol), because it thought that it had been unable to communicate
with the remote end for a _very_ long time.  The net effect typically
is that you end up with one end having a connection that's in the
ESTABLISHED state and the other end having no trace of that
connection.

	--david
