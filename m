Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbTLEUqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTLEUqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:46:08 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.169]:39339 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id S264384AbTLEUqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:46:02 -0500
X-Biglobe-Sender: <slee@muf.biglobe.ne.jp>
Date: Sat, 06 Dec 2003 05:45:59 +0900
From: Stephen Lee <mukansai@emailplus.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Cc: torvalds@osdl.org, scott.feldman@intel.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031204102420.2aa43b43.davem@redhat.com>
References: <20031204213030.2B75.MUKANSAI@emailplus.org> <20031204102420.2aa43b43.davem@redhat.com>
Message-Id: <20031206054545.A192.MUKANSAI@emailplus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
> Stephen Lee <mukansai@emailplus.org> wrote:
> > Yes, turning off TSO with ethtool fixed it (tested on 2.6.0-test11).  At
> > least we have a workaround now.
> 
> This workaround explains everything.  The TSO packets have to be
> "un-TSO'd" in order for netfilter to look at the packet and parse
> the contents.  This means copying all the data around, allocating
> several networking buffers, etc.

Sorry if I am talking out of my ass, but can this be solved in one
of the following ways?  (But it would seem 2, 3 or 4 are not 2.6
material).

(1) Turn off TSO altogether (Duh).

(2) Do what you suggest, but pass the original TSO packet to the
ethernet chip.  Still have to copy around, but save us some interrupts? 
(Could introduce subtle bugs if we un-TSO it differently from the
hardware).

(3) Just pass the original packet to netfilter with a special flag and
have netfilter "deduce" what the rest of the headers are.

(4) Similar idea, but totally separate the headers and the payload.  (I
think this was suggested somewhere for some other problem...  I read it
in one of the archives but can't find it now)  Then we can just generate
a set of "un-TSO'd" headers (with appropriate pointers into the big
payload) for netfilter to look at, but leave the original for passing to
hardware eventually.

Stephen

